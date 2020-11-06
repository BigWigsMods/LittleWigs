
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Kul'tharok", 2293, 2389)
if not mod then return end
mod:RegisterEnableMob(162309)
mod.engageId = 2364
--mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{319521, "ME_ONLY"}, -- Draw Soul
		{319637, "ME_ONLY"}, -- Reclaimed Soul
		{319626, "SAY", "FLASH"}, -- Phantasmal Parasite
		{319669, "TANK"}, -- Spectral Reach
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "DrawSoul", 319521)
	self:Log("SPELL_AURA_APPLIED", "DrawSoulApplied", 319521)
	self:Log("SPELL_AURA_APPLIED", "ReclaimedSoulApplied", 319637)
	self:Log("SPELL_AURA_APPLIED_DOSE", "ReclaimedSoulApplied", 319637)
	self:Log("SPELL_CAST_SUCCESS", "PhantasmalParasite", 319626)
	self:Log("SPELL_AURA_APPLIED", "PhantasmalParasiteApplied", 319626)
	self:Log("SPELL_CAST_SUCCESS", "SpectralReach", 319669)
end

function mod:OnEngage()
	self:Bar(319521, 15.8) -- Draw Soul
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DrawSoul(args)
	self:CDBar(319521, 20.6)
end

function mod:DrawSoulApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "alarm")
	end
end

function mod:ReclaimedSoulApplied(args)
	self:StackMessage(args.spellId, args.destName, args.amount, "green")
	self:PlaySound(args.spellId, "info", nil, args.destName)
end

function mod:PhantasmalParasite(args)
	self:Bar(args.spellId, 25.5)
end

do
	local playerList = mod:NewTargetList()
	function mod:PhantasmalParasiteApplied(args)
		playerList[#playerList+1] = args.destName
		self:TargetsMessage(args.spellId, "orange", playerList, 2, nil, nil, 0.8)
		self:PlaySound(args.spellId, "alert", nil, playerList)
		if self:Me(args.destGUID) then
			self:Say(args.spellId)
			self:Flash(args.spellId)
		end
	end
end

function mod:SpectralReach(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end
