-- Dire Maul

local L = BigWigs:NewBossLocale("Lethtendris", "koKR")
if not L then return end
if L then
	L.pimgib = "핌기브"
end

-- Stratholme

L = BigWigs:NewBossLocale("Lord Aurius Rivendare", "koKR")
if L then
	L.death_pact_trigger = "하수인에게 죽음의 서약을 시전하려고 합니다!"
end

-- Blackrock Spire (Vanilla through Mists only)

L = BigWigs:NewBossLocale("Pyroguard Emberseer", "koKR")
if L then
	L.pyroguard_emberseer = "불의 수호자 엠버시어"
end
