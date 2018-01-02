local L = BigWigs:NewBossLocale("Siamat", "esES") or BigWigs:NewBossLocale("Siamat", "esMX")
if not L then return end
if L then
	L.engage_trigger = "¡Vientos del sur, alzaos y acudid en ayuda de vuestro amo!"
	L.servant = "Invocar Sirviente"
	L.servant_desc = "Avisar cuando invoque un Sirviente de Siamat."
end
