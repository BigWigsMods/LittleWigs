--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Bromach", 2451, 2487)
if not mod then return end
mod:RegisterEnableMob(184018) -- Bromach
mod:SetEncounterID(2556)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Locals
--

local quakingTotemCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

local totemMarker = mod:AddMarkerOption(true, "npc", 8, 369700, 8) -- Quaking Totem
function mod:GetOptions()
	return {
		-- Bromach
		369605, -- Call of the Deep
		369700, -- Quaking Totem
		totemMarker,
		369754, -- Bloodlust
		369703, -- Thundering Slam
		-- Stonevault Geomancer
		369675, -- Chain Lightning
		-- Quaking Totem
		369660, -- Tremor
	}, {
		[369605] = self.displayName,
		[369675] = -24988, -- Stonevault Geomancer
		[369660] = 369700, -- Quaking Totem
	}
end

function mod:OnBossEnable()
	-- Bromach
	self:Log("SPELL_CAST_SUCCESS", "CallOfTheDeep", 369605)
	self:Log("SPELL_CAST_START", "QuakingTotem", 382303)
	self:Log("SPELL_SUMMON", "QuakingTotemSummon", 382302)
	self:Log("SPELL_CAST_START", "Bloodlust", 369754)
	self:Log("SPELL_CAST_START", "ThunderingSlam", 369703)
	self:Log("SPELL_CAST_SUCCESS", "ThunderingSlamSuccess", 369703)

	-- Stonevault Geomancer
	self:Log("SPELL_CAST_START", "ChainLightning", 369675)

	-- Quaking Totem
	self:Log("SPELL_AURA_APPLIED", "TremorApplied", 369725)
end

function mod:OnEngage()
	quakingTotemCount = 1
	self:CDBar(369605, 5.1) -- Call of the Deep
	self:Bar(369700, 20.4, CL.count:format(self:SpellName(369700), quakingTotemCount)) -- Quaking Totem
	self:CDBar(369703, 12.1) -- Thundering Slam
	self:Bar(369754, 27.9) -- Bloodlust
end

function mod:OnWin()
	local trashMod = BigWigs:GetBossModule("Uldaman: Legacy of Tyr Trash", true)
	if trashMod then
		trashMod:Enable()
		trashMod:BromachDefeated()
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Bromach

function mod:CallOfTheDeep(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
	self:CDBar(args.spellId, 28.0)
end

function mod:QuakingTotem(args)
	self:StopBar(CL.count:format(args.spellName, quakingTotemCount))
	self:Message(369700, "yellow", CL.count:format(args.spellName, quakingTotemCount))
	self:PlaySound(369700, "info")
	quakingTotemCount = quakingTotemCount + 1
	self:Bar(369700, 30.3, CL.count:format(args.spellName, quakingTotemCount))
end

do
	local totemGUID = nil

	function mod:QuakingTotemSummon(args)
		-- register events to auto-mark totem
		if self:GetOption(totemMarker) then
			totemGUID = args.destGUID
			self:RegisterTargetEvents("MarkTotem")
		end
	end

	function mod:MarkTotem(_, unit, guid)
		if totemGUID == guid then
			totemGUID = nil
			self:CustomIcon(totemMarker, unit, 8)
			self:UnregisterTargetEvents()
		end
	end
end

function mod:Bloodlust(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alert")
	self:Bar(args.spellId, 30.3)
end

function mod:ThunderingSlam(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
	-- this doesn't go on cooldown if interrupted with Tremor
end

function mod:ThunderingSlamSuccess(args)
	-- 18.2s CD - 3.5s cast
	self:CDBar(args.spellId, 14.7)
end

-- Stonevault Geomancer

function mod:ChainLightning(args)
	if self:MobId(args.sourceGUID) == 186658 then -- Stonevault Geomancer (boss version)
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
	end
end

-- Quaking Totem

function mod:TremorApplied(args)
	if self:MobId(args.destGUID) == 184018 then -- Bromach
		self:Message(369660, "green", CL.onboss:format(args.spellName))
		self:PlaySound(369660, "info")
		self:Bar(369660, 10, CL.onboss:format(args.spellName))
		-- Tremor being applied to Bromach adds 9.8 seconds to timers,
		-- but since the stun lasts 10s there is a 10s minimum.
		local callOfTheDeepTimeLeft = self:BarTimeLeft(369605) -- Call of the Deep
		if callOfTheDeepTimeLeft >= .2 then
			self:CDBar(369605, {callOfTheDeepTimeLeft + 9.8, 37.8})
		else
			self:CDBar(369605, {10, 37.8})
		end
		local quakingTotemTimeLeft = self:BarTimeLeft(CL.count:format(self:SpellName(369700), quakingTotemCount)) -- Quaking Totem
		if quakingTotemTimeLeft >= .2 then
			self:Bar(369700, {quakingTotemTimeLeft + 9.8, 40.1}, CL.count:format(self:SpellName(369700), quakingTotemCount))
		else
			self:Bar(369700, {10, 40.1}, CL.count:format(self:SpellName(369700), quakingTotemCount))
		end
		local bloodlustTimeLeft = self:BarTimeLeft(369754) -- Bloodlust
		if bloodlustTimeLeft >= .2 then
			self:Bar(369754, {bloodlustTimeLeft + 9.8, 40.1})
		else
			self:Bar(369754, {10, 40.1})
		end
		local thunderingSlamTimeLeft = self:BarTimeLeft(369703) -- Thundering Slam
		if thunderingSlamTimeLeft >= .2 then
			self:CDBar(369703, {thunderingSlamTimeLeft + 9.8, 28})
		else
			self:CDBar(369703, {10, 28})
		end
	end
end
