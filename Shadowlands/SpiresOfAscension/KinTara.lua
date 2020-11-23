--------------------------------------------------------------------------------
-- TODO:
-- - Mythic Abilties
-- - Improve timers
-- - Respawn

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Kin-Tara", 2285, 2399)
if not mod then return end
mod:RegisterEnableMob(162059, 163077) -- Kin-Tara, Azoras
mod.engageId = 2357
--mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		320966, -- Overhead Slash
		327481, -- Dark Lance
		321009, -- Charged Spear
		324368, -- Attenuated Barrage
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "OverheadSlash", 320966)
	self:Log("SPELL_CAST_START", "DarkLance", 327481)
	self:Log("SPELL_CAST_START", "ChargedSpear", 321009)
	self:Log("SPELL_CAST_START", "AttenuatedBarrage", 324368)


end

function mod:OnEngage()
	self:Bar(324368, 6) -- Attenuated Barrage
	self:Bar(320966, 8.5) -- Overhead Slash
	self:Bar(327481, 9.7) -- Dark Lance
	self:Bar(321009, 34) -- Charged Spear
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:OverheadSlash(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	self:Bar(args.spellId, 9.7)
end

function mod:DarkLance(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	--self:Bar(args.spellId, 9.7)
end

function mod:ChargedSpear(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alert")
	--self:Bar(args.spellId, 9.7)
end

do
	local prev = 0
	function mod:AttenuatedBarrage(args)
		local t = args.time
		if t-prev > 5 then -- 3 casts, long cooldown, repeat
			prev = t
			self:Message(args.spellId, "cyan")
			self:PlaySound(args.spellId, "long")
			self:CDBar(args.spellId, 14.5)
		end
	end
end