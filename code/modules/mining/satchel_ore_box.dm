
/**********************Ore box**************************/

/obj/structure/ore_box
	icon = 'icons/obj/mining.dmi'
	icon_state = "orebox"
	name = "ore box"
	desc = "A heavy wooden box, which can be filled with a lot of ores."
	density = TRUE
	pressure_resistance = 5*ONE_ATMOSPHERE

/obj/structure/ore_box/attackby(obj/item/W, mob/user, params)
	if (istype(W, /obj/item/stack/ore) || istype(W, /obj/item/boulder))
		if(!user.transferItemToLoc(W, src))
			return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	else if(W.atom_storage)
		W.atom_storage.remove_type(/obj/item/stack/ore, src, INFINITY, TRUE, FALSE, user, null)
		to_chat(user, span_notice("You empty the ore in [W] into \the [src]."))
	else
		return ..()

/obj/structure/ore_box/crowbar_act(mob/living/user, obj/item/I)
	if(I.use_tool(src, user, 50, volume=50))
		user.visible_message(span_notice("[user] pries \the [src] apart."),
			span_notice("You pry apart \the [src]."),
			span_hear("You hear splitting wood."))
		deconstruct(TRUE, user)
	return TRUE

/obj/structure/ore_box/examine(mob/living/user)
	if(Adjacent(user) && istype(user))
		ui_interact(user)
	. = ..()

/obj/structure/ore_box/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(Adjacent(user))
		ui_interact(user)

/obj/structure/ore_box/attack_robot(mob/user)
	if(Adjacent(user))
		ui_interact(user)

/obj/structure/ore_box/proc/dump_box_contents()
	var/drop = drop_location()
	var/turf/our_turf = get_turf(src)
	for(var/obj/item/O in src)
		if(QDELETED(O))
			continue
		if(QDELETED(src))
			break
		O.forceMove(drop)
		SET_PLANE(O, PLANE_TO_TRUE(O.plane), our_turf)
		if(TICK_CHECK)
			stoplag()
			our_turf = get_turf(src)
			drop = drop_location()

/obj/structure/ore_box/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "OreBox", name)
		ui.open()

/obj/structure/ore_box/ui_data()
	var/item_contents = list()
	var/boulder_count = 0
	for(var/obj/item/stack/ore/potental_ore as anything in contents)
		if(istype(potental_ore, /obj/item/stack/ore))
			item_contents[potental_ore.type] += potental_ore.amount
		else
			boulder_count++

	var/data = list()

	data["materials"] = list()

	for(var/obj/item/stone as anything in item_contents)
		if(ispath(stone, /obj/item/stack/ore))
			var/obj/item/stack/ore/found_ore = stone
			var/name = initial(found_ore.name)
			data["materials"] += list(list("name" = name, "amount" = item_contents[stone], "id" = type))
	data["boulders"] = boulder_count
	return data

/obj/structure/ore_box/ui_act(action, params)
	. = ..()
	if(.)
		return
	if(!Adjacent(usr))
		return
	switch(action)
		if("removeall")
			dump_box_contents()
			to_chat(usr, span_notice("You open the release hatch on the box.."))

/obj/structure/ore_box/deconstruct(disassembled = TRUE, mob/user)
	var/obj/item/stack/sheet/mineral/wood/WD = new (loc, 4)
	if(user && !QDELETED(WD))
		WD.add_fingerprint(user)
	dump_box_contents()
	qdel(src)

/// Special override for notify_contents = FALSE.
/obj/structure/ore_box/on_changed_z_level(turf/old_turf, turf/new_turf, same_z_layer, notify_contents = FALSE)
	return ..()
