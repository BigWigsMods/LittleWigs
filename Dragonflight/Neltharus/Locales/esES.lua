local L = BigWigs:NewBossLocale("Neltharus Trash", "esES") or BigWigs:NewBossLocale("Neltharus Trash", "esMX")
if not L then return end
if L then
	L.custom_on_autotalk = "Hablar automáticamente"
	--L.custom_on_autotalk_desc = "Instantly selects the gossip options to get profession buffs."

	L.burning_chain = "Cadena ardiente"
	L.qalashi_warden = "Celador qalashi"
	L.qalashi_hunter = "Cazador qalashi"
	L.overseer_lahar = "Sobrestante Lahar"
	L.qalashi_trainee = "Recluta qalashi"
	L.qalashi_bonetender = "Cuidahuesos qalashi"
	L.qalashi_irontorch = "Antorchaférrea qalashi"
	L.qalashi_bonesplitter = "Partehuesos qalashi"
	L.qalashi_lavabearer = "Portalava qalashi"
	L.irontorch_commander = "Antorchaférrea comandante"
	L.qalashi_blacksmith = "Herrero qalashi"
	L.forgewrought_monstrosity = "Monstruosidad forjada"
	L.qalashi_plunderer = "Desvalijador qalashi"
	L.qalashi_thaumaturge = "Taumaturga qalashi"
	L.apex_blazewing = "Alardiente alfa"
	L.qalashi_lavamancer = "Lavamántico qalashi"
end

L = BigWigs:NewBossLocale("Chargath, Bane of Scales", "esES") or BigWigs:NewBossLocale("Chargath, Bane of Scales", "esMX")
if L then
	L.slow = "Ralentizar"
end

L = BigWigs:NewBossLocale("Warlord Sargha", "esES") or BigWigs:NewBossLocale("Warlord Sargha", "esMX")
if L then
	L.magical_implements_desc = "El tesoro contiene objetos mágicos que pueden ayudarte a consumir Escudo de Magma."
	L.magma_shield = "Escudo de Magma - Consigue objetos del montón de oro"
end
