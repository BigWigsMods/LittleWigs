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
		--[[ Ethereal Scavenger ]]--
		33871, -- Shield Bash
		--[[ Ethereal Priest ]]--
		22883, -- Heal
		--[[ Nexus Terror ]]--
		{34322, "SAY"}, -- Psychic Scream
		34922, -- Shadows Embrace
		34925, -- Curse of Impotence
		--[[ Ethereal Theurgist ]]--
		13323, -- Polymorph
	}, {
		[33871] = L.scavenger,
		[22883] = L.priest,
		[34322] = L.nexus_terror,
		[13323] = L.theurgist,
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
		self:TargetMessageOld(args.spellId, args.destName, "yellow", "alarm", nil, nil, true)
		self:TargetBar(args.spellId, 8, args.destName)
	end
end

do
	local prev = 0
	function mod:Heal(args)
		local t = GetTime()
		if t - prev > 1 then
			prev = t
			self:MessageOld(22883, "orange", "long", CL.casting:format(args.spellName))
		end
	end
end

do
	local playerList = mod:NewTargetList()

	function mod:PsychicScream(args)
		if self:Me(args.destGUID) then
			self:Say(args.spellId) -- helps prioritizing dispelling those who are about to run into some pack
		end
		playerList[#playerList+1] = args.destName
		if #playerList == 1 then
			self:ScheduleTimer("TargetMessageOld", 0.3, args.spellId, playerList, "red", "alert", nil, nil, self:Dispeller("magic"))
		end
	end
end

function mod:ShadowsEmbrace(args)
	self:TargetMessageOld(args.spellId, args.destName, "orange", "alarm", nil, nil, self:Dispeller("magic"))
end

function mod:CurseOfImpotence(args)
	if self:Me(args.destGUID) or self:Dispeller("curse") then
		self:TargetMessageOld(args.spellId, args.destName, "yellow")
	end
end

function mod:Polymorph(args)
	self:TargetMessageOld(args.spellId, args.destName, "yellow", "alarm", nil, nil, self:Dispeller("magic"))
end
