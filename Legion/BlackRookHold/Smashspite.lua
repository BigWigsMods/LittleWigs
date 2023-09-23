--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Smashspite", 1501, 1664)
if not mod then return end
mod:RegisterEnableMob(98949) -- Smashspite the Hateful
mod:SetEncounterID(1834)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		198073, -- Earthshaking Stomp
		{198079, "SAY"}, -- Hateful Gaze
		224188, -- Hateful Charge
		{198245, "TANK_HEALER"}, -- Brutal Haymaker
		{198446, "SAY"}, -- Fel Vomit
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "EarthshakingStomp", 198073)
	self:Log("SPELL_CAST_SUCCESS", "HatefulGaze", 198079)
	self:Log("SPELL_AURA_APPLIED", "HatefulChargeApplied", 224188)
	self:Log("SPELL_AURA_APPLIED_DOSE", "HatefulChargeApplied", 224188)
	self:Log("SPELL_AURA_REMOVED", "HatefulChargeRemoved", 224188)
	self:Log("SPELL_CAST_START", "BrutalHaymaker", 198245)
	self:Log("SPELL_AURA_APPLIED", "FelVomit", 198446)
end

function mod:OnEngage()
	if not self:Normal() then -- Heroic+
		self:CDBar(198079, 5.8) -- Hateful Gaze
	end
	self:CDBar(198073, 12.1) -- Earthshaking Stomp
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:EarthshakingStomp(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 25.5)
end

function mod:HatefulGaze(args)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
	end
	-- TODO alert differently if the target has the debuff or not?
	self:TargetMessage(args.spellId, "orange", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
	self:CDBar(args.spellId, 25.5)
end

function mod:HatefulChargeApplied(args)
	if self:Me(args.destGUID) then
		-- TODO show for everyone?
		self:TargetBar(args.spellId, 60, args.destName)
	end
	-- TODO infotable?
end

function mod:HatefulChargeRemoved(args)
	if self:Me(args.destGUID) then
		self:StopBar(args.spellId, args.destName)
	end
end

function mod:BrutalHaymaker(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	-- cast at 100 energy, energy is gained based on damage done
end

function mod:FelVomit(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
		self:Say(args.spellId)
	else
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
	-- TODO might need a CD table if it's consistent pull to pull?
end
