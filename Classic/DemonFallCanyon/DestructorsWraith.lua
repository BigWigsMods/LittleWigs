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
	},nil,{
		[462250] = CL.curse, -- Curse of Agony (Curse)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "DestructorsDevastation", 462222, 462160, 461761) -- first, second, third
	self:Log("SPELL_CAST_SUCCESS", "NetherNova", 460401)
	self:Log("SPELL_CAST_SUCCESS", "CurseOfAgony", 462250)
	self:Log("SPELL_AURA_APPLIED", "CurseOfAgonyApplied", 462250)
end

function mod:OnEngage()
	self:CDBar(462226, 19.3) -- Destructor's Devastation
	self:CDBar(460401, 30.7) -- Nether Nova
	self:CDBar(462250, 34.7, CL.curse) -- Curse Of Agony
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:DestructorsDevastation(args)
	if args.spellId == 462222 then -- first in sequence of 3
		self:Message(462226, "orange", CL.count_amount:format(args.spellName, 1, 3))
		self:CDBar(462226, 38.9)
	elseif args.spellId == 462160 then -- second
		self:Message(462226, "orange", CL.count_amount:format(args.spellName, 2, 3))
	else -- 461761, third
		self:Message(462226, "orange", CL.count_amount:format(args.spellName, 3, 3))
	end
	self:PlaySound(462226, "alarm")
end

function mod:NetherNova(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 38.9)
	self:PlaySound(args.spellId, "alarm")
end

do
	local playerList = {}

	function mod:CurseOfAgony(args)
		playerList = {}
		self:CDBar(args.spellId, 38.9, CL.curse)
	end

	function mod:CurseOfAgonyApplied(args)
		if self:Dispeller("curse", nil, args.spellId) or self:Me(args.destGUID) then
			playerList[#playerList + 1] = args.destName
			self:TargetsMessage(args.spellId, "yellow", playerList, 2, CL.curse)
			self:PlaySound(args.spellId, "alert", nil, playerList)
		end
	end
end
