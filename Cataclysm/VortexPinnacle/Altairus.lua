--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Altairus", 657, 115)
if not mod then return end
mod:RegisterEnableMob(43873) -- Altairus
mod:SetEncounterID(1041)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local callTheWindCount = 1
local chillingBreathCount = 1
local downburstCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.upwind = "Upwind on you (safe)"
	L.downwind = "Downwind on you (unsafe)"
end

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
	if self:Retail() then
		self:Log("SPELL_CAST_SUCCESS", "EncounterEvent", 181089) -- Call the Wind
	else
		self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- Call the Wind
	end
	self:Log("SPELL_AURA_APPLIED", "UpwindOfAltairus", 88282)
	self:Log("SPELL_AURA_APPLIED", "DownwindOfAltairus", 88286)
	if self:Classic() then
		self:Log("SPELL_AURA_REMOVED", "DownwindOfAltairusRemoved", 88286)
	end
	self:Log("SPELL_CAST_START", "ChillingBreath", 88308)
	if self:Retail() then
		self:Log("SPELL_AURA_APPLIED", "ColdFrontDamage", 413275)
		self:Log("SPELL_CAST_SUCCESS", "Downburst", 413295)
	end
end

function mod:OnEngage()
	callTheWindCount = 1
	chillingBreathCount = 1
	downburstCount = 1
	self:CDBar(-2425, 5.9, nil, 88276) -- Call the Wind
	self:CDBar(88308, 12.0) -- Chilling Breath
	if self:Mythic() then
		self:CDBar(413295, 20.4, CL.count:format(self:SpellName(413295), downburstCount)) -- Downburst
	end
end

--------------------------------------------------------------------------------
-- Classic Initialization
--

if mod:Classic() then
	function mod:GetOptions()
		return {
			-2425, -- Call the Wind
			88282, -- Upwind of Altairus
			88286, -- Downwind of Altairus
			88308, -- Chilling Breath
		}
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:EncounterEvent() -- Call the Wind
	self:Message(-2425, "cyan", nil, 88276)
	self:PlaySound(-2425, "alert")
	callTheWindCount = callTheWindCount + 1
	-- actual CD is 15.8 but gets delayed by Chilling Breath (and/or Downburst)
	if self:Mythic() then
		if callTheWindCount % 4 == 3 then
			self:CDBar(-2425, 19.4, nil, 88276)
		else
			self:CDBar(-2425, 15.8, nil, 88276)
		end
	else
		-- revisit this timer on non-Mythic if Chiling Breath is ever fixed there
		self:CDBar(-2425, 15.8, nil, 88276)
	end
end

do
	-- on Classic players get spammed by SPELL_AURA_APPLIED events from Upwind when they have Downwind
	local showClassicUpwindAlert = true

	function mod:UpwindOfAltairus(args)
		if self:Me(args.destGUID) and (self:Retail() or showClassicUpwindAlert) then
			self:Message(args.spellId, "green", L.upwind)
			self:PlaySound(args.spellId, "info")
		end
	end

	function mod:DownwindOfAltairus(args)
		if self:Me(args.destGUID) then
			self:Message(args.spellId, "red", L.downwind)
			self:PlaySound(args.spellId, "alarm")
			if self:Classic() then
				-- player will be spammed by Upwind alerts despite standing Downwind, suppress those
				showClassicUpwindAlert = false
			end
		end
	end

	function mod:DownwindOfAltairusRemoved(args)
		if self:Me(args.destGUID) then
			-- allow Upwind alerts now that Downwind has been removed
			showClassicUpwindAlert = true
		end
	end
end

function mod:ChillingBreath(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	chillingBreathCount = chillingBreathCount + 1
	if self:Mythic() then
		if chillingBreathCount % 3 == 0 then
			self:CDBar(args.spellId, 23.0)
		else
			self:CDBar(args.spellId, 21.8)
		end
	elseif self:Classic() then
		self:CDBar(args.spellId, 11.4)
	else -- Retail Normal/Heroic
		-- as of May 3 2023 this is broken and casts once then never again
		self:StopBar(args.spellId)
	end
end

function mod:ColdFrontDamage(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId, "underyou")
		self:PlaySound(args.spellId, "underyou")
	end
end

function mod:Downburst(args)
	self:StopBar(CL.count:format(args.spellName, downburstCount))
	self:Message(args.spellId, "yellow", CL.count:format(args.spellName, downburstCount))
	self:PlaySound(args.spellId, "warning")
	downburstCount = downburstCount + 1
	if downburstCount % 3 == 0 then
		self:CDBar(args.spellId, 43.7, CL.count:format(args.spellName, downburstCount))
	else
		self:CDBar(args.spellId, 44.8, CL.count:format(args.spellName, downburstCount))
	end
end

--------------------------------------------------------------------------------
-- Classic Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 88276 then -- Call the Wind
		self:EncounterEvent()
	end
end
