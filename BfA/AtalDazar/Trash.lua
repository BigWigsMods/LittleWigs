
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
	122972  -- Dazar'ai Augur
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
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Feasting Skyscreamer
		255041, -- Terrifying Screech
		-- T'lonja
		{255567, "SAY"}, -- Frenzied Charge
		-- Shieldbearer of Zul
		253721, -- Bulwark of Juju
		-- Zanchuli Witch-Doctor
		{252781, "SAY", "SAY_COUNTDOWN"}, -- Unstable Hex
		-- Dinomancer Kish'o
		256849, -- Dino Might
		-- Gilded Priestess
		260666, -- Transfusion
		-- Shadowblade Stalker
		252687, -- Venomfang Strike
		-- Dazar'ai Confessor
		253544, -- Bwonsamdi's Mantle
		253517, -- Mending Word
		-- Dazar'ai Augur
		253583, -- Fiery Enchant
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
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "TerrifyingScreech", 255041)
	self:Log("SPELL_CAST_START", "FrenziedCharge", 255567)
	self:Log("SPELL_CAST_SUCCESS", "BulwarkofJuju", 253721)
	self:Log("SPELL_AURA_APPLIED", "UnstableHex", 252781)
	self:Log("SPELL_AURA_REMOVED", "UnstableHexRemoved", 252781)
	self:Log("SPELL_CAST_START", "DinoMight", 256849)
	self:Log("SPELL_CAST_START", "Transfusion", 260666)
	self:Log("SPELL_AURA_APPLIED", "VenomfangStrike", 252687)
	self:Log("SPELL_AURA_APPLIED_DOSE", "VenomfangStrike", 252687)
	self:Log("SPELL_CAST_START", "BwonsamdisMantle", 253544)
	self:Log("SPELL_CAST_START", "MendingWord", 253517)
	self:Log("SPELL_CAST_SUCCESS", "FieryEnchant", 253583)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

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
do
	local prev = 0
	function mod:UnstableHex(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t-prev > 2 then -- Can be cast by 2 Witch-Doctors on the same player
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
end

-- Dinomancer Kish'o
function mod:DinoMight(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert", "interrupt")
end

-- Gilded Priestess
function mod:Transfusion(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert", "interrupt")
end

-- Shadowblade Stalker
function mod:VenomfangStrike(args)
	if self:Me(args.destGUID) then
		self:StackMessage(args.spellId, args.destName, args.amount, "orange")
		self:PlaySound(args.spellId, "alarm")
	end
end

--Dazar'ai Confessor
function mod:BwonsamdisMantle(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning", "interrupt")
end

function mod:MendingWord(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "info", "interrupt")
end

-- Dazar'ai Augur
function mod:FieryEnchant(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alarm", "interrupt")
end
