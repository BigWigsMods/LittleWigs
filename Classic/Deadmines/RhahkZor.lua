--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Rhahk'Zor", 36, 2613)
if not mod then return end
mod:RegisterEnableMob(644) -- Rhahk'Zor
mod:SetEncounterID(mod:Retail() and 2967 or 2741)
--mod:SetRespawnTime(0)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		6304, -- Rhahk'Zor Slam
		450515, -- Whirling Rage
		--455010, -- Fixate, hidden
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "RhahkZorSlam", 6304)
	if self:Retail() then
		self:Log("SPELL_CAST_START", "WhirlingRage", 450515)
	end
end

function mod:OnEngage()
	if self:Retail() then
		-- Rhahk'Zor Slam can be cast on pull in Classic, Whirling Rage is Retail-only
		self:CDBar(6304, 3.6) -- Rhahk'Zor Slam
		self:CDBar(450515, 6.1) -- Whirling Rage
	end
end

--------------------------------------------------------------------------------
-- Classic Initialization
--

if mod:Classic() then
	function mod:GetOptions()
		return {
			6304, -- Rhahk'Zor Slam
		}
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:RhahkZorSlam(args)
	self:Message(args.spellId, "purple")
	if self:Retail() then
		self:CDBar(args.spellId, 15.8)
	else -- Classic
		self:CDBar(args.spellId, 17.8)
	end
	self:PlaySound(args.spellId, "alert")
end

function mod:WhirlingRage(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 17.0)
	self:PlaySound(args.spellId, "alarm")
end
