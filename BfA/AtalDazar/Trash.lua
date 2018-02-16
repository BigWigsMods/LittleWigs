
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Atal'Dazar Trash", 0) -- XXX
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
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Feasting Skyscreamer
		255041, -- Terrifying Screech
		-- T'lonja
		255567, -- Frenzied Charge
		-- Shieldbearer of Zul
		253721, -- Bulwark of Juju
		-- Zanchuli Witch-Doctor
		{252781, "SAY"}, -- Unstable Hex
		-- Dinomancer Kish'o
		256849, -- Dino Might
		-- Gilded Priestess
		260666, -- Transfusion
		-- Shadowblade Stalker
		252687, -- Venomfang Strike
	}, {
		[255041] = L.skyscreamer,
		[255567] = L.tlonja,
		[253721] = L.shieldbearer,
		[252781] = L.witchdoctor,
		[256849] = L.kisho,
		[260666] = L.priestess,
		[252687] = L.stalker,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	self:Log("SPELL_CAST_START", "TerrifyingScreech", 255041)
	self:Log("SPELL_CAST_START", "FrenziedCharge", 255567)
	self:Log("SPELL_CAST_SUCCESS", "BulwarkofJuju", 253721)
	self:Log("SPELL_AURA_APPLIED", "UnstableHex", 252781)
	self:Log("SPELL_AURA_REMOVED", "UnstableHexRemoved", 252781)
	self:Log("SPELL_CAST_START", "DinoMight", 256849)
	self:Log("SPELL_CAST_START", "Transfusion", 260666)
	self:Log("SPELL_AURA_APPLIED", "VenomfangStrike", 252687)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Feasting Skyscreamer
function mod:TerrifyingScreech(args)
	self:Message(args.spellId, "orange", "Warning", CL.casting:format(args.spellName))
end

-- T'lonja
function mod:FrenziedCharge(args)
	self:Message(args.spellId, "yellow", "Alert")
end

-- Shieldbearer of Zul
function mod:BulwarkofJuju(args)
	self:Message(args.spellId, "yellow", "Long")
end

-- Zanchuli Witch-Doctor
do
	local prev = 0
	function mod:UnstableHex(args)
		if self:Me(args.destGUID) and GetTime()-prev > 1.5 then -- Can be cast by 2 Witch-Doctors on the same player
			prev = GetTime()
			self:TargetMessage(args.spellId, args.destName, "blue", "Alarm")
			self:Say(args.spellId)
			self:SayCountdown(args.spellId, 5)
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
	self:Message(args.spellId, "orange", "Alert", CL.casting:format(args.spellName))
end

-- Gilded Priestess
function mod:Transfusion(args)
	self:Message(args.spellId, "yellow", "Alert", CL.casting:format(args.spellName))
end

-- Shadowblade Stalker
function mod:VenomfangStrike(args)
	if self:Me(args.destGUID) then
		local amount = args.amount or 1
		if amount % 2 == 0 then -- Only warn every 2 stacks
			self:StackMessage(args.spellId, args.destName, amount, "orange", "Alarm")
		end
	end
end
