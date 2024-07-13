--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Destructor's Wraith", 2784)
if not mod then return end
mod:RegisterEnableMob(228022) -- The Destructor's Wraith
mod:SetEncounterID(3028)
--mod:SetRespawnTime(30)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.destructors_wraith = "Destructor's Wraith"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.destructors_wraith
end

function mod:GetOptions()
	return {
		462226, -- Destructor's Devastation
		460401, -- Nether Nova
		{462250, "DISPEL"}, -- Curse of Agony
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("ENCOUNTER_START") -- no boss frames
	self:Log("SPELL_CAST_START", "DestructorsDevastation", 462222, 462160, 461761) -- first, second, third
	self:Log("SPELL_CAST_SUCCESS", "NetherNova", 460401)
	self:Log("SPELL_CAST_SUCCESS", "CurseOfAgony", 462250)
	self:Log("SPELL_AURA_APPLIED", "CurseOfAgonyApplied", 462250)
end

function mod:OnEngage()
	self:CDBar(462226, 19.3) -- Destructor's Devastation
	self:CDBar(460401, 30.7) -- Nether Nova
	self:CDBar(462250, 34.7) -- Curse Of Agony
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ENCOUNTER_START(_, id)
	if id == self.engageId then
		self:Engage()
	end
end

function mod:DestructorsDevastation(args)
	self:Message(462226, "orange")
	self:PlaySound(462226, "alarm")
	if args.spellId == 462222 then -- first in sequence
		self:CDBar(462226, 38.9)
	end
end

function mod:NetherNova(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 38.9)
end

do
	local playerList = {}

	function mod:CurseOfAgony(args)
		playerList = {}
		self:CDBar(args.spellId, 38.9)
	end

	function mod:CurseOfAgonyApplied(args)
		if self:Dispeller("curse", nil, args.spellId) or self:Me(args.destGUID) then
			playerList[#playerList + 1] = args.destName
			self:PlaySound(args.spellId, "alert", nil, playerList)
			self:TargetsMessage(args.spellId, "yellow", playerList, 2)
		end
	end
end
