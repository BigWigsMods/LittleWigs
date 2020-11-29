
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Hakkar the Soulflayer", 2291, 2408)
if not mod then return end
mod:RegisterEnableMob(164558)
mod.engageId = 2395
--mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{322746, "SAY"}, -- Corrupted Blood
		322759, -- Blood Barrier
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "CorruptedBlood", 323166)
	self:Log("SPELL_AURA_APPLIED", "CorruptedBloodApplied", 322746)
	self:Log("SPELL_CAST_START", "BloodBarrier", 322759)
end

function mod:OnEngage()
	self:CDBar(322746, 8) -- Corrupted Blood
	self:CDBar(322759, 24) -- Blood Barrier
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CorruptedBlood()
	self:CDBar(322746, 27) -- pull:8.1, 29.2, 26.7
end

do
	local playerList = mod:NewTargetList()
	function mod:CorruptedBloodApplied(args)
		playerList[#playerList+1] = args.destName
		self:TargetsMessage(args.spellId, "red", playerList, 2)
		if self:Me(args.destGUID) then
			self:PlaySound(args.spellId, "warning")
			self:Say(args.spellId)
			self:TargetBar(args.spellId, 8, args.destName)
		end
	end
end

function mod:BloodBarrier(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 27) -- pull:24.3, 27.9
end
