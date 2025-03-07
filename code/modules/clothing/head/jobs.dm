
//Bartender
/obj/item/clothing/head/chefhat
	name = "chef's hat"
	desc = "It's a hat used by chefs to keep hair out of your food. Judging by the food in the mess, they don't work."
	icon_state = "chefhat"
	item_state = "chefhat"
	desc = "The commander in chef's head wear."
	siemens_coefficient = 0.9
	species_exception = list(/datum/species/robot, /datum/species/synthetic, /datum/species/human, /datum/species/early_synthetic, /datum/species/zombie)

//Captain: This probably shouldn't be space-worthy
/obj/item/clothing/head/caphat
	name = "captain's hat"
	icon_state = "captain"
	desc = "It's good being the king."
	item_state = "caphat"
	siemens_coefficient = 0.9
	anti_hug = 1
	species_exception = list(/datum/species/robot, /datum/species/synthetic, /datum/species/human, /datum/species/early_synthetic, /datum/species/zombie)

//Captain: This probably shouldn't be space-worthy
/obj/item/clothing/head/helmet/cap
	name = "captain's cap"
	desc = "You fear to wear it for the negligence it brings."
	icon_state = "capcap"
	flags_inventory = NONE
	flags_inv_hide = NONE
	flags_armor_protection = NONE
	flags_cold_protection = HEAD
	min_cold_protection_temperature = SPACE_HELMET_MIN_COLD_PROTECTION_TEMPERATURE
	siemens_coefficient = 0.9
	flags_armor_protection = NONE

//Chaplain
/obj/item/clothing/head/chaplain_hood
	name = "chaplain's hood"
	desc = "It's hood that covers the head. It keeps you warm during the space winters."
	icon_state = "chaplain_hood"
	flags_inventory = COVEREYES
	flags_inv_hide = HIDEEARS|HIDEALLHAIR
	siemens_coefficient = 0.9
	flags_armor_protection = HEAD|EYES
	species_exception = list(/datum/species/robot, /datum/species/synthetic, /datum/species/human, /datum/species/early_synthetic, /datum/species/zombie)

//Chaplain
/obj/item/clothing/head/nun_hood
	name = "nun hood"
	desc = "Maximum piety in this star system."
	icon_state = "nun_hood"
	flags_inventory = COVEREYES
	flags_inv_hide = HIDEEARS|HIDEALLHAIR
	siemens_coefficient = 0.9
	species_exception = list(/datum/species/robot, /datum/species/synthetic, /datum/species/human, /datum/species/early_synthetic, /datum/species/zombie)

//Mime
/obj/item/clothing/head/beret
	name = "beret"
	desc = "A beret, an artists favorite headwear."
	icon_state = "beret"
	siemens_coefficient = 0.9
	soft_armor = list(MELEE = 15, BULLET = 15, LASER = 15, ENERGY = 15, BOMB = 10, BIO = 5, FIRE = 5, ACID = 5)
	flags_armor_features = ARMOR_NO_DECAP
	species_exception = list(/datum/species/robot, /datum/species/synthetic, /datum/species/human, /datum/species/early_synthetic, /datum/species/zombie)

//Security
/obj/item/clothing/head/beret/sec
	name = "security beret"
	desc = "A beret with the security insignia emblazoned on it. For officers that are more inclined towards style than safety."
	icon_state = "beret_badge"
/obj/item/clothing/head/beret/sec/alt
	name = "officer beret"
	desc = "A navy blue beret with an officer's rank emblem. For officers that are more inclined towards style than safety."
	icon_state = "officerberet"
/obj/item/clothing/head/beret/sec/hos
	name = "officer beret"
	desc = "A navy blue beret with a commander's rank emblem. For officers that are more inclined towards style than safety."
	icon_state = "hosberet"
/obj/item/clothing/head/beret/sec/warden
	name = "warden beret"
	desc = "A navy blue beret with a warden's rank emblem. For officers that are more inclined towards style than safety."
	icon_state = "wardenberet"
/obj/item/clothing/head/beret/eng
	name = "engineering beret"
	desc = "A beret with the engineering insignia emblazoned on it. For engineers that are more inclined towards style than safety."
	icon_state = "e_beret_badge"

/obj/item/clothing/head/beret/jan
	name = "purple beret"
	desc = "A stylish, if purple, beret."
	icon_state = "purpleberet"


//Medical
/obj/item/clothing/head/surgery
	name = "surgical cap"
	desc = "A cap surgeons wear during operations. Keeps their hair from tickling your internal organs."
	icon_state = "surgcap_blue"
	flags_inv_hide = HIDETOPHAIR
	species_exception = list(/datum/species/robot, /datum/species/synthetic, /datum/species/human, /datum/species/early_synthetic, /datum/species/zombie)

/obj/item/clothing/head/surgery/purple
	desc = "A cap surgeons wear during operations. Keeps their hair from tickling your internal organs. This one is deep purple."
	icon_state = "surgcap_purple"

/obj/item/clothing/head/surgery/blue
	desc = "A cap surgeons wear during operations. Keeps their hair from tickling your internal organs. This one is baby blue."
	icon_state = "surgcap_blue"

/obj/item/clothing/head/surgery/green
	desc = "A cap surgeons wear during operations. Keeps their hair from tickling your internal organs. This one is dark green."
	icon_state = "surgcap_green"



//Detective

/obj/item/clothing/head/det_hat
	name = "hat"
	desc = "Someone who wears this will look very smart."
	icon_state = "detective"
	allowed = list(/obj/item/reagent_containers/food/snacks/candy_corn, /obj/item/tool/pen)
	soft_armor = list(MELEE = 50, BULLET = 5, LASER = 25, ENERGY = 10, BOMB = 0, BIO = 0, FIRE = 10, ACID = 10)
	siemens_coefficient = 0.9
	flags_armor_protection = NONE
	species_exception = list(/datum/species/robot, /datum/species/synthetic, /datum/species/human, /datum/species/early_synthetic, /datum/species/zombie)

/obj/item/clothing/head/det_hat/black
	icon_state = "detective2"
