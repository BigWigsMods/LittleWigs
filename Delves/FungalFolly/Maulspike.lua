--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Maulspike", 2664)
if not mod then return end
mod:RegisterEnableMob(234958) -- Maulspike
mod:SetEncounterID(3121)
mod:SetRespawnTime(15)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.maulspike = "Maulspike"
	L.darkfuse_cackler = "Darkfuse Cackler"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.maulspike
end

function mod:GetOptions()
	return {
		1214614, -- Rip and Tear
		1214620, -- Whooping Rally
		1214656, -- Aggravating Growl
		-- Darkfuse Cackler
		1214680, -- Hideous Cackle
	}, {
		[1214680] = L.darkfuse_cackler,
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("ENCOUNTER_START") -- XXX no boss frames
	self:Log("SPELL_CAST_START", "RipAndTear", 1214614)
	self:Log("SPELL_CAST_START", "WhoopingRally", 1214620)
	self:Log("SPELL_CAST_START", "AggravatingGrowl", 1214656)

	-- Darkfuse Cackler
	self:Log("SPELL_CAST_START", "HideousCackle", 1214680)
end

function mod:OnEngage()
	self:CDBar(1214614, 5.7) -- Rip and Tear
	self:CDBar(1214620, 8.1) -- Whooping Rally
	self:CDBar(1214656, 16.6) -- Aggravating Growl
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:ENCOUNTER_START(_, id) -- XXX no boss frames
	if id == self.engageId then
		self:Engage()
	end
end

function mod:RipAndTear(args)
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 15.8)
	self:PlaySound(args.spellId, "alert")
end

function mod:WhoopingRally(args)
	self:Message(args.spellId, "cyan")
	self:CDBar(args.spellId, 38.9)
	self:PlaySound(args.spellId, "info")
end

function mod:AggravatingGrowl(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 26.7)
	self:PlaySound(args.spellId, "alert")
end

-- Darkfuse Cackler

do
	local prev = 0
	function mod:HideousCackle(args)
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "orange")
			-- 11s CD
			self:PlaySound(args.spellId, "alarm")
		end
	end
end
