--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Balnazzar", 329, 449)
if not mod then return end
mod:RegisterEnableMob(
	10812, -- Grand Crusader Dathrohan (Classic only)
	10813 -- Balnazzar
)
mod:SetEncounterID(478)
--mod:SetRespawnTime(0) resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		80750, -- Mind Blast
		452927, -- Shadow Shock
		17405, -- Domination
		{452928, "DISPEL"}, -- Sleep
		13704, -- Psychic Scream
	}
end

function mod:OnBossEnable()
	if self:Classic() then
		self:Log("SPELL_CAST_SUCCESS", "CrusadersHammer", 17286)
	end
	if self:Vanilla() then
		self:Log("SPELL_CAST_START", "MindBlast", 17287)
	else -- Cata, Retail
		self:Log("SPELL_CAST_START", "MindBlast", 80750)
	end
	if self:Retail() then
		self:Log("SPELL_CAST_START", "ShadowShock", 452927)
		self:Log("SPELL_CAST_START", "Domination", 17405)
		self:Log("SPELL_AURA_APPLIED", "DominationApplied", 17405)
		self:Log("SPELL_CAST_START", "Sleep", 452928)
		self:Log("SPELL_AURA_APPLIED", "SleepApplied", 452928)
	else -- Cata, Classic
		self:Log("SPELL_CAST_START", "Sleep", 12098)
		self:Log("SPELL_AURA_APPLIED", "SleepApplied", 12098)
	end
	self:Log("SPELL_CAST_SUCCESS", "PsychicScream", 13704)
	if self:Heroic() then -- no encounter events in Timewalking
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
		self:Death("Win", 10813)
	end
end

function mod:OnEngage()
	self:CDBar(80750, 6.2) -- Mind Blast
	if not self:Solo() then
		self:CDBar(452928, 9.5) -- Sleep
	end
	self:CDBar(452927, 9.8) -- Shadow Shock
	if not self:Solo() then
		self:CDBar(17405, 14.7) -- Domination
	end
	self:CDBar(13704, 26.8) -- Psychic Scream
end

--------------------------------------------------------------------------------
-- Classic Initialization
--

if mod:Classic() and not mod:Vanilla() then
	function mod:GetOptions()
		return {
			-- Grand Crusader Dathrohan
			17286, -- Crusader's Hammer
			-- Balnazzar
			12098, -- Sleep
			80750, -- Mind Blast
			13704, -- Psychic Scream
		}
	end

	function mod:OnEngage()
		-- starts off as Grand Crusader Dathrohan
	end
end

--------------------------------------------------------------------------------
-- Vanilla Initialization
--

if mod:Vanilla() then
	function mod:GetOptions()
		return {
			-- Grand Crusader Dathrohan
			17286, -- Crusader's Hammer
			-- Balnazzar
			12098, -- Sleep
			17287, -- Mind Blast
			13704, -- Psychic Scream
		}
	end

	function mod:OnEngage()
		-- starts off as Grand Crusader Dathrohan
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:MindBlast(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 10.9)
	self:PlaySound(args.spellId, "alert")
end

function mod:ShadowShock(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 15.8)
	self:PlaySound(args.spellId, "alarm")
end

function mod:PsychicScream(args)
	self:Message(args.spellId, "yellow")
	self:CDBar(args.spellId, 21.8)
	self:PlaySound(args.spellId, "info")
end

function mod:Domination(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 29.1)
	self:PlaySound(args.spellId, "warning")
end

function mod:DominationApplied(args)
	self:TargetMessage(args.spellId, "cyan", args.destName)
	self:PlaySound(args.spellId, "info", nil, args.destName)
end

function mod:Sleep(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 20.6)
	self:PlaySound(args.spellId, "alert")
end

function mod:SleepApplied(args)
	if self:Me(args.destGUID) or self:Dispeller("magic", nil, args.spellId) then
		self:TargetMessage(args.spellId, "cyan", args.destName)
		self:PlaySound(args.spellId, "info", nil, args.destName)
	end
end

--------------------------------------------------------------------------------
-- Classic Event Handlers
--

function mod:CrusadersHammer(args)
	self:Message(args.spellId, "orange")
	-- unknown CD
	self:PlaySound(args.spellId, "info")
end
