local L = BigWigs:NewBossLocale("Grimrail Enforcers", "deDE")
if not L then return end
if L then
	L.sphere_fail_message = "Kugel wurde entfernt - Bosse heilen sich"
end

L = BigWigs:NewBossLocale("Oshir", "deDE")
if L then
	L.freed = "Befreit nach %.1f Sek!"
end

L = BigWigs:NewBossLocale("Iron Docks Trash", "deDE")
if L then
	L.gromkar_battlemaster = "Kampfmeister der Grom'kar"
	L.gromkar_flameslinger = "Flammenschützin der Grom'kar"
	L.gromkar_technician = "Techniker der Grom'kar"
	L.siegemaster_olugar = "Belagerungsmeister Olugar"
	L.ogron_laborer = "Ogronarbeiter"
	L.thunderlord_wrangler = "Bändiger der Donnerfürsten"
	L.rampaging_clefthoof = "Rasender Grollhuf"
	L.ironwing_flamespitter = "Flammenspucker der Eisenschwingen"
end
