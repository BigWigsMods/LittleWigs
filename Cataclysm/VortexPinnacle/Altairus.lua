--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Altairus", 657, 115)
if not mod then return end
mod:RegisterEnableMob(43873)
mod:SetEncounterID(1041)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local callTheWindCount = 1
local chillingBreathCount = 1
local downburstCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-2425, -- Call the Wind
		88282, -- Upwind of Altairus
		88286, -- Downwind of Altairus
		88308, -- Chilling Breath
		413275, -- Cold Front
		413295, -- Downburst
	}, {
		[413295] = CL.mythic,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "EncounterEvent", 181089) -- Call the Wind
	self:Log("SPELL_AURA_APPLIED", "UpwindOfAltairus", 88282)
	self:Log("SPELL_AURA_APPLIED", "DownwindOfAltairus", 88286)
	self:Log("SPELL_AURA_REMOVED", "DownwindOfAltairusRemoved", 88286)
	self:Log("SPELL_CAST_START", "ChillingBreath", 88308)
	self:Log("SPELL_AURA_APPLIED", "ColdFrontDamage", 413275)
	self:Log("SPELL_CAST_SUCCESS", "Downburst", 413295)
end

function mod:OnEngage()
	callTheWindCount = 1
	chillingBreathCount = 1
	downburstCount = 1
	self:Bar(-2425, 5.9, nil, 88276) -- Call the Wind
	self:Bar(88308, 13.2) -- Chilling Breath
	if self:Mythic() then
		self:Bar(413295, 20.4) -- Downburst
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:EncounterEvent(args) -- Call the Wind
	self:Message(-2425, "cyan", nil, 88276)
	self:PlaySound(-2425, "alert")
	callTheWindCount = callTheWindCount + 1
	if callTheWindCount % 4 == 3 then
		self:Bar(-2425, 19.4, nil, 88276)
	else
		self:Bar(-2425, 15.8, nil, 88276)
	end
end

do
	-- TODO this is no longer needed in 10.1+
	local haveDownwind = false -- for some reason players get spammed by SPELL_AURA_APPLIED events from Upwind when they have Downwind

	function mod:UpwindOfAltairus(args)
		if self:Me(args.destGUID) and not haveDownwind then
			self:Message(args.spellId, "green", CL.you:format(args.spellName))
			self:PlaySound(args.spellId, "info")
		end
	end

	function mod:DownwindOfAltairus(args)
		if self:Me(args.destGUID) then
			haveDownwind = true
			self:Message(args.spellId, "red", CL.you:format(args.spellName))
			self:PlaySound(args.spellId, "underyou")
		end
	end

	function mod:DownwindOfAltairusRemoved(args)
		if self:Me(args.destGUID) then
			haveDownwind = false
		end
	end
end

function mod:ChillingBreath(args)
	-- TODO any way to get target?
	-- boss seems to detarget before casting this, previously this used self:UnitName("boss1target")
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	chillingBreathCount = chillingBreathCount + 1
	if self:Mythic() then
		if chillingBreathCount % 3 == 0 then
			self:Bar(args.spellId, 23.0)
		else
			self:Bar(args.spellId, 21.8)
		end
	else
		-- TODO confirm once 10.1 is live
		self:Bar(args.spellId, 12)
	end
end

function mod:ColdFrontDamage(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId, "underyou")
		self:PlaySound(args.spellId, "underyou")
	end
end

function mod:Downburst(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "long")
	downburstCount = downburstCount + 1
	if downburstCount % 3 == 0 then
		self:CDBar(args.spellId, 43.7)
	else
		self:CDBar(args.spellId, 44.8)
	end
end
