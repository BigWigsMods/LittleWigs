local L = BigWigs:NewBossLocale("Grimrail Enforcers", "deDE")
if not L then return end
if L then
	L.sphere_fail_message = "Kugel wurde entfernt - Bosse heilen sich"
end

L = BigWigs:NewBossLocale("Oshir", "deDE")
if L then
	L.freed = "Befreit nach %.1f Sek!"
end
