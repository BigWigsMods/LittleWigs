--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Magmatusk", 2519, 2494)
if not mod then return end
mod:RegisterEnableMob(181861) -- Magmatusk
mod:SetEncounterID(2610)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local volatileMutationCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		374365, -- Volatile Mutation
		375890, -- Magma Eruption
		375068, -- Magma Lob -- TODO maybe remove, might just be noise
		-- TODO Lava Empowerment (mythic only)
		375251, -- Lava Spray
		375439, -- Blazing Charge
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "VolatileMutation", 374365)
	self:Log("SPELL_CAST_SUCCESS", "MagmaEruption", 374365) -- Volatile Mutation success starts Magma Eruption
	self:Log("SPELL_CAST_SUCCESS", "MagmaLob", 375068)
	self:Log("SPELL_CAST_START", "LavaSpray", 375251)
	self:Log("SPELL_CAST_START", "BlazingCharge", 375439)
end

function mod:OnEngage()
	volatileMutationCount = 0
	self:CDBar(375251, 7.1) -- Lava Spray
	self:CDBar(375439, 19.3) -- Blazing Charge
	self:Bar(374365, 25.7) -- Volatile Mutation
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = 0
	function mod:VolatileMutation(args)
		-- sometimes gets double cast, only second cast succeeds
		local t = args.time
		if t - prev > 3 then
			prev = t
			volatileMutationCount = volatileMutationCount + 1
			self:Message(args.spellId, "orange", CL.count:format(args.spellName, volatileMutationCount))
			self:PlaySound(args.spellId, "long")
		end
		self:Bar(args.spellId, 31.6) -- TODO needs confirmation, casts at full Magma (Energy)
	end
end

function mod:MagmaEruption(args)
	-- lasts for 5 seconds per extra Magma Tentacle spawned (first Magma Eruption lasts 0 seconds)
	local magmaEruptionDuration = (volatileMutationCount - 1) * 5
	if magmaEruptionDuration > 0 then
		self:Message(375890, "red", CL.duration:format(self:SpellName(375890), magmaEruptionDuration)) -- Magma Eruption for x sec
		self:PlaySound(375890, "alert")
		self:Bar(375890, magmaEruptionDuration)
	end
end

do
	local prev = 0
	function mod:MagmaLob(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:LavaSpray(args)
	-- TODO use GetBossTarget if boss frames get added for Magmatusk
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	self:CastBar(args.spellId, 3.5)
	self:CDBar(args.spellId, 24.3)
end

function mod:BlazingCharge(args)
	-- TODO use GetBossTarget if boss frames get added for Magmatusk
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CastBar(args.spellId, 3)
	self:CDBar(args.spellId, 23)
end
