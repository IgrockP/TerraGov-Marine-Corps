#define SSJOB_OVERRIDE_JOBS_START (1<<0)

#define JOB_DISPLAY_ORDER_DEFAULT 0

#define JOB_DISPLAY_ORDER_XENO_QUEEN 1
#define JOB_DISPLAY_ORDER_XENOMORPH 2
#define JOB_DISPLAY_ORDER_CAPTAIN 3
#define JOB_DISPLAY_ORDER_EXECUTIVE_OFFICER 4
#define JOB_DISPLAY_ORDER_STAFF_OFFICER 5
#define JOB_DISPLAY_ORDER_PILOT_OFFICER 6
#define JOB_DISPLAY_ORDER_MECH_PILOT 7
#define JOB_DISPLAY_ORDER_CORPORATE_LIAISON 8
#define JOB_DISPLAY_ORDER_SYNTHETIC 9
#define JOB_DISPLAY_ORDER_AI 10
#define JOB_DISPLAY_ORDER_CHIEF_ENGINEER 13
#define JOB_DISPLAY_ORDER_SHIP_TECH 14
#define JOB_DISPLAY_ORDER_REQUISITIONS_OFFICER 15
#define JOB_DISPLAY_ORDER_CHIEF_MEDICAL_OFFICER 16
#define JOB_DISPLAY_ORDER_DOCTOR 17
#define JOB_DISPLAY_ORDER_MEDICAL_RESEARCHER 18
#define JOB_DISPLAY_ORDER_SQUAD_LEADER 19
#define JOB_DISPLAY_ORDER_SQUAD_SMARTGUNNER 20
#define JOB_DISPLAY_ORDER_SQUAD_CORPSMAN 21
#define JOB_DISPLAY_ORDER_SUQAD_ENGINEER 22
#define JOB_DISPLAY_ORDER_SQUAD_MARINE 23
#define JOB_DISPLAY_ORDER_SURVIVOR 24

#define JOB_FLAG_SPECIALNAME (1<<0)
#define JOB_FLAG_LATEJOINABLE (1<<1) //Can this job be selected for prefs to join as?
#define JOB_FLAG_ROUNDSTARTJOINABLE (1<<2) //Joinable at roundstart
#define JOB_FLAG_NOHEADSET (1<<3) //Doesn't start with a headset on spawn.
#define JOB_FLAG_ALLOWS_PREFS_GEAR (1<<4) //Allows preference loadouts.
#define JOB_FLAG_PROVIDES_BANK_ACCOUNT (1<<5) //$$$
#define JOB_FLAG_OVERRIDELATEJOINSPAWN (1<<6) //AIs and xenos, for example.
#define JOB_FLAG_ADDTOMANIFEST (1<<7) //Add info to datacore.
#define JOB_FLAG_ISCOMMAND (1<<8)
#define JOB_FLAG_BOLD_NAME_ON_SELECTION (1<<9)
#define JOB_FLAG_PROVIDES_SQUAD_HUD (1<<10)
#define JOB_FLAG_HIDE_CURRENT_POSITIONS (1<<11) //You can't see how many people have joined as on the latejoin menu.
#define JOB_FLAG_CAN_SEE_ORDERS (1<<12) //Able to see rally and CIC orders
#define JOB_FLAG_ALWAYS_VISIBLE_ON_MINIMAP (1<<13) //Will appear on all minimaps, including squad minimaps
#define JOB_FLAG_SHOW_OPEN_POSITIONS (1<<14) //You can only see how many positions are opened, and not how many positions are fullfilled

#define CAPTAIN "Captain"
#define EXECUTIVE_OFFICER "Executive Officer" //Currently disabled.
#define FIELD_COMMANDER "Field Commander"
#define STAFF_OFFICER "Staff Officer"
#define PILOT_OFFICER "Pilot Officer"
#define MECH_PILOT "Mech Pilot"
#define REQUISITIONS_OFFICER "Requisitions Officer"
#define CHIEF_SHIP_ENGINEER "Chief Ship Engineer"
#define CHIEF_MEDICAL_OFFICER "Chief Medical Officer"
#define CORPORATE_LIAISON "Corporate Liaison"
#define SYNTHETIC "Synthetic"
#define SHIP_TECH "Ship Technician"
#define MEDICAL_DOCTOR "Medical Doctor"
#define MEDICAL_RESEARCHER "Medical Researcher"
#define SQUAD_LEADER "Squad Leader"
#define SQUAD_SPECIALIST "Squad Specialist"
#define SQUAD_SMARTGUNNER "Squad Smartgunner"
#define SQUAD_CORPSMAN "Squad Corpsman"
#define SQUAD_ENGINEER "Squad Engineer"
#define SQUAD_MARINE "Squad Marine"
#define SQUAD_VATGROWN "Squad VatGrown"
#define SILICON_AI "AI"

