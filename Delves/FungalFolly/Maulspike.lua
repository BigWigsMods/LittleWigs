--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Maulspike", {2664, 2826}) -- Fungal Folly, Sidestreet Sluice
if not mod then return end
mod:RegisterEnableMob(
	234958, -- Maulspike (Fungal Folly)
	252904, -- Maulspike (Sidestreet Sluice)
	247480 -- Maulspike (Ethereal Routing Station)
)
mod:SetEncounterID({3121, 3374}) -- Fungal Folly, Sidestreet Sluice
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
	self:SetSpellRename(1214620, CL.adds) -- Whooping Rally (Adds)
	self:SetSpellRename(1214680, CL.fear) -- Hideous Cackle (Fear)
end

function mod:GetOptions()
	return {
		1214614, -- Rip and Tear
		1214620, -- Whooping Rally
		1214656, -- Aggravating Growl
		-- Darkfuse Cackler
		1214680, -- Hideous Cackle
	},{
		[1214680] = L.darkfuse_cackler,
	},{
		[1214620] = CL.adds, -- Whooping Rally (Adds)
		[1214680] = CL.fear, -- Hideous Cackle (Fear)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "RipAndTear", 1214614)
	self:Log("SPELL_CAST_START", "WhoopingRally", 1214620)
	self:Log("SPELL_CAST_START", "AggravatingGrowl", 1214656)

	-- Darkfuse Cackler
	self:Log("SPELL_CAST_START", "HideousCackle", 1214680)

	-- Ethereal Routing Station
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1", "boss2", "boss3") -- Teleported
end

function mod:OnEngage()
	self:CDBar(1214614, 5.7) -- Rip and Tear
	self:CDBar(1214620, 8.1, CL.adds) -- Whooping Rally
	self:CDBar(1214656, 16.6) -- Aggravating Growl
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, unit, _, spellId)
	if spellId == 1243416 and self:MobId(self:UnitGUID(unit)) == 247480 then -- Teleported
		-- check mobId because Ethereal Routing Station can have up to 3 bosses engaged at once
		self:Win()
	end
end

function mod:RipAndTear(args)
	self:Message(args.spellId, "purple")
	self:CDBar(args.spellId, 15.8)
	self:PlaySound(args.spellId, "alert")
end

function mod:WhoopingRally(args)
	self:Message(args.spellId, "cyan", CL.adds)
	self:CDBar(args.spellId, 38.9, CL.adds)
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
			self:Message(args.spellId, "orange", CL.fear)
			-- 11s CD
			self:PlaySound(args.spellId, "alarm")
		end
	end
end
