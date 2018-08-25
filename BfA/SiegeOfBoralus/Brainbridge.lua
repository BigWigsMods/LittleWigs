
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Sergeant Bainbridge", 1822, 2133)
if not mod then return end
mod:RegisterEnableMob(128649) -- Sergeant Bainbridge
mod.engageId = 2097

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		{260954, "FLASH"}, -- Iron Gaze
		261428, -- Hangman's Noose
		260924, -- Steel Tempest
		257585, -- Cannon Barrage
		277965, -- Heavy Ordnance
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")

	self:Log("SPELL_AURA_APPLIED", "IronGaze", 260954)
	self:Log("SPELL_AURA_APPLIED", "HangmansNoose", 261428)
	self:Log("SPELL_CAST_START", "SteelTempest", 260924)
	self:Log("SPELL_AURA_APPLIED", "HeavyOrdnance", 277965)
end

function mod:OnEngage()
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, unit, _, spellId)
	if spellId == 257540 then -- Cannon Barrage
		self:Message(257585, "orange")
		self:PlaySound(257585, "warning")
		self:CDBar(257585, 60) -- XXX Double check
	elseif spellId == 274002 then -- Call Adds
		local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
		if hp < 30.1 then
			self:Message("stages", "yellow", nil, CL.incoming:format(CL.adds), false)
			self:PlaySound("stages", "long")
			self:CDBar("stages", 17, CL.adds, "inv_misc_groupneedmore") -- XXX Double check
		end
	end
end

function mod:IronGaze(args)
	self:TargetMessage2(args.spellId, "yellow", args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "warning")
		self:Flash(args.spellId)
	end
end

function mod:HangmansNoose(args)
	self:TargetMessage2(args.spellId, "red", args.destName)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:SteelTempest(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:HeavyOrdnance(args)
	self:Message(args.spellId, "green", nil, CL.onboss:format(args.spellName)) -- XXX Check if this does not mean it's also on adds
	self:PlaySound(args.spellId, "alert")
	self:TargetBar(args.spellId, 6, args.destName)
end
