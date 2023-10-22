local L = BigWigs:NewBossLocale("Thalnos the Soulrender", "deDE")
if not L then return end
if L then
	L.engage_yell = "Meine endlose Pein soll auch Eure sein!"
end

local L = BigWigs:NewBossLocale("Brother Korloff", "deDE")
if not L then return end
if L then
	L.engage_yell = "Ich werde Euch brechen."
end

local L = BigWigs:NewBossLocale("High Inquisitor Whitemane", "deDE")
if not L then return end
if L then
	L.engage_yell = "Meine Legende beginnt JETZT!"
end

local L = BigWigs:NewBossLocale("The Headless Horseman", "deDE")
if not L then return end
if L then
	L.the_headless_horseman = "Der kopflose Reiter"
	L.custom_on_autotalk = "Automatisch ansprechen"
	--L.custom_on_autotalk_desc = "Automatically accept the curses from the Wicker Men, and automatically start the encounter."
	--L.curses_desc = "Notifies you when you recieve a curse from a Wicker Man."
end
