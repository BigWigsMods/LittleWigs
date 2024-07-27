--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Grimroot", 2784)
if not mod then return end
mod:RegisterEnableMob(226923) -- Grimroot
mod:SetEncounterID(3023)
--mod:SetRespawnTime(30)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.grimroot = "Grimroot"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.grimroot
end

local poisonedSaplingMarker = mod:AddMarkerOption(true, "npc", 8, 460664, 8) -- Poisoned Sapling
function mod:GetOptions()
	return {
		{460509, "SAY"}, -- Corrupted Tears
		{460703, "CASTBAR"}, -- Tender's Rage
		{460727, "CASTBAR"}, -- Gloom
		"adds",
		poisonedSaplingMarker,
	},nil,{
		[460727] = CL.interruptible, -- Gloom (Interruptible)
		["adds"] = self:SpellName(460664), -- Adds (Poisoned Sapling)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "CorruptedTears", 460509)
	self:Log("SPELL_PERIODIC_DAMAGE", "CorruptedTearsDamage", 460515) -- no alert on APPLIED, doesn't damage right away
	self:Log("SPELL_PERIODIC_MISSED", "CorruptedTearsDamage", 460515)
	self:Log("SPELL_CAST_SUCCESS", "TendersRage", 460703)
	self:Log("SPELL_DISPEL", "TendersRageDispelled", "*")
	self:Log("SPELL_CAST_START", "Gloom", 460727)
	self:Log("SPELL_INTERRUPT", "GloomInterrupted", "*")
	self:Log("SPELL_CAST_SUCCESS", "NaturesGrip", 460684)
end

function mod:OnEngage()
	self:CDBar(460509, 5.2) -- Corrupted Tears
	self:CDBar(460727, 30.7) -- Gloom
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local function printTarget(self, name, guid)
		self:TargetMessage(460509, "orange", name)
		if self:Me(guid) then
			self:Say(460509, nil, nil, "Corrupted Tears")
			self:PlaySound(460509, "alarm", nil, name)
		end
	end

	function mod:CorruptedTears(args)
		self:GetUnitTarget(printTarget, 0.3, args.sourceGUID)
		self:Bar(args.spellId, 11.3)
	end
end

do
	local prev = 0
	function mod:CorruptedTearsDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 1.5 then
			prev = args.time
			self:PersonalMessage(460509, "underyou")
			self:PlaySound(460509, "underyou")
		end
	end
end

function mod:TendersRage(args)
	self:Message(args.spellId, "yellow", CL.other:format(CL.killed:format(self:SpellName(460664)), CL.onboss:format(args.spellName))) -- Poisoned Sapling killed: Tender's Rage on BOSS
	self:CastBar(args.spellId, 8)
	if self:Dispeller("enrage", true) then
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:TendersRageDispelled(args)
	if args.extraSpellName == self:SpellName(460703) then
		self:StopBar(CL.cast:format(args.extraSpellName))
		self:Message(460703, "green", CL.removed_by:format(args.extraSpellName, self:ColorName(args.sourceName)))
	end
end

function mod:Gloom(args)
	self:Message(args.spellId, "red", CL.extra:format(CL.casting:format(args.spellName), CL.interruptible))
	self:CastBar(args.spellId, 8)
	self:CDBar(args.spellId, 30.7)
	self:PlaySound(args.spellId, "long")
end

function mod:GloomInterrupted(args)
	if args.extraSpellName == self:SpellName(460727) then
		self:StopBar(CL.cast:format(args.extraSpellName))
		self:Message(460727, "green", CL.interrupted_by:format(args.extraSpellName, self:ColorName(args.sourceName)))
	end
end

do
	local saplingGUID = nil
	function mod:SaplingMarking(_, unit, guid)
		if saplingGUID == guid then
			saplingGUID = nil
			self:CustomIcon(poisonedSaplingMarker, unit, 8)
			self:UnregisterTargetEvents()
		end
	end

	function mod:NaturesGrip(args)
		saplingGUID = args.sourceGUID
		self:RegisterTargetEvents("SaplingMarking")
		self:Message("adds", "cyan", CL.add_spawned, false)
		self:PlaySound("adds", "info")
	end
end
