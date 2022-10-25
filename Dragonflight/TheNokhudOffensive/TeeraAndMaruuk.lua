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
		-- Teera
		382670, -- Gale Arrow
		386547, -- Repel
		384808, -- Guardian Wind
		385434, -- Spirit Leap
		-- Maruuk
		385339, -- Earthsplitter
		386063, -- Frightful Roar
		{382836, "TANK_HEALER"}, -- Brutalize
		-- Mythic
		392198, -- Ancestral Bond
	}, {
		[382670] = -25552, -- Teera
		[385339] = -25546, -- Maruuk
		[392198] = "mythic",
	}
end

function mod:OnBossEnable()
	-- Teera
	self:Log("SPELL_CAST_START", "GaleArrow", 382670)
	self:Log("SPELL_CAST_START", "Repel", 386547)
	self:Log("SPELL_AURA_APPLIED", "GuardianWind", 384808)
	self:Log("SPELL_CAST_START", "SpiritLeap", 385434)

	-- Maruuk
	self:Log("SPELL_CAST_START", "Earthsplitter", 385339)
	self:Log("SPELL_CAST_START", "FrightfulRoar", 386063)
	self:Log("SPELL_CAST_START", "Brutalize", 382836)

	-- Mythic
	self:Log("SPELL_AURA_APPLIED", "AncestralBondApplied", 392198)
	self:Log("SPELL_AURA_REMOVED", "AncestralBondRemoved", 392198)
end

function mod:OnEngage()
	self:Bar(382836, 8.6) -- Brutalize
	self:Bar(385434, 11.0) -- Spirit Leap
	self:Bar(386063, 12.2) -- Frightful Roar
	self:Bar(382670, 14.6) -- Gale Arrow
	self:Bar(386547, 20.4) -- Repel
	self:Bar(385339, 21.5) -- Earthsplitter
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Teera

function mod:GaleArrow(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 26.7)
end

function mod:Repel(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 31)
end

function mod:GuardianWind(args)
	self:Message(args.spellId, "orange", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:SpiritLeap(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 26.7)
end

-- Maruuk

function mod:Earthsplitter(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 30.4)
end

function mod:FrightfulRoar(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 25.6)
end

function mod:Brutalize(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 30)
end

-- Mythic

do
	local prev = 0
	function mod:AncestralBondApplied(args)
		-- bosses enrage if more than 20 yards apart
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
