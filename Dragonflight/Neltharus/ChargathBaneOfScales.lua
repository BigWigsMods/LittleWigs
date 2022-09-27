if not IsTestBuild() then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Chargath, Bane of Scales", 2519, 2490)
if not mod then return end
mod:RegisterEnableMob(189340) -- Chargath, Bane of Scales
mod:SetEncounterID(2613)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		373424, -- Grounding Spear
		388523, -- Fetter
		375056, -- Blade Lock
		373733, -- Dragon Strike
		373742, -- Magma Wave
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "GroundingSpear", 373424)
	self:Log("SPELL_AURA_APPLIED", "FetterApplied", 388523)
	self:Log("SPELL_CAST_START", "BladeLock", 375056)
	self:Log("SPELL_CAST_START", "DragonStrike", 373733)
	self:Log("SPELL_CAST_START", "MagmaWave", 373742)
end

function mod:OnEngage()
	self:CDBar(373733, 3.4) -- Dragon Strike
	self:CDBar(373424, 10.7) -- Grounding Spear
	self:CDBar(373742, 15.5) -- Magma Wave
	self:CDBar(375056, 29.3) -- Blade Lock
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:GroundingSpear(args)
	-- targets all players in Mythic, but just one player in Normal/Heroic
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 9.7)
end

function mod:FetterApplied(args)
	-- TODO confirm this spell ID only applies to Chargath, else check is not player
	self:Message(args.spellId, "green", CL.onboss:format(args.spellName))
	self:PlaySound(args.spellId, "info")
	self:TargetBar(args.spellId, 14, args.destName)
end

function mod:BladeLock(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
	-- TODO bar, possibly started off of Blade Lock over. cast at 100 energy
end

do
	local function printTarget(self, name, guid)
		if self:Me(guid) or self:Healer() then
			self:TargetMessage(373733, "yellow", name)
			self:PlaySound(373733, "alert", nil, name)
		end
	end

	function mod:DragonStrike(args)
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(args.spellId, 20.9)
	end
end

function mod:MagmaWave(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 22.4)
end
