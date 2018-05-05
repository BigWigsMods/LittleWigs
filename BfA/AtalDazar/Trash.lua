if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

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
	122970 -- Shadowblade Stalker
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
	self:Log("SPELL_AURA_APPLIED_DOSE", "VenomfangStrike", 252687)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Feasting Skyscreamer
function mod:TerrifyingScreech(args)
	self:Message(args.spellId, "orange", nil, CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning", "interrupt")
end

-- T'lonja
function mod:FrenziedCharge(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert", "watchstep")
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
			local t = GetTime()
			if t-prev > 2 then -- Can be cast by 2 Witch-Doctors on the same player
				prev = t
				self:TargetMessage(args.spellId, args.destName, "blue")
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
	self:Message(args.spellId, "orange", nil, CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert", "interrupt")
end

-- Gilded Priestess
function mod:Transfusion(args)
	self:Message(args.spellId, "yellow", nil, CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert", "interrupt")
end

-- Shadowblade Stalker
function mod:VenomfangStrike(args)
	if self:Me(args.destGUID) then
		self:StackMessage(args.spellId, args.destName, args.amount, "orange")
		self:PlaySound(args.spellId, "alarm")
	end
end
