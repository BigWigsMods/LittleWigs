
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Xav the Unfallen", 2293, 2390)
if not mod then return end
mod:RegisterEnableMob(162329)
mod.engageId = 2366
--mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.defeated = "%s has defeated %s"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- General
		{320644, "TANK_HEALER"}, -- Brutal Combo
		320102, -- Blood and Glory
		331618, -- Oppressive Banner
		320050, -- Might of Maldraxxus
		320729, -- Massive Cleave
		317231, -- Crushing Slam
		-- Mythic
		339415, -- Deafening Crash
	}, {
		[320644] = "general",
		[339415] = "mythic",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	self:Log("SPELL_CAST_START", "BrutalCombo", 320644)
	self:Log("SPELL_CAST_START", "DeafeningCrash", 339415)
	self:Log("SPELL_CAST_START", "MassiveCleave", 320729)
	self:Log("SPELL_CAST_SUCCESS", "BloodAndGlory", 320114)
	self:Log("SPELL_AURA_APPLIED", "BloodAndGloryApplied", 320102)
	self:Log("SPELL_CAST_START", "CrushingSlam", 317231)
	self:Log("SPELL_CAST_SUCCESS", "MightOfMaldraxxus", 320050)
	self:Log("SPELL_CAST_SUCCESS", "OppressiveBanner", 331618)
end

function mod:OnEngage()
	self:Bar(320644, 5.7) -- Brutal Combo
	self:Bar(331618, 10.6) -- Oppressive Banner
	self:Bar(320050, 16.7) -- Might of Maldraxxus
	self:Bar(320102, 33.7) -- Blood and Glory
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, text, winner, _, _, loser)
	if text:find("Ability_PVP_GladiatorMedallion") then
		self:Message(320102, "yellow", L.defeated:format(self:ColorName(winner), self:ColorName(loser))) -- Blood and Glory
		self:PlaySound(320102, "info") -- Blood and Glory
	end
end

function mod:BrutalCombo(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
end

function mod:DeafeningCrash(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:MassiveCleave(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:BloodAndGlory(args)
	self:CDBar(320102, 70) -- Blood and Glory
end

do
	local playerList = mod:NewTargetList()
	function mod:BloodAndGloryApplied(args)
		playerList[#playerList+1] = args.destName
		if #playerList == 2 then
			self:PlaySound(args.spellId, "long")
		end
		self:TargetsMessage(args.spellId, "yellow", playerList, 2, nil, nil, 1) -- 1s wait time as it can be a little delayed sometimes
	end
end

function mod:CrushingSlam(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

function mod:MightOfMaldraxxus(args)
	self:CDBar(args.spellId, 30)
end

function mod:OppressiveBanner(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 30)
end
