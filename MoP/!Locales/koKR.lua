-- Black Temple

local L = BigWigs:NewBossLocale("Kanrethad Ebonlocke", "koKR")
if not L then return end
if L then
	L.name = "칸레타드 에본로크"

	L.summons = "소환"
	L.debuffs = "약화 효과"

	L.start_say = "보아라!" -- 보아라! 난 이 세상에 존재하는 마의 에너지에 진정으로 통달했다! 내가 가진 악마의 힘은... 형언할 수 없고, 무한하며, 전능하다!
	L.win_say = "주베카" -- 주베카?! 지금 뭐하는...?!
end

L = BigWigs:NewBossLocale("Essence of Order", "koKR")
if L then
	L.name = "질서의 정수"
end

-- Scarlet Monastery

L = BigWigs:NewBossLocale("Brother Korloff", "koKR")
if L then
	L.engage_yell = "내가 널 부숴주마."
end

L = BigWigs:NewBossLocale("High Inquisitor Whitemane", "koKR")
if L then
	L.engage_yell = "내 전설은 지금부터 시작이다!"
end

L = BigWigs:NewBossLocale("Thalnos the Soulrender", "koKR")
if L then
	L.engage_yell = "내 끝없는 고통을 너희들에게도 나눠주마!"
end

L = BigWigs:NewBossLocale("The Headless Horseman", "koKR")
if L then
	L.the_headless_horseman = "저주받은 기사"
	--L.custom_on_autotalk_desc = "Automatically accept the curses from the Wicker Men, and automatically start the encounter."
	--L.curses_desc = "Notifies you when you recieve a curse from a Wicker Man."
end

-- Scholomance

L = BigWigs:NewBossLocale("Lilian Voss", "koKR")
if L then
	--L.stage_2_trigger = "Now, Lilian, it is time for your transformation."
end

-- Shado-Pan Monastery

L = BigWigs:NewBossLocale("Master Snowdrift", "koKR")
if L then
	--내가 풋내기였던 시절에는 정권 지르기 한 번도 버거웠다. 하지만 수년간 뼈를 깎는 수련을 거듭한 지금은 달라!
	L.stage3_yell = "내가 풋내기였던 시절에는"
end

L = BigWigs:NewBossLocale("Shado-Pan Monastery Trash", "koKR")
if L then
	L.destroying_sha = "파괴적인 샤"
	L.slain_shado_pan_defender = "살해된 음영파 방어병"
end

-- Stormstout Brewery

L = BigWigs:NewBossLocale("Yan-Zhu the Uncasked", "koKR")
if L then
	--L.summon_desc = "Warn when Yan-Zhu summons a Yeasty Brew Alemental. They can cast |cff71d5ffFerment|r to heal the boss."
end

-- Temple of the Jade Serpent

L = BigWigs:NewBossLocale("Lorewalker Stonestep", "koKR")
if L then
	-- Ah, it is not yet over. From what I see, we face the trial of the yaungol. Let me shed some light...
	--L.yaungol_warmup_trigger = "Ah, it is not yet over."

	-- Oh, my. If I am not mistaken, it appears that the tale of Zao Sunseeker has come to life before us.
	--L.five_suns_warmup_trigger = "If I am not mistaken"
end

L = BigWigs:NewBossLocale("Temple of the Jade Serpent Trash", "koKR")
if L then
	L.corrupt_living_water = "살아있는 타락의 물"
	--L.fallen_waterspeaker = "Fallen Waterspeaker"
	L.haunting_sha = "음산한 샤"
	L.the_talking_fish = "말하는 물고기"
	L.the_songbird_queen = "명금 여왕"
	L.the_crybaby_hozen = "울보 호젠"
	L.the_nodding_tiger = "울보 호젠"
	L.the_golden_beetle = "황금 딱정벌레"
	--L.sha_touched_guardian = "Sha-Touched Guardian"
	--L.depraved_mistweaver = "Depraved Mistweaver"
	L.shambling_infester = "휘청거리는 감염자"
	L.minion_of_doubt = "의심의 하수인"
end
