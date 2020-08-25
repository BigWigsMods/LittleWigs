
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
		319521, -- Draw Soul
		{319637, "ME_ONLY"}, -- Reclaimed Soul
		{319626, "SAY", "FLASH"}, -- Phantasmal Parasite
		{319669, "TANK"}, -- Spectral Reach
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "DrawSoulApplied", 319521)
	self:Log("SPELL_AURA_APPLIED", "ReclaimedSoul", 319637)
	self:Log("SPELL_AURA_APPLIED", "PhantasmalParasite", 319626)
	self:Log("SPELL_CAST_SUCCESS", "SpectralReach", 319669)
end

function mod:OnEngage()
	self:Bar(319521, 15.8) -- Draw Soul
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local playerList = mod:NewTargetList()
	function mod:DrawSoulApplied(args)
		playerList[#playerList+1] = args.destName
		self:TargetsMessage(args.spellId, "orange", playerList, 2)
		self:PlaySound(args.spellId, "alert", nil, playerList)
	end
end

function mod:ReclaimedSoul(args)
	self:StackMessage(args.spellId, args.destName, args.amount, "green")
	self:PlaySound(args.spellId, "info", nil, args.destName)
end

function mod:PhantasmalParasite(args)
	self:TargetMessage2(args.spellId, "yellow", args.destName)
	self:PlaySound(args.spellId, "alert", nil, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
		self:Flash(args.spellId)
	end
end

function mod:SpectralReach(args)
	self:Message2(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end
