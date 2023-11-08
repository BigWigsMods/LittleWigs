--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Atal'Dazar Trash", 1763)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	128434, -- Feasting Skyscreamer
	128455, -- T'lonja
	127879, -- Shieldbearer of Zul
	122969, -- Zanchuli Witch-Doctor
	129553, -- Dinomancer Kish'o
	132126, -- Gilded Priestess
	122970, -- Shadowblade Stalker
	122973, -- Dazar'ai Confessor
	122972, -- Dazar'ai Augur
	127757  -- Reanimated Honor Guard
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.skyscreamer = "Feasting Skyscreamer"
	L.tlonja = "T'lonja"
	L.shieldbearer = "Shieldbearer of Zul"
	L.witchdoctor = "Zanchuli Witch-Doctor"
	L.kisho = "Dinomancer Kish'o"
	L.priestess = "Gilded Priestess"
	L.stalker = "Shadowblade Stalker"
	L.confessor = "Dazar'ai Confessor"
	L.augur = "Dazar'ai Augur"
	L.reanimated_honor_guard = "Reanimated Honor Guard"

	L.stairs_open = "Stairs Open"
	L.stairs_open_desc = "Show a bar indicating when the stairs open to Yazma."
	L.stairs_open_icon = "achievement_dungeon_ataldazar"
	L.stairs_open_trigger = "Impressive. You made it farther than I thought... but I will still be drinking your blood."
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- RP Timers
		"stairs_open",
		-- Feasting Skyscreamer
		255041, -- Terrifying Screech
		-- T'lonja
		{255567, "SAY"}, -- Frenzied Charge
		-- Shieldbearer of Zul
		253721, -- Bulwark of Juju
		-- Zanchuli Witch-Doctor
		{252781, "SAY", "SAY_COUNTDOWN"}, -- Unstable Hex
		-- Dinomancer Kish'o
		{256849, "DISPEL"}, -- Dino Might
		-- Gilded Priestess
		260666, -- Transfusion
		-- Shadowblade Stalker
		{252687, "DISPEL"}, -- Venomfang Strike
		-- Dazar'ai Confessor
		253544, -- Bwonsamdi's Mantle
		253517, -- Mending Word
		-- Dazar'ai Augur
		253583, -- Fiery Enchant
		-- Reanimated Honor Guard
		255626, -- Festering Eruption
	}, {
		[255041] = L.skyscreamer,
		[255567] = L.tlonja,
		[253721] = L.shieldbearer,
		[252781] = L.witchdoctor,
		[256849] = L.kisho,
		[260666] = L.priestess,
		[252687] = L.stalker,
		[253544] = L.confessor,
		[253583] = L.augur,
		[255626] = L.reanimated_honor_guard,
	}
end

function mod:OnBossEnable()
	-- RP Timers
	self:RegisterEvent("CHAT_MSG_MONSTER_SAY")

	-- Feasting Skyscreamer
	self:Log("SPELL_CAST_START", "TerrifyingScreech", 255041)

	-- T'lonja
	self:Log("SPELL_CAST_START", "FrenziedCharge", 255567)

	-- Shieldbearer of Zul
	self:Log("SPELL_CAST_SUCCESS", "BulwarkofJuju", 253721)

	-- Zanchuli Witch-Doctor
	self:Log("SPELL_CAST_START", "UnstableHex", 252781)
	self:Log("SPELL_AURA_APPLIED", "UnstableHexApplied", 252781)
	self:Log("SPELL_AURA_REMOVED", "UnstableHexRemoved", 252781)

	-- Dinomancer Kish'o
	self:Log("SPELL_CAST_START", "DinoMight", 256849)
	self:Log("SPELL_AURA_APPLIED", "DinoMightApplied", 256849)

	-- Gilded Priestess
	self:Log("SPELL_CAST_START", "Transfusion", 260666)

	-- Shadowblade Stalker
	self:Log("SPELL_AURA_APPLIED", "VenomfangStrikeApplied", 252687)
	self:Log("SPELL_AURA_APPLIED_DOSE", "VenomfangStrikeApplied", 252687)

	-- Dazar'ai Confessor
	self:Log("SPELL_CAST_START", "BwonsamdisMantle", 253544)
	self:Log("SPELL_CAST_START", "MendingWord", 253517)

	-- Dazar'ai Augur
	self:Log("SPELL_CAST_SUCCESS", "FieryEnchant", 253583)

	-- Reanimated Honor Guard
	self:Log("SPELL_CAST_SUCCESS", "FesteringEruption", 255626)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

--RP Timers

function mod:CHAT_MSG_MONSTER_SAY(event, msg)
	if msg == L.stairs_open_trigger then
		self:UnregisterEvent(event)
		self:Bar("stairs_open", 12.3, L.stairs_open, L.stairs_open_icon)
	end
end

-- Feasting Skyscreamer

function mod:TerrifyingScreech(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning", "interrupt")
end

-- T'lonja

do
	local function printTarget(self, name, guid)
		self:TargetMessage(255567, "yellow", name)
		self:PlaySound(255567, "alert", "watchstep", name)
		if self:Me(guid) then
			self:Say(255567)
		end
	end

	function mod:FrenziedCharge(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
	end
end

-- Shieldbearer of Zul

function mod:BulwarkofJuju(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long", "mobout")
end

-- Zanchuli Witch-Doctor

function mod:UnstableHex(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
end

do
	local prev = 0
	function mod:UnstableHexApplied(args)
		local t = args.time
		if self:Me(args.destGUID) and t - prev > 2 then -- Can be cast by 2 Witch-Doctors on the same player
			prev = t
			self:PersonalMessage(args.spellId)
			self:PlaySound(args.spellId, "alarm", "moveout")
			self:Say(args.spellId)
			self:SayCountdown(args.spellId, 5)
		end
	end
end

function mod:UnstableHexRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end

-- Dinomancer Kish'o

function mod:DinoMight(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert", "interrupt")
end

function mod:DinoMightApplied(args)
	if self:Dispeller("magic", true, args.spellId) then
		self:Message(args.spellId, "orange", CL.other:format(args.spellName, args.destName))
		self:PlaySound(args.spellId, "warning")
	end
end

-- Gilded Priestess

function mod:Transfusion(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert", "interrupt")
end

-- Shadowblade Stalker

function mod:VenomfangStrikeApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("poison", nil, args.spellId) then
		self:StackMessage(args.spellId, "orange", args.destName, args.amount, 1)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

--Dazar'ai Confessor

function mod:BwonsamdisMantle(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning", "interrupt")
end

function mod:MendingWord(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert", "interrupt")
end

-- Dazar'ai Augur

function mod:FieryEnchant(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm", "interrupt")
end

-- Reanimated Honor Guard

do
	local prev = 0
	function mod:FesteringEruption(args)
		local t = args.time
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end
