--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mana-Tombs Trash", 557)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	18309, -- Ethereal Scavenger
	18317, -- Ethereal Priest
	19307, -- Nexus Terror
	18315 -- Ethereal Theurgist
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.scavenger = "Ethereal Scavenger"
	L.priest = "Ethereal Priest"
	L.nexus_terror = "Nexus Terror"
	L.theurgist = "Ethereal Theurgist"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Ethereal Scavenger
		33871, -- Shield Bash
		-- Ethereal Priest
		22883, -- Heal
		-- Nexus Terror
		{34322, "SAY"}, -- Psychic Scream
		{34922, "DISPEL"}, -- Shadows Embrace
		{34925, "DISPEL"}, -- Curse of Impotence
		-- Ethereal Theurgist
		{13323, "DISPEL"}, -- Polymorph
	},{
		[33871] = L.scavenger,
		[22883] = L.priest,
		[34322] = L.nexus_terror,
		[13323] = L.theurgist,
	},{
		[34322] = CL.fear, -- Psychic Scream (Fear)
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	self:Log("SPELL_INTERRUPT", "ShieldBash", 33871)

	self:Log("SPELL_CAST_START", "Heal", 34945, 22883) -- normal, heroic

	self:Log("SPELL_AURA_APPLIED", "PsychicScream", 34322)
	self:Log("SPELL_AURA_APPLIED", "ShadowsEmbrace", 34922)
	self:Log("SPELL_AURA_APPLIED", "CurseOfImpotence", 34925)

	self:Log("SPELL_AURA_APPLIED", "Polymorph", 13323)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ShieldBash(args)
	if self:Me(args.destGUID) or self:Healer(args.destName) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
	end
end

do
	local prev = 0
	function mod:Heal(args)
		local t = args.time
		if t - prev > 1 then
			prev = t
			self:Message(22883, "orange", CL.casting:format(args.spellName))
			self:PlaySound(22883, "alert")
		end
	end
end

do
	local playerList = mod:NewTargetList()

	function mod:PsychicScream(args)
		if self:Me(args.destGUID) then
			self:Say(args.spellId, CL.fear, nil, "Fear") -- helps prioritizing dispelling those who are about to run into some pack
		end
		playerList[#playerList+1] = args.destName
		if #playerList == 1 then
			self:ScheduleTimer("TargetMessageOld", 0.3, args.spellId, playerList, "red", "alert", CL.fear, nil, self:Dispeller("magic"))
		end
	end
end

function mod:ShadowsEmbrace(args)
	-- can be cast on pets
	if self:Me(args.destGUID) or (self:Player(args.destFlags) and self:Dispeller("magic", nil, args.spellId)) then
		self:TargetMessage(args.spellId, "red", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:CurseOfImpotence(args)
	if self:Me(args.destGUID) or self:Dispeller("curse", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

function mod:Polymorph(args)
	if self:Me(args.destGUID) or self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage(args.spellId, "yellow", args.destName)
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end
