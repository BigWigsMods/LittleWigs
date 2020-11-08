-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Varos Cloudstrider", 578, 623)
if not mod then return end
mod:RegisterEnableMob(27447)
mod.engageId = 2015
-- mod.respawnTime = 0 -- resets, doesn't respawn

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		51054, -- Amplify Magic
		-7442, -- Call Azure Ring Captain
		51021, -- Arcane Beam
	}, {
		[51054] = "general",
		[51021] = -7443, -- Azure Ring Captain
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "AmplifyMagic", 51054, 59371) -- normal, heroic
	self:Log("SPELL_AURA_REMOVED", "AmplifyMagicRemoved", 51054, 59371)
	self:Log("SPELL_CAST_SUCCESS", "CallAzureRingCaptain", 51002, 51006, 51007, 51008) -- all 4 ids are valid for normal, on heroic he uses only 2 of those

	self:Log("SPELL_DAMAGE", "ArcaneBeam", 51021)
	self:Log("SPELL_MISSED", "ArcaneBeam", 51021)
end

function mod:OnEngage()
	self:CDBar(-7442, self:Normal() and 22.2 or 9.8) -- Call Azure Ring Captain
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:AmplifyMagic(args)
	self:TargetMessageOld(51054, args.destName, "red")
	self:TargetBar(51054, 30, args.destName)
end

function mod:AmplifyMagicRemoved(args)
	self:StopBar(args.spellName, args.destName)
end

function mod:CallAzureRingCaptain()
	self:MessageOld(-7442, "orange", nil, CL.spawned:format(self:SpellName(-7443))) -- -7443 = Azure Ring Captain
	self:CDBar(-7442, 13.3) -- 13-18s, most are ~15s
end

do
	local prev = 0
	function mod:ArcaneBeam(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t - prev > 1.5 then
				prev = t
				self:MessageOld(args.spellId, "blue", "alert", CL.underyou:format(args.spellName))
			end
		end
	end
end
