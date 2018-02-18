-------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ingvar the Plunderer", nil, 640, 574)
if not mod then return end
--mod.otherMenu = "Howling Fjord"
mod:RegisterEnableMob(23954)
--mod.engageId = 2025 -- no ENCOUNTER_END on a successful kill
--mod.respawnTime = 30

-------------------------------------------------------------------------------
--  Locals
--

local deaths = 0

-------------------------------------------------------------------------------
--  Initialization
--

function mod:GetOptions()
	return {
		42723, -- Smash
		42708, -- Roar
		42730, -- Woe Strike
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "CheckForEngage")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")

	self:Log("SPELL_CAST_START", "Smash", 42723, 42669, 59706) -- Dark Smash, Smash x2
	self:Log("SPELL_CAST_START", "Roar", 42708, 42729, 59708, 59734) -- (Staggering Roar, Dreadful Roar) x 2
	self:Log("SPELL_AURA_APPLIED", "WoeStrike", 42730, 59735)

	self:Death("Deaths", 23954)
end

function mod:OnEngage()
	deaths = 0
end

-------------------------------------------------------------------------------
--  Event Handlers
--

function mod:Smash(args)
	self:Message(42723, "Urgent", nil, CL.casting:format(args.spellName), args.spellId)
	self:CastBar(42723, 3, args.spellId)
end

function mod:Roar(args)
	self:Message(42708, "Urgent", nil, CL.casting:format(args.spellName), args.spellId)
end

function mod:Deaths()
	deaths = deaths + 1
	if deaths == 2 then
		self:Win()
	end
end

function mod:WoeStrike(args)
	self:TargetMessage(42730, args.destName, "Urgent")
	self:TargetBar(42730, 10, args.destName)
end