#define REBEL_CAPTAIN "Rebel Captain"
#define REBEL_EXECUTIVE_OFFICER "Rebel Executive Officer" //Currently disabled.
#define REBEL_FIELD_COMMANDER "Rebel Field Commander"
#define REBEL_STAFF_OFFICER "Rebel Staff Officer"
#define REBEL_PILOT_OFFICER "Rebel Pilot Officer"
#define REBEL_REQUISITIONS_OFFICER "Rebel Requisitions Officer"
#define REBEL_CHIEF_SHIP_ENGINEER "Rebel Chief Ship Engineer"
#define REBEL_CHIEF_MEDICAL_OFFICER "Rebel Chief Medical Officer"
#define REBEL_SYNTHETIC "Rebel Synthetic"
#define REBEL_SHIP_TECH "Rebel Ship Technician"
#define REBEL_MEDICAL_DOCTOR "Rebel Medical Doctor"
#define REBEL_MEDICAL_RESEARCHER "Rebel Medical Researcher"
#define REBEL_SQUAD_LEADER "Rebel Squad Leader"
#define REBEL_SQUAD_SPECIALIST "Rebel Squad Specialist"
#define REBEL_SQUAD_SMARTGUNNER "Rebel Squad Smartgunner"
#define REBEL_SQUAD_CORPSMAN "Rebel Squad Corpsman"
#define REBEL_SQUAD_ENGINEER "Rebel Squad Engineer"
#define REBEL_SQUAD_MARINE "Rebel Squad Marine"
#define REBEL_SQUAD_VATGROWN "Rebel Squad VatGrown"
#define REBEL_SILICON_AI "Rebel AI"

//SOM - very placeholder for now
#define SOM_SQUAD_LEADER "SOM Squad Leader"
#define SOM_SQUAD_CORPSMAN "SOM Squad Medic"
#define SOM_SQUAD_ENGINEER "SOM Squad Engineer"
#define SOM_SQUAD_VETERAN "SOM Squad Veteran"
#define SOM_SQUAD_MARINE "SOM Squad Standard"

#define JOB_CAT_COMMAND "Command"
#define JOB_CAT_SILICON "Silicon"
#define JOB_CAT_REQUISITIONS "Requisitions"
#define JOB_CAT_MEDICAL "Medical"
#define JOB_CAT_ENGINEERING "Engineering"
#define JOB_CAT_CIVILIAN "Civilian"
#define JOB_CAT_MARINE "Marine"
#define JOB_CAT_XENO "Xenomorph"
#define JOB_CAT_UNASSIGNED "Unassigned"

#define JOB_COMM_TITLE_SQUAD_LEADER "SL"

#define ROLE_XENOMORPH "Xenomorph"
#define ROLE_XENO_QUEEN "Xeno Queen"
#define ROLE_XENO_HUGGER "Xeno Facehugger"
#define ROLE_ERT "Emergency Response Team"
#define ROLE_VALHALLA "Valhalla"

