-- Black Temple

local L = BigWigs:NewBossLocale("Kanrethad Ebonlocke", "zhTW")
if not L then return end
if L then
	--L.name = "Kanrethad Ebonlocke"

	L.summons = "召喚"
	L.debuffs = "減益"

	L.start_say = "看哪" -- 看哪!我徹底掌握了這片土地的魔化能量!如今任我掌控的這股惡魔之力…是無以言諭·無窮無盡·無所不能的!
	L.win_say = "裘貝卡" -- Jubeka?! What are you...?!
end

L = BigWigs:NewBossLocale("Essence of Order", "zhTW")
if L then
	--L.name = "Essence of Order"
end

-- Scarlet Monastery

L = BigWigs:NewBossLocale("Thalnos the Soulrender", "zhTW")
if L then
	--L.engage_yell = "My endless agony shall be yours, as well!"
end

L = BigWigs:NewBossLocale("Brother Korloff", "zhTW")
if L then
	--L.engage_yell = "I will break you."
end

L = BigWigs:NewBossLocale("High Inquisitor Whitemane", "zhTW")
if L then
	--L.engage_yell = "My legend begins NOW!"
end

L = BigWigs:NewBossLocale("The Headless Horseman", "zhTW")
if L then
	L.the_headless_horseman = "無頭騎士"
	--L.custom_on_autotalk_desc = "Automatically accept the curses from the Wicker Men, and automatically start the encounter."
	--L.curses_desc = "Notifies you when you recieve a curse from a Wicker Man."
end

-- Scholomance

L = BigWigs:NewBossLocale("Lilian Voss", "zhTW")
if L then
	--L.stage_2_trigger = "Now, Lilian, it is time for your transformation."
end

-- Shado-Pan Monastery

L = BigWigs:NewBossLocale("Master Snowdrift", "zhTW")
if L then
	-- When I was but a cub I could scarcely throw a punch, but after years of training I can do so much more!
	--L.stage3_yell = "was but a cub"
end

L = BigWigs:NewBossLocale("Shado-Pan Monastery Trash", "zhTW")
if L then
	--L.destroying_sha = "Destroying Sha"
	--L.slain_shado_pan_defender = "Slain Shado-Pan Defender"
end

-- Stormstout Brewery

L = BigWigs:NewBossLocale("Yan-Zhu the Uncasked", "zhTW")
if L then
	--L.summon_desc = "Warn when Yan-Zhu summons a Yeasty Brew Alemental. They can cast |cff71d5ffFerment|r to heal the boss."
end

-- Temple of the Jade Serpent

L = BigWigs:NewBossLocale("Lorewalker Stonestep", "zhTW")
if L then
	-- Ah, it is not yet over. From what I see, we face the trial of the yaungol. Let me shed some light...
	--L.yaungol_warmup_trigger = "Ah, it is not yet over."

	-- Oh, my. If I am not mistaken, it appears that the tale of Zao Sunseeker has come to life before us.
	--L.five_suns_warmup_trigger = "If I am not mistaken"
end

L = BigWigs:NewBossLocale("Temple of the Jade Serpent Trash", "zhTW")
if L then
	--L.corrupt_living_water = "Corrupt Living Water"
	--L.fallen_waterspeaker = "Fallen Waterspeaker"
	--L.haunting_sha = "Haunting Sha"
	--L.the_talking_fish = "The Talking Fish"
	--L.the_songbird_queen = "The Songbird Queen"
	--L.the_crybaby_hozen = "The Crybaby Hozen"
	--L.the_nodding_tiger = "The Nodding Tiger"
	--L.the_golden_beetle = "The Golden Beetle"
	--L.sha_touched_guardian = "Sha-Touched Guardian"
	--L.depraved_mistweaver = "Depraved Mistweaver"
	--L.shambling_infester = "Shambling Infester"
	--L.minion_of_doubt = "Minion of Doubt"
end
