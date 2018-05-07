if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Skycap'n Kragg", 1754, 2102)
if not mod then return end
mod:RegisterEnableMob(126832)
mod.engageId = 2093

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
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
	self:CDBar(255952, 4.8) -- Charrrrrge
end

--------------------------------------------------------------------------------
-- Event Handlers
--


function mod:Charrrrrge(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert", "watchstep")
	self:CDBar(args.spellId, 8.5)
end

function mod:SpawnParrot()
	self:StopBar(255952) -- Charrrrrge
	self:Message("stages", "cyan", nil, CL.stage:format(2), false)
	self:PlaySound("stages", "info", "stage2")

	self:CDBar(256106, 6) -- Azerite Powder Shot
	self:CDBar(256060, 27.5) -- Revitalizing Brew
end

function mod:AzeritePowderShot(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 12.5)
end

function mod:RevitalizingBrew(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "warning", "interrupt")
	self:CDBar(args.spellId, 28.5)
end

do
	local prev = 0
	function mod:VileCoatingDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 1.5 then
				prev = t
				self:Message(args.spellId, "blue", nil, CL.underyou:format(args.spellName))
				self:PlaySound(args.spellId, "alarm", "gtfo")
			end
		end
	end
end
