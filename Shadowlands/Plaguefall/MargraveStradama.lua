--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Margrave Stradama", 2289, 2404)
if not mod then return end
mod:RegisterEnableMob(164267) -- Margrave Stradama
mod:SetEncounterID(2386)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local intermission = false
local intermissionCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		322232, -- Infectious Rain
		322304, -- Malignant Growth
		322475, -- Plague Crash
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1", "boss2")
	self:RegisterUnitEvent("UNIT_TARGETABLE_CHANGED", nil, "boss1")
	self:Log("SPELL_CAST_START", "InfectiousRain", 322232)
	self:Log("SPELL_CAST_SUCCESS", "MalignantGrowth", 322304)
end

function mod:OnEngage()
	intermission = false
	intermissionCount = 0

	self:Bar(322304, 5) -- Malignant Growth
	self:Bar(322475, 11.5) -- Plague Crash
	self:Bar(322232, 15.5) -- Infectious Rain
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 333941 or spellId == 322473 then -- Plague Crash
		self:Message(322475, "green")
		self:PlaySound(322475, "long")
		if intermission == false then
			self:Bar(322475, 20.5)
		end
	elseif spellId == 322477 then -- Start Plague Crash Phase // Intermission
		intermission = true
		intermissionCount = intermissionCount + 1
		self:Message("stages", "green", CL.count:format(CL.intermission, intermissionCount), false)
		self:Bar("stages", 26.6, CL.intermission, "achievement_dungeon_plaguefall")
		self:StopBar(322304) -- Malignant Growth
		self:StopBar(322475) -- Plague Crash
		self:StopBar(322232) -- Infectious Rain
	end
end

function mod:UNIT_TARGETABLE_CHANGED(_, unit)
	if self:MobId(self:UnitGUID(unit)) == 164267 and UnitCanAttack("player", unit) then -- Margrave Stradama
		intermission = false
		self:Message("stages", "green", CL.over:format(CL.intermission), false)
		if intermissionCount < 2 then -- No adds after the last intermission
			self:Bar(322304, 5) -- Malignant Growth
		end
		self:Bar(322475, 11.5) -- Plague Crash
		self:Bar(322232, 15.5) -- Infectious Rain
	end
end

function mod:InfectiousRain(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 20.5)
end

function mod:MalignantGrowth(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
	self:Bar(args.spellId, 20.5)
end
