--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Pyranis", 2784)
if not mod then return end
mod:RegisterEnableMob(227140) -- Pyranis
mod:SetEncounterID(3030)
--mod:SetRespawnTime(30)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.pyranis = "Pyranis"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.pyranis
end

function mod:GetOptions()
	return {
		460577, -- Summon Dread Fungus
		460666, -- Summon Dread Seed
		460676, -- Summon Dread Lasher
		460545, -- Enshrouding Fog
		460671, -- Wrath
	},nil,{
		[460671] = CL.interruptible, -- Wrath (Interruptible)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "SummonDreadFungus", 460577)
	self:Log("SPELL_CAST_START", "SummonDreadSeed", 460666)
	self:Log("SPELL_CAST_START", "SummonDreadLasher", 460676)
	self:Log("SPELL_CAST_START", "EnshroudingFog", 460545)
	self:Log("SPELL_CAST_SUCCESS", "EnshroudingFogSuccess", 460545)
	self:Log("SPELL_AURA_APPLIED", "EnshroudingFogApplied", 460545)
	self:Log("SPELL_AURA_REMOVED", "EnshroudingFogRemoved", 460545)
	self:Log("SPELL_CAST_START", "Wrath", 460671)
end

function mod:OnEngage()
	self:CDBar(460577, 11.6) -- Summon Dread Fungus
	self:CDBar(460666, 13.2) -- Summon Dread Seed
	self:CDBar(460676, 24.6) -- Summon Dread Lasher
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SummonDreadFungus(args)
	self:Message(args.spellId, "orange")
	self:CDBar(args.spellId, 21.1)
	self:PlaySound(args.spellId, "alert")
end

function mod:SummonDreadSeed(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 21.1)
	self:PlaySound(args.spellId, "alert")
end

function mod:SummonDreadLasher(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 21.1)
	self:PlaySound(args.spellId, "alert")
end

do
	local enshroudingFogStart = 0
	local enshroudingFogCount = 0

	function mod:EnshroudingFog(args)
		self:StopBar(460577) -- Summon Dread Fungus
		self:StopBar(460666) -- Summon Dread Seed
		self:StopBar(460676) -- Summon Dread Lasher
		self:Message(args.spellId, "cyan")
		self:PlaySound(args.spellId, "long")
	end

	function mod:EnshroudingFogSuccess(args)
		enshroudingFogCount = 0
		enshroudingFogStart = args.time
	end

	function mod:EnshroudingFogApplied(args)
		if self:Player(args.destFlags) then -- Players, not pets
			enshroudingFogCount = enshroudingFogCount + 1
		end
	end

	function mod:EnshroudingFogRemoved(args)
		-- this debuff is on the whole party during Enshrouding Fog
		if self:Player(args.destFlags) then -- Players, not pets
			enshroudingFogCount = enshroudingFogCount - 1
			if enshroudingFogCount == 0 then
				local enshroudingFogDuration = args.time - enshroudingFogStart
				self:Message(args.spellId, "green", CL.removed_after:format(args.spellName, enshroudingFogDuration))
				self:PlaySound(args.spellId, "info")
				-- TODO start bars?
			end
		end
	end
end

function mod:Wrath(args)
	self:Message(args.spellId, "yellow", CL.extra:format(args.spellName, CL.interruptible))
	self:PlaySound(args.spellId, "alarm")
end
