local L = BigWigs:NewBossLocale("Lord Walden", "deDE")
if not L then return end
if L then
	-- %s will be either "Toxic Coagulant" or "Toxic Catalyst"
	L.coagulant = "%s: Bewegen zum Verbannen"
	L.catalyst = "%s: Krit Buff"
	L.toxin_healer_message = "%s: DoT auf allen"
end
