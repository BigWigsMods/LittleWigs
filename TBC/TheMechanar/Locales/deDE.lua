local L = BigWigs:NewBossLocale("Pathaleon the Calculator", "deDE")
if not L then return end
if L then
	L.despawn_message = "Nethergespenster verschwinden bald!"
	L.despawn_trigger = "Ich mag es lieber praktisch..."
	--L.despawn_trigger2 = "I prefer to be hands"
	L.despawn_done = "Nethergespenster verschwinden!"
end

L = BigWigs:NewBossLocale("Mechano-Lord Capacitus", "deDE")
if L then
	L.enrage_trigger = "Verzieht Euch, solange Ihr noch k\195\182nnt."
end

L = BigWigs:NewBossLocale("Gatewatcher Iron-Hand", "deDE")
if L then
	L.hammer_trigger = "erhebt seinen Hammer bedrohlich"
end
