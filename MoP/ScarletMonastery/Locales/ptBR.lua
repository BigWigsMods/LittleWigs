local L = BigWigs:NewBossLocale("Thalnos the Soulrender", "ptBR")
if not L then return end
if L then
	L.engage_yell = "Minha agonia infinita será sua, também!"
end

local L = BigWigs:NewBossLocale("Brother Korloff", "ptBR")
if not L then return end
if L then
	L.engage_yell = "Vou acabar com você."
end

local L = BigWigs:NewBossLocale("High Inquisitor Whitemane", "ptBR")
if not L then return end
if L then
	L.engage_yell = "A minha lenda começa AGORA!"
end

local L = BigWigs:NewBossLocale("The Headless Horseman", "ptBR")
if not L then return end
if L then
	L.the_headless_horseman = "O Cavaleiro Sem Cabeça"
	L.custom_on_autotalk = "Conversa automática"
	--L.custom_on_autotalk_desc = "Automatically accept the curses from the Wicker Men, and automatically start the encounter."
	--L.curses_desc = "Notifies you when you recieve a curse from a Wicker Man."
end
