--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Candle King", 2651, 2560)
if not mod then return end
mod:RegisterEnableMob(208745) -- The Candle King
mod:SetEncounterID(2787)
mod:SetRespawnTime(30)
mod:SetPrivateAuraSounds({
	420696, -- Throw Darkflame
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		420659, -- Eerie Molds
		{422648, "SAY", "SAY_COUNTDOWN", "ME_ONLY_EMPHASIZE"}, -- Darkflame Pickaxe
		426145, -- Paranoid Mind
		{420696, "PRIVATE"}, -- Throw Darkflame
		-- TODO Cursed Wax (Mythic)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "EerieMolds", 420659)
	self:Log("SPELL_CAST_SUCCESS", "DarkflamePickaxe", 422648)
	self:Log("SPELL_AURA_REMOVED", "DarkflamePickaxeRemoved", 422648)
	self:Log("SPELL_CAST_START", "ParanoidMind", 426145)
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- Throw Darkflame
end

function mod:OnEngage()
	self:CDBar(420659, 6.1) -- Eerie Molds
	self:CDBar(426145, 10.5) -- Paranoid Mind
	self:CDBar(422648, 15.4) -- Darkflame Pickaxe
	self:CDBar(420696, 22.6) -- Throw Darkflame
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:EerieMolds(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 31.6)
end

function mod:DarkflamePickaxe(args)
	self:TargetMessage(args.spellId, "orange", args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning", nil, args.destName)
		self:Say(args.spellId, nil, nil, "Darkflame Pickaxe")
		self:SayCountdown(args.spellId, 6)
	else
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
	end
	self:CDBar(args.spellId, 17.0) -- TODO often delayed
end

function mod:DarkflamePickaxeRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end

function mod:ParanoidMind(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 20.7)
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 420696 then -- Throw Darkflame
		self:Message(spellId, "orange")
		--self:PlaySound(spellId, "alarm") private aura sound
		self:CDBar(spellId, 17.0) -- TODO often delayed
	end
end
