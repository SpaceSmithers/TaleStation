/// Accessory Items (Moves overrided items to backpack)
/datum/loadout_category/accessories
	category_name = "Accessory"
	category_ui_icon = FA_ICON_VEST
	type_to_generate = /datum/loadout_item/accessory
	tab_order = /datum/loadout_category/head::tab_order + 9

/datum/loadout_item/accessory
	abstract_type = /datum/loadout_item/accessory
	/// Can we adjust this accessory to be above or below suits?
	VAR_FINAL/can_be_layer_adjusted = FALSE

/datum/loadout_item/accessory/New()
	. = ..()
	if(ispath(item_path, /obj/item/clothing/accessory))
		can_be_layer_adjusted = TRUE

/datum/loadout_item/accessory/get_ui_buttons()
	if(!can_be_layer_adjusted)
		return ..()

	var/list/buttons = ..()

	UNTYPED_LIST_ADD(buttons, list(
		"label" = "Layer",
		"act_key" = "set_layer",
		"active_key" = INFO_LAYER,
		"active_text" = "Above Suit",
		"inactive_text" = "Below Suit",
	))

	return buttons

/datum/loadout_item/accessory/handle_loadout_action(datum/preference_middleware/loadout/manager, mob/user, action, params)
	if(action == "set_layer")
		return set_accessory_layer(manager, user)

	return ..()

/datum/loadout_item/accessory/proc/set_accessory_layer(datum/preference_middleware/loadout/manager, mob/user)
	if(!can_be_layer_adjusted)
		return FALSE

	var/list/loadout = manager.preferences.read_preference(/datum/preference/loadout)
	if(!loadout?[item_path])
		return FALSE

	if(isnull(loadout[item_path][INFO_LAYER]))
		loadout[item_path][INFO_LAYER] = FALSE

	loadout[item_path][INFO_LAYER] = !loadout[item_path][INFO_LAYER]
	manager.preferences.update_preference(GLOB.preference_entries[/datum/preference/loadout], loadout)
	return TRUE // Update UI

/datum/loadout_item/accessory/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE)
	if(outfit.accessory)
		LAZYADD(outfit.backpack_contents, outfit.accessory)
	outfit.accessory = item_path

/datum/loadout_item/accessory/on_equip_item(
	obj/item/clothing/accessory/equipped_item,
	datum/preferences/preference_source,
	list/preference_list,
	mob/living/carbon/human/equipper,
	visuals_only = FALSE,
)
	. = ..()
	if(istype(equipped_item))
		equipped_item.above_suit = !!preference_list[item_path]?[INFO_LAYER]
		. |= (ITEM_SLOT_OCLOTHING|ITEM_SLOT_ICLOTHING)

/datum/loadout_item/accessory/maid_apron
	name = "Maid Apron"
	item_path = /obj/item/clothing/accessory/maidapron

/datum/loadout_item/accessory/waistcoat
	name = "Waistcoat"
	item_path = /obj/item/clothing/accessory/waistcoat

/datum/loadout_item/accessory/pocket_protector
	name = "Pocket Protector"
	item_path = /obj/item/clothing/accessory/pocketprotector

/datum/loadout_item/accessory/full_pocket_protector
	name = "Pocket Protector (Filled)"
	item_path = /obj/item/clothing/accessory/pocketprotector/full
	additional_displayed_text = list("Contains pens")

/datum/loadout_item/accessory/pride
	name = "Pride Pin"
	item_path = /obj/item/clothing/accessory/pride
	can_be_reskinned = TRUE

/datum/loadout_item/accessory/blue_green_armband
	name = "Blue and Green Armband"
	item_path = /obj/item/clothing/accessory/armband/hydro_cosmetic

/datum/loadout_item/accessory/brown_armband
	name = "Brown Armband"
	item_path = /obj/item/clothing/accessory/armband/cargo_cosmetic

/datum/loadout_item/accessory/green_armband
	name = "Green Armband"
	item_path = /obj/item/clothing/accessory/armband/service_cosmetic

/datum/loadout_item/accessory/purple_armband
	name = "Purple Armband"
	item_path = /obj/item/clothing/accessory/armband/science_cosmetic

/datum/loadout_item/accessory/red_armband
	name = "Red Armband"
	item_path = /obj/item/clothing/accessory/armband/deputy_cosmetic

/datum/loadout_item/accessory/yellow_armband
	name = "Yellow Reflective Armband"
	item_path = /obj/item/clothing/accessory/armband/engine_cosmetic

/datum/loadout_item/accessory/white_armband
	name = "White Armband"
	item_path = /obj/item/clothing/accessory/armband/med_cosmetic

/datum/loadout_item/accessory/white_blue_armband
	name = "White and Blue Armband"
	item_path = /obj/item/clothing/accessory/armband/medblue_cosmetic

/datum/loadout_item/accessory/bone_charm
	name = "Heirloom Bone Talismin"
	item_path = /obj/item/clothing/accessory/armorless_talisman

/datum/loadout_item/accessory/dogtags
	name = "Name-Inscribed Dogtags"
	item_path = /obj/item/clothing/accessory/cosmetic_dogtag

/datum/loadout_item/accessory/ribbon
	name = "Ribbon"
	item_path = /obj/item/clothing/accessory/medal/ribbon

/datum/loadout_item/accessory/sheriff_vest
	name = "Sheriff Vest"
	item_path = /obj/item/clothing/accessory/vest_sheriff

/datum/loadout_item/accessory/bone_codpiece
	name = "Heirloom Skull Codpiece"
	item_path = /obj/item/clothing/accessory/armorless_skullcodpiece

/* NOTE: Our Loadouts currently do not give players back their items, and more importantly, this is a backpack item
/datum/loadout_item/accessory/henchmen_wings
	name = "Henchmen Wings"
	item_path = /obj/item/storage/backpack/henchmen
*/
