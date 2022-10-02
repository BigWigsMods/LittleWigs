if not IsTestBuild() then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Teera And Maruuk", 2516, 2478)
if not mod then return end
mod:RegisterEnableMob(
	186339, -- Teera
	186338  -- Maruuk
)
mod:SetEncounterID(2581)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- General
		392198, -- Ancestral Bond
		-- Teera
		382670, -- Gale Arrow
		386547, -- Repel
		384808, -- Guardian Wind
		385434, -- Spirit Leap
		-- Maruuk
		385339, -- Earthsplitter
		386063, -- Frightful Roar
		{382836, "TANK_HEALER"}, -- Brutalize
	}, {
		[392198] = CL.general,
		[382670] = -25552, -- Teera
		[385339] = -25546, -- Maruuk
	}
end

function mod:OnBossEnable()
	-- General
	self:Log("SPELL_AURA_APPLIED", "AncestralBondApplied", 392198)
	self:Log("SPELL_AURA_REMOVED", "AncestralBondRemoved", 392198)

	-- Teera
	self:Log("SPELL_CAST_START", "GaleArrow", 382670)
	self:Log("SPELL_CAST_START", "Repel", 386547)
	self:Log("SPELL_AURA_APPLIED", "GuardianWind", 384808)
	self:Log("SPELL_CAST_START", "SpiritLeap", 385434)

	-- Maruuk
	self:Log("SPELL_CAST_START", "Earthsplitter", 385339)
	self:Log("SPELL_CAST_START", "FrightfulRoar", 386063)
	self:Log("SPELL_CAST_START", "Brutalize", 382836)
end

function mod:OnEngage()
	self:Bar(382836, 8.7) -- Brutalize
	self:Bar(385434, 11.1) -- Spirit Leap
	self:Bar(386063, 12.2) -- Frightful Roar
	self:Bar(382670, 14.8) -- Gale Arrow
	self:Bar(386547, 20.4) -- Repel
	self:Bar(385339, 21.6) -- Earthsplitter
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- General

do
	local prev = 0
	function mod:AncestralBondApplied(args)
		local t = args.time
		if t-prev > 1 then
			prev = t
			self:Message(args.spellId, "red", CL.onboss:format(args.spellName))
			self:PlaySound(args.spellId, "warning")
		end
	end
end

do
	local prev = 0
	function mod:AncestralBondRemoved(args)
		local t = args.time
		if t-prev > 1 then
			prev = t
			self:Message(args.spellId, "green", CL.removed:format(args.spellName))
			self:PlaySound(args.spellId, "info")
		end
	end
end

-- Teera

function mod:GaleArrow(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	-- TODO CD, cast at 100 energy, ~20 seconds
end

function mod:Repel(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	-- TODO CD
end

function mod:GuardianWind(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:SpiritLeap(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	self:Bar(args.spellId, 27.5)
end

-- Maruuk

function mod:Earthsplitter(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
	-- TODO CD, cast at 100 energy, ~20 seconds
end

function mod:FrightfulRoar(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	-- TODO CD
end

function mod:Brutalize(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 30)
end
