local L = BigWigs:NewBossLocale("Siege of Boralus Trash", "esES") or BigWigs:NewBossLocale("Siege of Boralus Trash", "esMX")
if not L then return end
if L then
	L.cannoneer = "Cañonero de los Gobernalle"
	L.commander = "Comandante Gobernalle"
	L.spotter = "Avistador de los Gobernalle"
	L.demolisher = "Demoledor de las Ratas de Pantoque"
	L.pillager = "Saqueador de las Ratas de Pantoque"
	L.tempest = "Tempestad de las Ratas de Pantoque"
	L.wavetender = "Cuidaolas de Kul Tiras"
	L.halberd = "Alabardero de Kul Tiras"
	L.raider = "Asaltante Marea de Hierro"
	L.vanguard = "Vanguardia de Kul Tiras"
end

L = BigWigs:NewBossLocale("Sergeant Bainbridge", "esES") or BigWigs:NewBossLocale("Sergeant Bainbridge", "esMX")
if L then
	-- L.remaining = "%s (%d remaining)"
end

L = BigWigs:NewBossLocale("Chopper Redhook", "esES") or BigWigs:NewBossLocale("Chopper Redhook", "esMX")
if L then
	-- L.remaining = "%s (%d remaining)"
end

L = BigWigs:NewBossLocale("Viq'Goth", "esES") or BigWigs:NewBossLocale("Viq'Goth", "esMX")
if L then
	L.demolishing_desc = "Alertas y temporizadores para cuando aparece el Terror demoledor."
end
