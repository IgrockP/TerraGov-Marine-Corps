/mob/new_player
	invisibility = INVISIBILITY_MAXIMUM
	stat = DEAD
	density = FALSE
	canmove = FALSE
	anchored = TRUE
	hud_type = /datum/hud/new_player
	var/datum/job/assigned_role
	var/datum/squad/assigned_squad
	var/mob/living/new_character
	var/ready = FALSE
	var/spawning = FALSE
	///The job we tried to join but were warned it would cause an unbalance. It's saved for later use
	var/datum/job/saved_job


/mob/new_player/Initialize()
	if(length_char(GLOB.newplayer_start))
		var/turf/spawn_loc = get_turf(pick(GLOB.newplayer_start))
		forceMove(spawn_loc)
	else
		forceMove(locate(1, 1, 1))
	lastarea = get_area(loc)
	GLOB.new_player_list += src
	return ..()


/mob/new_player/Destroy()
	if(ready)
		GLOB.ready_players -= src
	GLOB.new_player_list -= src
	assigned_role = null
	assigned_squad = null
	new_character = null
	return ..()


/mob/new_player/proc/check_playerpolls()
	var/output
	if (SSdbcore.Connect())
		var/isadmin = FALSE
		if(client?.holder)
			isadmin = TRUE
		var/datum/db_query/query_get_new_polls = SSdbcore.NewQuery({"
			SELECT id FROM [format_table_name("poll_question")]
			WHERE (adminonly = 0 OR :isadmin = 1)
			AND Now() BETWEEN starttime AND endtime
			AND deleted = 0
			AND id NOT IN (
				SELECT pollid FROM [format_table_name("poll_vote")]
				WHERE ckey = :ckey
				AND deleted = 0
			)
			AND id NOT IN (
				SELECT pollid FROM [format_table_name("poll_textreply")]
				WHERE ckey = :ckey
				AND deleted = 0
			)
		"}, list("isadmin" = isadmin, "ckey" = ckey))
		if(!query_get_new_polls.Execute())
			qdel(query_get_new_polls)
			return
		if(query_get_new_polls.NextRow())
			output = TRUE
		else
			output = FALSE
		qdel(query_get_new_polls)
		if(QDELETED(src))
			return null
		return output

/mob/new_player/Stat()
	. = ..()

	if(!SSticker)
		return

	if(statpanel("Status"))

		if(SSticker.current_state == GAME_STATE_PREGAME)
			stat("Time To Start:", "[SSticker.time_left > 0 ? SSticker.GetTimeLeft() : "(DELAYED)"]")
			stat("Players: [length_char(GLOB.player_list)]", "Players Ready: [length_char(GLOB.ready_players)]")
			for(var/i in GLOB.player_list)
				if(isnewplayer(i))
					var/mob/new_player/N = i
					stat("[N.client?.holder?.fakekey ? N.client.holder.fakekey : N.key]", N.ready ? "Playing" : "")
				else if(isobserver(i))
					var/mob/dead/observer/O = i
					stat("[O.client?.holder?.fakekey ? O.client.holder.fakekey : O.key]", "Observing")


/mob/new_player/Topic(href, href_list[])
	. = ..()
	if(.)
		return
	if(!client)
		return

	if(src != usr)
		return

	if(SSticker?.mode?.new_player_topic(src, href, href_list))
		return // Delegate to the gamemode to handle if they want to

	switch(href_list["lobby_choice"])
		if("show_preferences")
			client.prefs.ShowChoices(src)


		if("ready")
			toggle_ready()


		if("refresh")
			src << browse(null, "window=playersetup")


		if("observe")
			try_to_observe()


		if("late_join")
			attempt_late_join(href_list["override"])

		if("manifest")
			view_manifest()

		if("lore")
			view_lore()

		if("marines")
			view_marines()

		if("aliens")
			view_aliens()

		if("SelectedJob")
			if(!SSticker)
				return
			if(!GLOB.enter_allowed)
				to_chat(usr, span_warning("Spawning currently disabled, please observe."))
				return
			var/datum/job/job_datum = locate(href_list["job_selected"])
			if(!isxenosjob(job_datum) && (SSmonitor.gamestate == SHUTTERS_CLOSED || (SSmonitor.gamestate == GROUNDSIDE && SSmonitor.current_state <= XENOS_LOSING)))
				var/datum/job/xeno_job = SSjob.GetJobType(/datum/job/xenomorph)
				if((xeno_job.total_positions-xeno_job.current_positions) > GLOB.alive_xeno_list.len * TOO_MUCH_BURROWED_PROPORTION)
					if(tgui_alert(src, "There is a lack of xenos players on this round, unbalanced rounds are unfun for everyone. Are you sure you want to play as a marine? ", "Warning : the game is unbalanced", list("Yes", "No")) != "Yes")
						return
			if(!SSticker.mode.CanLateSpawn(src, job_datum)) // Try to assigns job to new player
				return
			SSticker.mode.LateSpawn(src)

		if("continue_join")
			DIRECT_OUTPUT(usr, browse(null, "window=xenosunbalanced"))
			if(!saved_job)
				return
			if(!SSticker.mode.CanLateSpawn(src, saved_job)) // Try to assigns job to new player
				return
			SSticker.mode.LateSpawn(src)

		if("reconsider")
			DIRECT_OUTPUT(usr, browse(null, "window=xenosunbalanced"))

	if(href_list["showpoll"])
		handle_playeR_DBRANKSing()
		return

	if(href_list["viewpoll"])
		var/datum/poll_question/poll = locate(href_list["viewpoll"]) in GLOB.polls
		poll_player(poll)

	if(href_list["votepollref"])
		var/datum/poll_question/poll = locate(href_list["votepollref"]) in GLOB.polls
		vote_on_poll_handler(poll, href_list)

/datum/game_mode/proc/observe_respawn_message()
	return "\nYou might have to wait a certain time to respawn or be unable to, depending on the game mode!"

/datum/game_mode/infestation/observe_respawn_message()
	return "\nYou will have to wait at least [SSticker.mode?.respawn_time * 0.1 / 60] minutes before being able to respawn as a marine!"

/mob/new_player/proc/late_choices()
	var/list/dat = list("<div class='notice'>Round Duration: [DisplayTimeText(world.time - SSticker.round_start_time)]</div>")
	if(!GLOB.enter_allowed)
		dat += "<div class='notice red'>You may no longer join the round.</div><br>"
	var/forced_faction
	if(SSticker.mode.flags_round_type & MODE_TWO_HUMAN_FACTIONS)
		if(faction in SSticker.mode.get_joinable_factions(FALSE))
			forced_faction = faction
		else
			forced_faction = tgui_input_list(src, "What faction do you want to join", "Faction choice", SSticker.mode.get_joinable_factions(TRUE))
			if(!forced_faction)
				return
	dat += "<div class='latejoin-container' style='width: 100%'>"
	for(var/cat in SSjob.active_joinable_occupations_by_category)
		var/list/category = SSjob.active_joinable_occupations_by_category[cat]
		var/datum/job/job_datum = category[1] //use the color of the first job in the category (the department head) as the category color
		dat += "<fieldset class='latejoin' style='border-color: [job_datum.selection_color]'>"
		dat += "<legend align='center' style='color: [job_datum.selection_color]'>[job_datum.job_category]</legend>"
		var/list/dept_dat = list()
		for(var/job in category)
			job_datum = job
			if(!IsJobAvailable(job_datum, TRUE, forced_faction))
				continue
			var/command_bold = ""
			if(job_datum.job_flags & JOB_FLAG_BOLD_NAME_ON_SELECTION)
				command_bold = " command"
			var/position_amount
			if(job_datum.job_flags & JOB_FLAG_HIDE_CURRENT_POSITIONS)
				position_amount = "?"
			else if(job_datum.job_flags & JOB_FLAG_SHOW_OPEN_POSITIONS)
				position_amount = "[job_datum.total_positions - job_datum.current_positions] open positions"
			else
				position_amount = job_datum.current_positions
			dept_dat += "<a class='job[command_bold]' href='byond://?src=[REF(src)];lobby_choice=SelectedJob;job_selected=[REF(job_datum)]'>[job_datum.title] ([position_amount])</a>"
		if(!length_char(dept_dat))
			dept_dat += span_nopositions("No positions open.")
		dat += jointext(dept_dat, "")
		dat += "</fieldset><br>"
	dat += "</div>"
	var/datum/browser/popup = new(src, "latechoices", "Choose Occupation", 680, 580)
	popup.add_stylesheet("latechoices", 'html/browser/latechoices.css')
	popup.set_content(jointext(dat, ""))
	popup.open(FALSE)


/mob/new_player/proc/view_manifest()
	var/dat = GLOB.datacore.get_manifest(ooc = TRUE)

	var/datum/browser/popup = new(src, "manifest", "<div align='center'>Crew Manifest</div>", 400, 420)
	popup.set_content(dat)
	popup.open(FALSE)

/mob/new_player/proc/view_lore()
	var/output = "<div align='center'>"
	output += "<a href='byond://?src=[REF(src)];lobby_choice=marines'>Корпус морпехов TerraGov</A><br><br><a href='byond://?src=[REF(src)];lobby_choice=aliens'>Улей ксеноморфов</A>"
	output += "</div>"

	var/datum/browser/popup = new(src, "lore", "<div align='center'>Текущий год: [GAME_YEAR]</div>", 240, 300)
	popup.set_content(output)
	popup.open(FALSE)

/mob/new_player/proc/view_marines()
	var/output = "<div align='center'>"
	output += "<p>Вглядываясь в оглушительную пустоту космоса, вы думаете со сколькими угрозами человечеству вам придется столкнуться и какая ещё угроза только ждет своего часа.<br/><br/>Миссия <b>корпуса морской пехоты TerraGov</b> заключается в поддержании и принуждении к соблюдению космического закона на территории сверхгосударства. Корпус морпехов обязан защищать территорию самой Терры, солнечную систему и колонии за её пределами. Братство морской пехоты состоит из добровольцев с разных миров и слоев общества, готовых отдать свою жизнь ради высшей цели защиты этого самого общества, из которого они вышли.<br/><br/>Пройдя через очередную мясорубку, командир вновь загнал всех в криокапсулы в ожидании миссии. Корабль вышел на орбиту новой планеты. И вот вы вновь ощущаете тяжесть от долгого сна, просыпаясь лишь затем, что бы начать новую войну.<br/><br/>Наши враги, такие как мятежные против закона TerraGov колонии, несущие хаос Сыны Марса, и всепожирающие ульи ксеноморфов желают лишь одного – нашей смерти. Но нас направляет воля TerraGov и у нас нет права умирать. Мы щит оберегающий верных граждан и меч карающий врагов TerraGov. Поражение и смерть — это удел людей, а мы — солдаты морской пехоты!</p>"
	output += "</div>"

	var/datum/browser/popup = new(src, "marines", "<div align='center'>Корпус морпехов TerraGov</div>", 480, 600)
	popup.set_content(output)
	popup.open(FALSE)

/mob/new_player/proc/view_aliens()
	var/output = "<div align='center'>"
	output += "<p>Вглядываясь в мелодичную насыщенность космоса, вы думаете о бесконечных мирах лишь ожидающих жатвы и о том, что все живое должно стать пищей для роста улья.<br/><br/>Из глубины темного космоса пугающего своей неизвестностью мира пришел неописуемый кошмар человечества - <b>ксеноморфы</b>. Чрезвычайно опасные инопланетные формы жизни, разделенные в разные ульи под управлением королев-матерей, застали миры миры TerraGov и Nanotrasen врасплох во время их открытия в 2414 году. Они разделены на касты, каждая из которых имеет свою специализацию схожую с родами войск. Устройство ульев, идеальная координация их атак и самое главное, ненасытный голод привели к потере многих человеческих миров. Связь с колониями была потеряна, а космическая карта потемнела. На одной из потемневших планет после нескольких дней жатвы одним из ульев королева почувствовала прибытие чужеродного железного улья на орбите.<br/><br/>Закончив жатву в этом мире, вы двинетесь в следующий, так же как и было с многими мирами до этого. По той причине, что улей живет лишь с целью постоянного роста и ассимилирования всего живого. У всех существ, встреченных вами, есть лишь право быть поглощенными... во благо улья и королевы-матери.</p>"
	output += "</div>"

	var/datum/browser/popup = new(src, "aliens", "<div align='center'>Улей ксеноморфов</div>", 480, 600)
	popup.set_content(output)
	popup.open(FALSE)




/mob/new_player/Move()
	return FALSE


/mob/new_player/proc/close_spawn_windows(mob/user)
	if(!user)
		user = src
	DIRECT_OUTPUT(user, browse(null, "window=latechoices")) //closes late choices window
	DIRECT_OUTPUT(user, browse(null, "window=playersetup")) //closes the player setup window
	user.stop_sound_channel(CHANNEL_LOBBYMUSIC)


/mob/new_player/get_species()
	var/datum/species/chosen_species
	if(client.prefs.species)
		chosen_species = client.prefs.species
	if(!chosen_species)
		return "Human"
	return chosen_species


/mob/new_player/get_gender()
	if(!client?.prefs)
		. = ..()
	return client.prefs.gender

/mob/new_player/proc/create_character()
	if(!assigned_role)
		CRASH("create_character called for [key] without an assigned_role")
	spawning = TRUE
	close_spawn_windows()
	var/spawn_type = assigned_role.return_spawn_type(client.prefs)
	var/mob/living/spawning_living = new spawn_type()
	GLOB.joined_player_list += ckey

	spawning_living.on_spawn(src)

	new_character = spawning_living


/mob/living/proc/on_spawn(mob/new_player/summoner)
	return

/mob/living/carbon/human/on_spawn(mob/new_player/summoner)
	if(!is_banned_from(summoner.ckey, "Appearance") && summoner.client)
		summoner.client.prefs.copy_to(src)
	update_names_joined_list(real_name)
	overlay_fullscreen_timer(0.5 SECONDS, 10, "roundstart1", /atom/movable/screen/fullscreen/black)
	overlay_fullscreen_timer(2 SECONDS, 20, "roundstart2", /atom/movable/screen/fullscreen/spawning_in)

/mob/living/silicon/ai/on_spawn(mob/new_player/summoner)
	if(!is_banned_from(summoner.ckey, "Appearance") && summoner.client?.prefs?.ai_name)
		fully_replace_character_name(real_name, summoner.client.prefs.ai_name)
	update_names_joined_list(real_name)
	overlay_fullscreen_timer(0.5 SECONDS, 10, "roundstart1", /atom/movable/screen/fullscreen/black)
	overlay_fullscreen_timer(2 SECONDS, 20, "roundstart2", /atom/movable/screen/fullscreen/spawning_in)


/mob/new_player/proc/transfer_character()
	. = new_character
	if(.)
		mind.transfer_to(new_character, TRUE) //Manually transfer the key to log them in
		qdel(src)


/mob/new_player/proc/IsJobAvailable(datum/job/job, latejoin = FALSE, faction)
	if(!job)
		return FALSE
	if((job.current_positions >= job.total_positions) && job.total_positions != -1)
		return FALSE
	if(is_banned_from(ckey, job.title))
		return FALSE
	if(QDELETED(src))
		return FALSE
	if(!job.player_old_enough(client))
		return FALSE
	if(job.required_playtime_remaining(client))
		return FALSE
	if(latejoin && !job.special_check_latejoin(client))
		return FALSE
	if(faction && job.faction != faction)
		return FALSE
	return TRUE

/mob/new_player/proc/try_to_observe()
	if(!SSticker || SSticker.current_state == GAME_STATE_STARTUP)
		to_chat(src, span_warning("The game is still setting up, please try again later."))
		return
	if(tgui_alert(src, "Are you sure you wish to observe?[SSticker.mode?.observe_respawn_message()]", "Observe", list("Yes", "No")) != "Yes")
		return
	if(!client)
		return TRUE
	var/mob/dead/observer/observer = new()

	spawning = TRUE
	observer.started_as_observer = TRUE

	close_spawn_windows()

	var/failed = FALSE

	if(length_char(GLOB.latejoin))
		var/i = pick(GLOB.latejoin)
		var/turf/T = get_turf(i)
		if(!T)
			CRASH("Invalid latejoin spawn location type")

		to_chat(src, span_notice("Now teleporting."))
		observer.abstract_move(T)
	else
		failed = TRUE

	if(failed)
		to_chat(src, span_danger("Could not locate an observer spawn point. Use the Teleport verb to jump."))

	GLOB.key_to_time_of_role_death[key] = world.time

	var/datum/species/species = GLOB.all_species[client.prefs.species] || GLOB.all_species[DEFAULT_SPECIES]

	if(is_banned_from(ckey, "Appearance") || !client?.prefs)
		species = GLOB.roundstart_species[DEFAULT_SPECIES]
		observer.real_name = species.random_name()
	else if(client.prefs)
		if(client.prefs.random_name)
			observer.real_name = species.random_name(client.prefs.gender)
		else
			observer.real_name = client.prefs.real_name
	else
		observer.real_name = species.random_name()

	observer.name = observer.real_name

	mind.transfer_to(observer, TRUE)
	qdel(src)

///Toggles the new players ready state
/mob/new_player/proc/toggle_ready()
	if(SSticker?.current_state > GAME_STATE_PREGAME)
		to_chat(src, span_warning("The round has already started."))
		return
	ready = !ready
	if(ready)
		GLOB.ready_players += src
	else
		GLOB.ready_players -= src
	to_chat(src, span_warning("You are now [ready? "" : "not "]ready."))

///Attempts to latejoin the player
/mob/new_player/proc/attempt_late_join(queue_override = FALSE)
	if(!SSticker?.mode || SSticker.current_state != GAME_STATE_PLAYING)
		to_chat(src, span_warning("The round is either not ready, or has already finished."))
		return

	if(SSticker.mode.flags_round_type & MODE_NO_LATEJOIN)
		to_chat(src, span_warning("Sorry, you cannot late join during [SSticker.mode.name]. You have to start at the beginning of the round. You may observe or try to join as an alien, if possible."))
		return

	if(queue_override)
		late_choices()
		return
	var/relevant_cap
	var/hpc = CONFIG_GET(number/hard_popcap)
	var/epc = CONFIG_GET(number/extreme_popcap)
	if(hpc && epc)
		relevant_cap = min(hpc, epc)
	else
		relevant_cap = max(hpc, epc)

	if(length_char(SSticker.queued_players) || (relevant_cap && living_player_count() >= relevant_cap && !(check_rights(R_ADMIN, FALSE) || GLOB.deadmins[ckey])))
		to_chat(usr, span_danger("[CONFIG_GET(string/hard_popcap_message)]"))

		var/queue_position = SSticker.queued_players.Find(usr)
		if(queue_position == 1)
			to_chat(usr, span_notice("You are next in line to join the game. You will be notified when a slot opens up."))
		else if(queue_position)
			to_chat(usr, span_notice("There are [queue_position - 1] players in front of you in the queue to join the game."))
		else
			SSticker.queued_players += usr
			to_chat(usr, span_notice("You have been added to the queue to join the game. Your position in queue is [length_char(SSticker.queued_players)]."))
		return
	late_choices()
