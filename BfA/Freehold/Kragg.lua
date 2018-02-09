--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Skycap'n Kragg", 0, 0) -- XXX
if not mod then return end
mod:RegisterEnableMob(126832)
mod.engageId = 2093

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		255952, -- Charrrrrge
		256106, -- Azerite Powder Shot
		256060, -- Revitalizing Brew
		256016, -- Vile Coating
	}
end

function mod:OnBossEnable()
	-- Stage 1
	self:Log("SPELL_CAST_START", "Charrrrrge", 255952)
	self:Log("SPELL_CAST_SUCCESS", "SpawnParrot", 256056) -- Stage 2

	-- Stage 2
	self:Log("SPELL_CAST_START", "AzeritePowderShot", 256106)
	self:Log("SPELL_CAST_SUCCESS", "RevitalizingBrew", 256060)
	self:Log("SPELL_AURA_APPLIED", "VileCoatingDamage", 256016)
	self:Log("SPELL_PERIODIC_DAMAGE", "VileCoatingDamage", 256016)
	self:Log("SPELL_PERIODIC_MISSED", "VileCoatingDamage", 256016)
end

function mod:OnEngage()
	self:CDBar(255952, 6.8) -- Charrrrrge
end

--------------------------------------------------------------------------------
-- Event Handlers
--


function mod:Charrrrrge(args)
	self:Message(args.spellId, "yellow", "Alert")
	self:CDBar(args.spellId, 8.5)
end

function mod:SpawnParrot(args)
	self:StopBar(255952) -- Charrrrrge

	self:CDBar(256106, 6) -- Azerite Powder Shot
	self:CDBar(256060, 27.5) -- Revitalizing Brew
end

function mod:AzeritePowderShot(args)
	self:Message(args.spellId, "yellow", "Alert")
	self:CDBar(args.spellId, 12.5)
end

function mod:RevitalizingBrew(args)
	self:Message(args.spellId, "red", "Warning")
	self:CDBar(args.spellId, 28.5)
end

do
	local prev = 0
	function mod:VileCoatingDamage(args)
		if self:Me(args.destGUID) and GetTime()-prev > 1.5 then
			prev = GetTime()
			self:Message(194668, "blue", "Alarm", CL.underyou:format(args.spellName))
		end
	end
end
