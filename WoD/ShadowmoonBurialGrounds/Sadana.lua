--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Sadana Bloodfury", 1176, 1139)
if not mod then return end
mod:RegisterEnableMob(75509) -- Sadana Bloodfury
mod:SetEncounterID(1677)
mod:SetRespawnTime(33)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.custom_on_markadd = "Mark the Dark Communion Add"
	L.custom_on_markadd_desc = "Mark the add spawned by Dark Communion with {rt8}, requires promoted or leader."
	L.custom_on_markadd_icon = 8
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		153153, -- Dark Communion
		"custom_on_markadd", -- Add marker option
		153240, -- Daggerfall
		153224, -- Shadow Burn
		153094, -- Whispers of the Dark Star
		164974, -- Dark Eclipse
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "DarkCommunion", 153153)
	self:Log("SPELL_CAST_SUCCESS", "Daggerfall", 153240)
	self:Log("SPELL_MISSED", "ShadowBurnDamage", 153224)
	self:Log("SPELL_DAMAGE", "ShadowBurnDamage", 153224)
	self:Log("SPELL_AURA_APPLIED", "ShadowBurnDamage", 153224)
	self:Log("SPELL_CAST_SUCCESS", "WhispersOfTheDarkStar", 153094)
	self:Log("SPELL_CAST_SUCCESS", "DarkEclipse", 164974)
end

function mod:OnEngage()
	self:CDBar(153240, 8.8) -- Daggerfall
	self:CDBar(153094, 15.5) -- Whispers of the Dark Star
	self:CDBar(153153, 24) -- Dark Commmunion
	self:CDBar(164974, 38.9) -- Dark Eclipse
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Daggerfall(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 8.5)
end

do
	local prev = 0
	function mod:ShadowBurnDamage(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 1.5 then
				prev = t
				self:PersonalMessage(args.spellId, "underyou")
				self:PlaySound(args.spellId, "underyou")
			end
		end
	end
end

function mod:DarkCommunion(args)
	self:Message(args.spellId, "cyan", CL.add_spawned)
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 60.6)
	if self:GetOption("custom_on_markadd") then
		self:RegisterTargetEvents("MarkDefiledSpirit")
	end
end

function mod:MarkDefiledSpirit(_, unit, guid)
	if self:MobId(guid) == 75966 then -- Defiled Spirit
		self:CustomIcon(false, unit, 8)
		self:UnregisterTargetEvents()
	end
end

function mod:WhispersOfTheDarkStar(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 35.1)
end

function mod:DarkEclipse(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "warning")
	self:CDBar(args.spellId, 46.1)
end