GLOBAL_LIST_INIT(jobs_command, list(CAPTAIN, FIELD_COMMANDER, STAFF_OFFICER, SQUAD_LEADER))
GLOBAL_LIST_INIT(jobs_officers, list(CAPTAIN, FIELD_COMMANDER, STAFF_OFFICER, PILOT_OFFICER, MECH_PILOT, CORPORATE_LIAISON, SYNTHETIC, SILICON_AI, SQUAD_LEADER, CHIEF_MEDICAL_OFFICER, CHIEF_SHIP_ENGINEER, REQUISITIONS_OFFICER))
GLOBAL_LIST_INIT(jobs_support, list(PILOT_OFFICER, MECH_PILOT, REQUISITIONS_OFFICER, SYNTHETIC, SILICON_AI))
GLOBAL_LIST_INIT(jobs_engineering, list(CHIEF_SHIP_ENGINEER, SHIP_TECH, SQUAD_ENGINEER))
GLOBAL_LIST_INIT(jobs_requisitions, list(REQUISITIONS_OFFICER))
GLOBAL_LIST_INIT(jobs_medical, list(CHIEF_MEDICAL_OFFICER, MEDICAL_DOCTOR, MEDICAL_RESEARCHER, SQUAD_CORPSMAN))
GLOBAL_LIST_INIT(jobs_marines, list(SQUAD_LEADER, SQUAD_SMARTGUNNER, SQUAD_CORPSMAN, SQUAD_ENGINEER, SQUAD_MARINE))
GLOBAL_LIST_INIT(jobs_robots, list(SYNTHETIC, SILICON_AI))
GLOBAL_LIST_INIT(jobs_civilian, list(CORPORATE_LIAISON))
GLOBAL_LIST_INIT(jobs_xeno, list(ROLE_XENOMORPH, ROLE_XENO_QUEEN, ROLE_XENO_HUGGER))
GLOBAL_LIST_INIT(jobs_regular_all, list(CAPTAIN, FIELD_COMMANDER, STAFF_OFFICER, PILOT_OFFICER, MECH_PILOT, REQUISITIONS_OFFICER, CHIEF_SHIP_ENGINEER, \
CHIEF_MEDICAL_OFFICER, SYNTHETIC, SILICON_AI, CORPORATE_LIAISON, SHIP_TECH, \
MEDICAL_DOCTOR, MEDICAL_RESEARCHER, SQUAD_LEADER, SQUAD_SMARTGUNNER, SQUAD_CORPSMAN, SQUAD_ENGINEER, SQUAD_MARINE))
GLOBAL_LIST_INIT(jobs_all, list(CAPTAIN, FIELD_COMMANDER, STAFF_OFFICER, PILOT_OFFICER, REQUISITIONS_OFFICER, CHIEF_SHIP_ENGINEER, CHIEF_MEDICAL_OFFICER, SYNTHETIC, SILICON_AI, CORPORATE_LIAISON, SHIP_TECH,
MEDICAL_DOCTOR, MEDICAL_RESEARCHER, SQUAD_LEADER, SQUAD_SMARTGUNNER, SQUAD_CORPSMAN, SQUAD_ENGINEER, SQUAD_MARINE, ROLE_XENOMORPH, ROLE_XENO_QUEEN, ROLE_XENO_HUGGER))
GLOBAL_LIST_INIT(jobs_fallen_all, typecacheof(list(/datum/job/fallen)))

//Playtime tracking system, see jobs_exp.dm
#define EXP_TYPE_LIVING "Living"
#define EXP_TYPE_ALL "Any"
#define EXP_TYPE_REGULAR_ALL "Any TMGC"
#define EXP_TYPE_COMMAND "Command"
#define EXP_TYPE_OFFICERS "Officers"
#define EXP_TYPE_ENGINEERING "Engineering"
#define EXP_TYPE_MEDICAL "Medical"
#define EXP_TYPE_MARINES "Marines"
#define EXP_TYPE_REQUISITIONS "Requisitions"
#define EXP_TYPE_SILICON "Silicon"
#define EXP_TYPE_XENO "Xeno"
#define EXP_TYPE_SPECIAL "Special"
#define EXP_TYPE_GHOST "Ghost"
#define EXP_TYPE_ADMIN "Admin"

// hypersleep bay flags
#define CRYO_MED "Medical"
#define CRYO_ENGI "Engineering"
#define CRYO_REQ "Requisitions"
#define CRYO_ALPHA "Alpha Squad"
#define CRYO_BRAVO "Bravo Squad"
#define CRYO_CHARLIE "Charlie Squad"
#define CRYO_DELTA "Delta Squad"

// In minutes
#define XP_REQ_NOVICE 300
#define XP_REQ_UNSEASONED 300
#define XP_REQ_INTERMEDIATE 600
#define XP_REQ_EXPERIENCED 2400
#define XP_REQ_EXPERT 2400
#define XP_REQ_SURVIVOR 3600

// how much a job is going to contribute towards burrowed larva. see config for points required to larva. old balance was 1 larva per 3 humans.
#define LARVA_POINTS_SHIPSIDE 1
#define LARVA_POINTS_SHIPSIDE_STRONG 1.5
#define LARVA_POINTS_REGULAR 3.25
#define LARVA_POINTS_STRONG 6

#define SURVIVOR_POINTS_REGULAR 1

#define SMARTIE_POINTS_REGULAR 1
#define SMARTIE_POINTS_MEDIUM 2
#define SMARTIE_POINTS_HIGH 3
#define SYNTH_POINTS_REGULAR 1
#define MECH_POINTS_REGULAR 1

#define VETERAN_POINTS_REGULAR 1

#define MARINE_SPAWN_ORIGIN "xenos from marine spawn"
#define PSY_DRAIN_ORIGIN "xenos from psy drained bodies"
#define COCOON_ORIGIN "xenos from cocoon that reached its endlife"
#define SILO_ORIGIN "xenos from silo generation"

#define SQUAD_MAX_POSITIONS(total_positions) CEILING(total_positions / length_char(SSjob.active_squads), 1)

/// How many points a marine can spend in job specific vendors by default
#define DEFAULT_TOTAL_BUY_POINTS 45
/// How many points a medic can spend on pills
#define MEDIC_TOTAL_BUY_POINTS 45
/// How many points an engineer can spend
#define ENGINEER_TOTAL_BUY_POINTS 75
