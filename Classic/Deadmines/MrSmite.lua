--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mr. Smite", 36, 2629)
if not mod then return end
mod:RegisterEnableMob(646) -- Mr. Smite
mod:SetEncounterID(mod:Retail() and 2970 or 2745)
--mod:SetRespawnTime(0)
mod:SetStage(1)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		450550, -- Pistol Shot
		-29823, -- I'll Have to Improvise
		-29813, -- Now I'm Angry
		{6435, "TANK_HEALER"}, -- Smite Slam
	}
end

function mod:OnBossEnable()
	if self:Retail() then
		self:Log("SPELL_CAST_START", "PistolShot", 450550)
	end
	self:Log("SPELL_CAST_SUCCESS", "SmiteStomp", 6432)
	self:Log("SPELL_CAST_SUCCESS", "SmiteSlam", 6435)
	if self:Classic() then
		-- no ENCOUNTER_END on classic
		self:Death("Win", 646)
	end
end

function mod:OnEngage()
	self:SetStage(1)
	if self:Retail() then
		self:CDBar(450550, 4.8) -- Pistol Shot
	end
end

--------------------------------------------------------------------------------
-- Classic Initialization
--

if mod:Classic() then
	function mod:GetOptions()
		return {
			6432, -- Smite Stomp
			{6435, "TANK_HEALER"}, -- Smite Slam
		}
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:PistolShot(args)
	if self:MobId(args.sourceGUID) == 646 then -- Mr. Smite
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:CDBar(args.spellId, 12.1)
		if self:Interrupter() then
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:SmiteStomp(args)
	if self:GetStage() == 1 then -- Stage 1 to Stage 2
		self:SetStage(2)
		if self:Retail() then
			self:Message(-29823, "cyan", CL.percent:format(70, self:SpellName(-29823))) -- I'll Have to Improvise
			self:PlaySound(-29823, "long")
		else -- Classic
			self:Message(args.spellId, "cyan", CL.percent:format(70, args.spellName))
			self:PlaySound(args.spellId, "long")
		end
	else -- Stage 2 to Stage 3
		self:SetStage(3)
		if self:Retail() then
			self:Message(-29813, "cyan", CL.percent:format(35, self:SpellName(-29813))) -- Now I'm Angry
			self:PlaySound(-29813, "long")
		else -- Classic
			self:Message(args.spellId, "cyan", CL.percent:format(35, args.spellName))
			self:PlaySound(args.spellId, "long")
		end
	end
end

function mod:SmiteSlam(args)
	-- only cast in stage 3
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 6.1)
	self:PlaySound(args.spellId, "alarm")
end
