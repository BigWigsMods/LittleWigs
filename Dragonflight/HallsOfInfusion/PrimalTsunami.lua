-- TODOs
-- stage 1 trigger after cast away
-- stage 2 abilities


if not IsTestBuild() then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Primal Tsunami", 2527, 2511)
if not mod then return end
mod:RegisterEnableMob(189729) -- Primal Tsunami
mod:SetEncounterID(2618)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		387559, -- Infused Globules
		388424, -- Tempest's Fury
		{387504, "TANK"}, -- Squall Buffet
	}, {
		[387559] = -25529, -- Stage One: Violent Swells
		[388420] = -25531, -- Stage Two: Infused Waters -- TODO use an actual stage 2 ability key
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	
	self:Log("SPELL_CAST_START", "InfusedGlobules", 387559)
	self:Log("SPELL_CAST_START", "TempestsFury", 388424)
	self:Log("SPELL_CAST_START", "SquallBuffet", 387504)
end

function mod:OnEngage()
	self:SetStage(1)
	self:Bar(388424, 4) -- Tempest's Fury
	self:Bar(387504, 16) -- Squall Buffet
	self:Bar(387559, 17.6) -- Infused Globules
	self:Bar("stages", 51, CL.stage:format(2), 388420) -- Cast Away (Stage 2)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg)
	if msg:find("388420", nil, true) then -- Cast Away
		self:SetStage(2)
		self:Message("stages", "cyan", CL.stage:format(2), 388420)
		self:PlaySound("stages", "long")
	end
end

function mod:InfusedGlobules(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 17.6)
end

function mod:TempestsFury(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 30)
end

function mod:SquallBuffet(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
end
