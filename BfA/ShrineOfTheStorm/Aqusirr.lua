if not C_ChatInfo then return end -- XXX Don't load outside of 8.0

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Aqu'sirr", 1864, 2153)
if not mod then return end
mod:RegisterEnableMob(134056)
mod.engageId = 2130

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		265001, -- Sea Blast
		264560, -- Choking Brine
		264101, -- Surging Rush
		264166, -- Undertow
		264903, -- Erupting Waters
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "SeaBlast", 265001)
	self:Log("SPELL_CAST_SUCCESS", "ChokingBrine", 264560)
	self:Log("SPELL_AURA_APPLIED", "ChokingBrineApplied", 264560, 264773) -- Initial, Ground Pickup
	self:Log("SPELL_CAST_START", "SurgingRush", 264101)
	self:Log("SPELL_CAST_SUCCESS", "Undertow", 264166, 264144)
	self:Log("SPELL_CAST_START", "EruptingWaters", 264903)
end

function mod:OnEngage()
	self:Bar(264560, 12) -- Choking Brine _success
	self:Bar(264101, 15.5) -- Surging Rush _start
	self:Bar(264166, 32) -- Undertow _success
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = 0
	function mod:SeaBlast(args)
		local t = GetTime()
		if t-prev > 2 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

do
	local prev = 0
	function mod:ChokingBrine(args)
		local t = GetTime()
		if t-prev > 2 then
			prev = t
			self:Message(args.spellId, "yellow")
			--self:Bar(args.spellId, 32) XXX Need more info
		end
	end
end

function mod:ChokingBrineApplied(args)
	if self:Me(args.destGUID) then
		self:TargetMessage2(264560, "yellow", args.destName)
		self:PlaySound(264560, "alarm")
	end
end

do
	local prev = 0
	function mod:SurgingRush(args)
		local t = GetTime()
		if t-prev > 2 then
			prev = t
			self:Message(args.spellId, "yellow")
			self:PlaySound(args.spellId, "alert")
			--self:Bar(args.spellId, 32) XXX Need more info
		end
	end
end

do
	local prev = 0
	function mod:Undertow(args)
		local t = GetTime()
		if t-prev > 2 then
			prev = t
			self:TargetMessage2(264166, "orange", args.destName)
			if self:Me(args.destGUID) then
				self:PlaySound(264166, "warning")
			end
			--self:Bar(264166, 32) XXX Need more info
		end
	end
end

function mod:EruptingWaters(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long", "intermission")
	self:Bar(264560, 13.5) -- Choking Brine _success
	self:Bar(264101, 18.5) -- Surging Rush _start
	self:Bar(264166, 28.5) -- Undertow _success
end
