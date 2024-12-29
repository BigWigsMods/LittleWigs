--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Edwin VanCleef", 36, 2631)
if not mod then return end
mod:RegisterEnableMob(639) -- Edwin VanCleef
mod:SetEncounterID(mod:Retail() and 2972 or 2747)
--mod:SetRespawnTime(0)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L["5200_icon"] = "ability_rogue_masterofsubtlety"
	L["450564_desc"] = -29832 -- Shadowstep
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		5200, -- VanCleef's Allies
		450564, -- Shadowstep
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "VanCleefsAllies", 5200)
	if self:Retail() then
		self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1", "boss2") -- Shadowstep
	end
end

function mod:OnEngage()
	if self:Retail() then
		self:CDBar(450564, 5.0) -- Shadowstep
	end
end

--------------------------------------------------------------------------------
-- Classic Initialization
--

if mod:Classic() then
	function mod:GetOptions()
		return {
			5200, -- VanCleef's Allies
		}
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:VanCleefsAllies(args)
	self:Message(args.spellId, "cyan", CL.percent:format(50, args.spellName), L["5200_icon"])
	self:PlaySound(args.spellId, "long")
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, spellId)
	if spellId == 450564 then -- Shadowstep
		self:Message(spellId, "yellow")
		self:CDBar(spellId, 9.7)
		self:PlaySound(spellId, "info")
	end
end
