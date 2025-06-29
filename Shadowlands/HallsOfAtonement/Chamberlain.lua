local isElevenDotTwo = BigWigsLoader.isNext -- XXX remove in 11.2
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Lord Chamberlain", 2287, 2413)
if not mod then return end
mod:RegisterEnableMob(164218) -- Lord Chamberlain
mod:SetEncounterID(2381)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local doorOfShadowsCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

if isElevenDotTwo then -- XXX remove check in 11.2
	function mod:GetOptions()
		return {
			329104, -- Door of Shadows
			328791, -- Ritual of Woe
			323143, -- Telekinetic Toss
			323236, -- Unleashed Suffering
			{323437, "TANK_HEALER"}, -- Stigma of Pride
			1236973, -- Erupting Torment
		}
	end
else -- XXX remove block in 11.2
	function mod:GetOptions()
		return {
			329104, -- Door of Shadows
			328791, -- Ritual of Woe
			323143, -- Telekinetic Toss
			323236, -- Unleashed Suffering
			{323437, "TANK_HEALER"}, -- Stigma of Pride
			327885, -- Erupting Torment
		}
	end
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "DoorOfShadows", 329104)
	self:Log("SPELL_CAST_START", "RitualOfWoe", 323393, 328791) -- Normal/Heroic, Mythic
	self:Log("SPELL_AURA_APPLIED", "TelekineticToss", 323143) -- applied on the statue being thrown
	self:Log("SPELL_CAST_START", "UnleashedSuffering", 323236)
	self:Log("SPELL_CAST_SUCCESS", "StigmaOfPride", 323437)
	self:Log("SPELL_AURA_APPLIED", "StigmaOfPrideApplied", 323437)
	if isElevenDotTwo then -- XXX remove check in 11.2
		self:Log("SPELL_CAST_START", "EruptingTorment", 1236973)
	else -- XXX remove block in 11.2
		self:Log("SPELL_CAST_START", "EruptingTorment", 327885)
	end
end

function mod:OnEngage()
	doorOfShadowsCount = 1
	if isElevenDotTwo then -- XXX remove check in 11.2
		self:CDBar(323437, 7.3) -- Stigma of Pride
		self:CDBar(323143, 9.5) -- Telekinetic Toss
		self:CDBar(323236, 15.6) -- Unleashed Suffering
		self:CDBar(1236973, 25.3) -- Erupting Torment
	else -- XXX remove block in 11.2
		self:CDBar(323143, 6.0) -- Telekinetic Toss
		self:CDBar(323437, 7.5) -- Stigma of Pride
		self:CDBar(323236, 16.8) -- Unleashed Suffering
		self:CDBar(327885, 27.7) -- Erupting Torment
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DoorOfShadows(args)
	local percent = doorOfShadowsCount == 1 and 70 or 40
	doorOfShadowsCount = doorOfShadowsCount + 1
	self:Message(args.spellId, "cyan", CL.percent:format(percent, args.spellName))
	if isElevenDotTwo then -- XXX remove check in 11.2
		-- XXX Stigma of Pride is not recast in 11.2
		self:CDBar(328791, 11.0) -- Ritual of Woe
		self:CDBar(1236973, 24.3) -- Erupting Torment
		self:CDBar(323143, 30.4) -- Telekinetic Toss
		self:CDBar(323236, 36.5) -- Unleashed Suffering
	else -- XXX remove block in 11.2
		self:CDBar(328791, 10.9) -- Ritual of Woe
		self:CDBar(323437, 29.4) -- Stigma of Pride
		self:CDBar(323143, 31.5) -- Telekinetic Toss
		self:CDBar(327885, 37.6) -- Erupting Torment
		self:CDBar(323236, 49.8) -- Unleashed Suffering
	end
	self:PlaySound(args.spellId, "long")
end

function mod:RitualOfWoe()
	self:StopBar(328791)
	self:Message(328791, "red")
	self:PlaySound(328791, "warning")
end

function mod:TelekineticToss(args)
	self:Message(args.spellId, "yellow")
	if isElevenDotTwo then -- XXX remove check in 11.2
		self:CDBar(args.spellId, 12.2) -- Telekinetic Toss
	else -- XXX remove block in 11.2
		self:CDBar(args.spellId, 9.7) -- Telekinetic Toss
	end
	self:PlaySound(args.spellId, "alert")
end

function mod:UnleashedSuffering(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 22.0) -- TODO 12.2 but delayed by Erupting Torment?
	self:PlaySound(args.spellId, "alarm")
end

function mod:StigmaOfPride(args)
	if isElevenDotTwo then -- XXX remove check in 11.2
		self:StopBar(args.spellId) -- XXX just cast once in 11.2, probably broken
	else -- XXX remove block in 11.2
		self:CDBar(args.spellId, 21.8)
	end
end

function mod:StigmaOfPrideApplied(args)
	self:TargetMessage(args.spellId, "purple", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
end

function mod:EruptingTorment(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 24.4)
	self:PlaySound(args.spellId, "alarm")
end
