--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Chief Ukorz Sandscalp", 209, 489)
if not mod then return end
mod:RegisterEnableMob(
	7267, -- Chief Ukorz Sandscalp
	7797 -- Ruuzlu
)
mod:SetEncounterID(600)
--mod:SetRespawnTime(0) -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{8269, "DISPEL"}, -- Frenzy
		15496, -- Cleave
		454632, -- Enrage
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Frenzy", 8269)
	self:Log("SPELL_AURA_APPLIED", "FrenzyApplied", 8269)
	self:Log("SPELL_DAMAGE", "CleaveDamage", 15496)
	self:Log("SPELL_MISSED", "CleaveDamage", 15496)
	if self:Retail() then
		self:Log("SPELL_AURA_APPLIED", "EnrageApplied", 454632)
	end
	if self:Heroic() then -- no encounter events in Timewalking
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
		self:Death("Win", 7267)
	end
end

function mod:OnEngage()
	self:CDBar(8269, 37.6) -- Frenzy
end

--------------------------------------------------------------------------------
-- Classic Initialization
--

if mod:Classic() then
	function mod:GetOptions()
		return {
			{8269, "DISPEL"}, -- Frenzy
			15496, -- Cleave
		}
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Frenzy(args)
	self:CDBar(args.spellId, 120.0)
end

function mod:FrenzyApplied(args)
	if self:Dispeller("enrage", true, args.spellId) then
		self:Message(args.spellId, "orange", CL.onboss:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
	end
end

do
	local prev = 0
	function mod:CleaveDamage(args)
		if self:Tank() or self:Solo() then return end -- unavoidable for tank/solo
		local mobId = self:MobId(args.sourceGUID)
		local castByBoss = mobId == 7267 or mobId == 7797
		if castByBoss and self:Me(args.destGUID) and args.time - prev > 1.5 then
			prev = args.time
			self:PersonalMessage(args.spellId, "near")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:EnrageApplied(args)
	-- applies to other boss when first boss dies
	self:Message(args.spellId, "red", CL.onboss:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end
