--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Captain Greenskin", 36, 2630)
if not mod then return end
mod:RegisterEnableMob(647) -- Captain Greenskin
mod:SetEncounterID(mod:Retail() and 2971 or 2744)
--mod:SetRespawnTime(0)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{5208, "DISPEL"}, -- Poisoned Harpoon
		450550, -- Pistol Shot
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "PoisonedHarpoon", 5208)
	self:Log("SPELL_AURA_APPLIED", "PoisonedHarpoonApplied", 5208)
	if self:Retail() then
		self:Log("SPELL_CAST_START", "PistolShot", 450550)
	end
end

function mod:OnEngage()
	if self:Retail() then
		self:CDBar(450550, 1.0) -- Pistol Shot
	end
	self:CDBar(5208, 2.8) -- Poisoned Harpoon
end

--------------------------------------------------------------------------------
-- Classic Initialization
--

if mod:Classic() then
	function mod:GetOptions()
		return {
			{5208, "DISPEL"}, -- Poisoned Harpoon
		}
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:PoisonedHarpoon(args)
	self:Message(args.spellId, "purple", CL.casting:format(args.spellName))
	if self:Retail() then
		self:CDBar(args.spellId, 8.5)
	else -- Classic
		self:CDBar(args.spellId, 38.8)
	end
	if self:Interrupter() then
		self:PlaySound(args.spellId, "info")
	end
end

function mod:PoisonedHarpoonApplied(args)
	if self:Dispeller("poison", nil, args.spellId) then
		self:TargetMessage(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
	end
end

function mod:PistolShot(args)
	if self:MobId(args.sourceGUID) == 647 then -- Captain Greenskin
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:CDBar(args.spellId, 6.3)
		if self:Interrupter() then
			self:PlaySound(args.spellId, "alert")
		end
	end
end
