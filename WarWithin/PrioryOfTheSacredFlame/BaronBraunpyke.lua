if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Baron Braunpyke", 2649, 2570)
if not mod then return end
mod:RegisterEnableMob(207939) -- Baron Braunpyke
mod:SetEncounterID(2835)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_icon = "inv_achievement_dungeon_prioryofthesacredflame"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		422969, -- Vindictive Wrath
		423015, -- Castigator's Shield
		423051, -- Burning Light
		423062, -- Hammer of Purity
		-- TODO Sacred Pyre (Mythic)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "VindictiveWrath", 422969)
	self:Log("SPELL_CAST_START", "CastigatorsShield", 423015, 446649) -- Standard, Empowered
	self:Log("SPELL_CAST_START", "BurningLight", 423051, 446657) -- Standard, Empowered
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- Hammer of Purity
end

function mod:OnEngage()
	self:StopBar(CL.active)
	self:CDBar(423062, 9.7) -- Hammer of Purity
	self:CDBar(423051, 17.0) -- Burning Light
	self:CDBar(423015, 23.0) -- Castigator's Shield
	self:CDBar(422969, 46.1) -- Vindictive Wrath
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup() -- called from trash module
	-- 239.65 00:07:04 [CHAT_MSG_MONSTER_SAY] They've served their purpose. Baron, demonstrate your worth.#Prioress Murrpray
	-- 247.58 00:07:12 [NAME_PLATE_UNIT_ADDED] Baron Braunpyke
	self:Bar("warmup", 7.9, CL.active, L.warmup_icon)
end

function mod:VindictiveWrath(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "info")
	self:CDBar(args.spellId, 48.6)
end

function mod:CastigatorsShield(args)
	self:Message(423015, "orange")
	self:PlaySound(423015, "alert")
	self:CDBar(423015, 25.5)
end

function mod:BurningLight(args)
	self:Message(423051, "red", CL.casting:format(args.spellName))
	self:PlaySound(423051, "warning")
	self:CDBar(423051, 31.6)
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 446587 then -- Hammer of Purity
		self:Message(423062, "yellow")
		self:PlaySound(423062, "alarm")
		self:CDBar(423062, 19.4)
	end
end
