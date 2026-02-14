--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ranjit", 1209, 965)
if not mod then return end
mod:RegisterEnableMob(75964)
mod:SetEncounterID(1698)
mod:SetRespawnTime(15)
mod:SetPrivateAuraSounds({
	{153757, sound = "alert"}, -- Fan of Blades
	{1252733, sound = "none"}, -- Gale Surge
})

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		156793, -- Four Winds
		153315, -- Windwall
		165731, -- Piercing Rush
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "FourWinds", 156793)
	self:Log("SPELL_CAST_START", "Windwall", 153315)
	self:Log("SPELL_CAST_SUCCESS", "PiercingRush", 165731)
end

function mod:OnEngage()
	self:Bar(156793, 36) -- Four Winds
end

--------------------------------------------------------------------------------
-- Midnight Initialization
--

if mod:Retail() then -- Midnight+
	function mod:GetOptions()
		return {
			{153757, "PRIVATE"}, -- Fan of Blades
			{1252733, "PRIVATE"}, -- Gale Surge
		}
	end

	function mod:OnBossEnable()
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:FourWinds(args)
	self:Message(args.spellId, "orange")
	self:Bar(args.spellId, 36)
	self:PlaySound(args.spellId, "warning")
end

function mod:Windwall(args)
	self:Message(args.spellId, "red")
end

function mod:PiercingRush(args)
	self:TargetMessage(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
end
