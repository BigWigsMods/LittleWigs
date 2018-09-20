--------------------------------------------------------------------------------
-- TODO:
-- Add spawn timers
--

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Avatar of Sethraliss", 1877, 2145)
if not mod then return end
mod:RegisterEnableMob(136250, 133392) -- Hoodoo Hexxer, Avatar of Sethraliss
mod.engageId = 2127

--------------------------------------------------------------------------------
-- Locals
--

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		269688, -- Rain of Toads
		273677, -- Taint
		268024, -- Pulse
		269686, -- Plague
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")

	self:Log("SPELL_CAST_SUCCESS", "Taint", 273677)
	self:Log("SPELL_AURA_APPLIED", "Pulse", 268024)
	self:Log("SPELL_AURA_APPLIED", "Plague", 269686)
	self:Log("SPELL_AURA_REMOVED", "PlagueRemoved", 269686)
end

function mod:OnEngage()
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Rain of Toads
function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg)
	if msg:find("269688", nil, true) then
		self:Message2(269688, "cyan")
		self:PlaySound(269688, "info")
		-- self:CDBar(269688, ???) -- pull:36.76, 36.93, 50.1
	end
end

do
	local prev = 0
	function mod:Taint(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message2(args.spellId, "red")
			self:PlaySound(args.spellId, "warning")
		end
	end
end

do
	local prev = 0
	function mod:Pulse(args)
		local t = args.time
		if t - prev > 2 then
			prev = t
			self:Message2(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alert")
			self:Bar(args.spellId, 40)
		end
	end
end

function mod:Plague(args)
	if self:Me(args.destGUID) or self:Dispeller("disease") then
		self:TargetMessage2(args.spellId, "orange", args.destName)
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
		self:TargetBar(args.spellId, 12, args.destName)
	end
end

function mod:PlagueRemoved(args)
	self:StopBar(args.spellName, args.destName)
end
