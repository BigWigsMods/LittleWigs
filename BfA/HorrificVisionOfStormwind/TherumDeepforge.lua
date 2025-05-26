--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Therum Deepforge", 2213)
if not mod then return end
mod:RegisterEnableMob(
	156577, -- Therum Deepforge
	233679 -- Therum Deepforge (Revisited)
)
mod:SetEncounterID({2374, 3082}) -- BFA, Revisited
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.therum_deepforge = "Therum Deepforge"
	L["305708_icon"] = "spell_fire_selfdestruct"
	L["305708_desc"] = 305672
	L.warmup_icon = "spell_arcane_teleportstormwind"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		305708, -- Explosive Ordnance
		309671, -- Empowered Forge Breath
	}
end

function mod:OnRegister()
	self.displayName = L.therum_deepforge
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1") -- Explosive Ordnance
	self:Log("SPELL_CAST_START", "EmpoweredForgeBreath", 309671)
end

function mod:OnEngage()
	self:StopBar(CL.active)
	self:CDBar(305708, 2.2, nil, L["305708_icon"]) -- Explosive Ordnance
	self:CDBar(309671, 8.2) -- Empowered Forge Breath
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup() -- called from trash module
	-- 5.29 [CHAT_MSG_MONSTER_YELL] So ye like tae play with explosives, do ye? Then let's play.#Therum Deepforge
	-- 12.59 [NAME_PLATE_UNIT_ADDED] Therum Deepforge#Creature-0-4170-2827-2881-233679
	self:Bar("warmup", 7.3, CL.active, L.warmup_icon)
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 305708 then -- Explosive Ordnance
		self:Message(spellId, "orange", nil, L["305708_icon"])
		self:CDBar(spellId, 12.2, nil, L["305708_icon"])
		self:PlaySound(spellId, "info")
	end
end

function mod:EmpoweredForgeBreath(args)
	self:Message(args.spellId, "red")
	self:CDBar(args.spellId, 13.3)
	self:PlaySound(args.spellId, "alarm")
end
