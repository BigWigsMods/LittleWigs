-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Hydromancer Thespia", 545, 573)
if not mod then return end
mod:RegisterEnableMob(17797)
mod.engageId = 1942
-- mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		25033, -- Lightning Cloud
		31481, -- Lung Burst
		31718, -- Enveloping Winds
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_DAMAGE", "LightningCloud", 25033) -- both SPELL_ and SPELL_PERIODIC_ events. Why? I don't know why
	self:Log("SPELL_MISSED", "LightningCloud", 25033)
	self:Log("SPELL_PERIODIC_DAMAGE", "LightningCloud", 25033)
	self:Log("SPELL_PERIODIC_MISSED", "LightningCloud", 25033)

	self:Log("SPELL_AURA_APPLIED", "EnvelopingWinds", 31718)
	self:Log("SPELL_AURA_APPLIED", "LungBurst", 31481)
	self:Log("SPELL_AURA_REMOVED", "AuraRemoved", 31481, 31718)
end

-------------------------------------------------------------------------------
--  Event Handlers
--

do
	local prev = 0
	function mod:LightningCloud(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 1.5 then
				prev = t
				self:MessageOld(args.spellId, "blue", "alert", CL.you:format(args.spellName))
			end
		end
	end
end

function mod:EnvelopingWinds(args)
	self:TargetMessageOld(args.spellId, args.destName, "red", "warning", nil, nil, self:Dispeller("magic"))
	self:TargetBar(args.spellId, 6, args.destName)
end

function mod:LungBurst(args)
	if self:Me(args.destGUID) or self:Dispeller("magic") then
		self:TargetMessageOld(args.spellId, args.destName, "yellow", "alarm", nil, nil, true)
		self:TargetBar(args.spellId, 10, args.destName)
	end
end

function mod:AuraRemoved(args)
	self:StopBar(args.spellName, args.destName)
end
