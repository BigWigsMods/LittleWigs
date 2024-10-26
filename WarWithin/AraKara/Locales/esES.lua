local L = BigWigs:NewBossLocale("Ara-Kara, City of Echoes Trash", "esES") or BigWigs:NewBossLocale("Ara-Kara, City of Echoes Trash", "esMX")
if not L then return end
if L then
	L.discordant_attendant = "Auxiliar discordante"
	L.engorged_crawler = "Camorrista atiborrado"
	L.trilling_attendant = "Auxiliar gorjeador"
	L.ixin = "Ixin"
	L.nakt = "Nakt"
	L.atik = "Atik"
	L.hulking_bloodguard = "Guardia de sangre descomunal"
	L.sentry_stagshell = "Centinela cornaconcha"
	L.bloodstained_assistant = "Ayudante manchado de sangre"
	L.bloodstained_webmage = "Mago arácnido manchado de sangre"
	L.blood_overseer = "Sobrestante sanguino"
	L.reinforced_drone = "Dron reforzado"
	L.nerubian_hauler = "Transportista nerubiano"
	L.winged_carrier = "Portador alado"

	L.avanoxx_warmup_trigger = "Los asistentes han sido silenciados… ¡algo emerge!"
	L.custom_on_autotalk_desc = "|cFFFF0000Requiere 25 de habilidad en Sastrería de Khaz Algar.|r Selecciona automáticamente la opción de diálogo del NPC que te otorga 'Envoltura de Seda', la cual puedes usar haciendo clic en tu botón de acción extra."
end

L = BigWigs:NewBossLocale("Anub'zekt", "esES") or BigWigs:NewBossLocale("Anub'zekt", "esMX")
if L then
	L.bloodstained_webmage_desc = "Anub'zekt invoca a un Tejehechizos Manchado de Sangre.\n\n{-28975}"
end
