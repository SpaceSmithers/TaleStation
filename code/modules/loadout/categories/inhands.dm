/// Inhand items (Moves overrided items to backpack)
/datum/loadout_category/inhands
	category_name = "Inhand"
	category_ui_icon = FA_ICON_BRIEFCASE
	type_to_generate = /datum/loadout_item/inhand
	tab_order = /datum/loadout_category/head::tab_order + 15

/datum/loadout_item/inhand
	abstract_type = /datum/loadout_item/inhand

/datum/loadout_item/inhand/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE)
	if(outfit.l_hand && !outfit.r_hand)
		outfit.r_hand = item_path
	else
		if(outfit.l_hand)
			LAZYADD(outfit.backpack_contents, outfit.l_hand)
		outfit.l_hand = item_path

/datum/loadout_item/inhand/cane
	name = "Cane"
	item_path = /obj/item/cane

/datum/loadout_item/inhand/cane_white
	name = "White Cane"
	item_path = /obj/item/cane/white

/datum/loadout_item/inhand/briefcase
	name = "Briefcase (Leather)"
	item_path = /obj/item/storage/briefcase

/datum/loadout_item/inhand/briefcase_secure
	name = "Briefcase (Secure)"
	item_path = /obj/item/storage/briefcase/secure

/datum/loadout_item/inhand/bone_spear
	name = "Heirloom Bone Spear"
	item_path = /obj/item/spear/bonespear/ceremonial

/datum/loadout_item/inhand/bouquet_mixed
	name = "Mixed Bouquet"
	item_path = /obj/item/bouquet

/datum/loadout_item/inhand/bouquet_poppy
	name = "Poppy Bouquet"
	item_path = /obj/item/bouquet/poppy

/datum/loadout_item/inhand/bouquet_sunflower
	name = "Sunflower Bouquet"
	item_path = /obj/item/bouquet/sunflower

/datum/loadout_item/inhand/bouquet_rose
	name = "Rose Bouquet"
	item_path = /obj/item/bouquet/rose

/datum/loadout_item/inhand/skateboard
	name = "Skateboard"
	item_path = /obj/item/melee/skateboard
