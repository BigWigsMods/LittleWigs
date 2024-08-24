local L = BigWigs:NewBossLocale("Cinderbrew Meadery Trash", "deDE")
if not L then return end
if L then
	--L.venture_co_pyromaniac = "Venture Co. Pyromaniac"
	--L.hired_muscle = "Hired Muscle"
	--L.tasting_room_attendant = "Tasting Room Attendant"
	L.chef_chewie = "Chefkoch Nager"
	--L.cooking_pot = "Cooking Pot"
	L.flamethrower = "Flammenwerfer"
	--L.flavor_scientist = "Flavor Scientist"
	--L.careless_hopgoblin = "Careless Hopgoblin"
	--L.bee_wrangler = "Bee Wrangler"
	--L.venture_co_honey_harvester = "Venture Co. Honey Harvester"
	--L.royal_jelly_purveyor = "Royal Jelly Purveyor"
	--L.yes_man = "Yes Man"

	L.custom_on_cooking_autotalk_desc = "|cFFFF0000Benötigt 25 Fertigkeitspunkte der Alchemie oder Kochkunt von Khaz Algar.|r Wählt automatisch die NPC Dialogoption, welche Euch die Fähigkeit 'Klebriger Honig' gewährt. Diese kann mit dem Extra Aktionsbutton genutzt werden.\n\n|T451169:16|tKlebriger Honig\n{438997}"
	L.custom_on_flamethrower_autotalk_desc = "|cFFFF0000Benötigt Gnom, Goblin, Mechagnom, oder 25 Fertigkeitspunkte der Ingenieurskunst von Khaz Algar.|r Wählt automatisch die NPC Dialogoption, welche Euch die Fähigkeit 'Flammeninferno' gewährt. Diese kann mit dem Extra Aktionsbutton genutzt werden.\n\n|T135789:16|tFlammeninferno\n{439616}"
end

L = BigWigs:NewBossLocale("Brew Master Aldryr", "deDE")
if L then
	L.cinderbrew_delivered = "Glutbräu serviert"
end
