
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Hymdall", 1041, 1485)
if not mod then return end
mod:RegisterEnableMob(94960)
mod.engageId = 1805

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{193235, "ICON", "SAY"}, -- Dancing Blade
		191284, -- Horn of Valor
		193092, -- Bloodletting Sweep
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "DancingBlade", 193235)
	self:Log("SPELL_CAST_SUCCESS", "DancingBladeEnd", 193235)
	self:Log("SPELL_CAST_START", "HornOfValor", 191284)

	self:Log("SPELL_PERIODIC_DAMAGE", "DancingBladeDamage", 193234)
	self:Log("SPELL_PERIODIC_MISSED", "DancingBladeDamage", 193234)

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
end

function mod:OnEngage()

end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local function printTarget(self, player, guid)
		if self:Me(guid) then
			self:Say(193235)
		end
		self:PrimaryIcon(193235, player)
		self:TargetMessage(193235, player, "Urgent", "Alert", nil, nil, true)
	end
	function mod:DancingBlade(args)
		self:GetBossTarget(printTarget, 1, args.sourceGUID)
		--self:CDBar(args.spellId, 10) -- pull:6.2, 31.5, 10.5
	end
	function mod:DancingBladeEnd(args)
		self:PrimaryIcon(args.spellId)
	end
end

function mod:HornOfValor(args)
	self:Message(193235, "Important", "Long", CL.casting:format(args.spellName))
	--self:CDBar(args.spellId, 42) -- pull:11.0, 42.0
end

do
	local prev = 0
	function mod:DancingBladeDamage(args)
		local t = GetTime()
		if self:Me(args.destGUID) and t-prev > 2 then
			prev = t
			self:Message(193235, "Personal", "Alarm", CL.you:format(args.spellName))
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellId)
	if spellId == 193092 then -- Bloodletting Sweep
		self:Message(spellId, "Attention", self:Tank() and "Info")
		self:CDBar(spellId, 17.7) -- 17.7 - 18.1
	end
end

