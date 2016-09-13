
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Wrath of Azshara", 1046, 1492)
if not mod then return end
mod:RegisterEnableMob(96028)
mod.engageId = 1814

--------------------------------------------------------------------------------
-- Locals
--

local p2 = false

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		192706, -- Arcane Bomb
		192617, -- Massive Deluge
		192675, -- Mystic Tornado
		192985, -- Cry of Wrath
		{197365, "SAY", "ICON"}, -- Crushing Depths
	}, {
		[197365] = "heroic",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")

	self:Log("SPELL_CAST_START", "MassiveDeluge", 192617)
	self:Log("SPELL_CAST_SUCCESS", "CryOfWrath", 192985)
	self:Log("SPELL_CAST_START", "CrushingDepths", 197365) -- Heroic+
	self:Log("SPELL_CAST_SUCCESS", "CrushingDepthsEnd", 197365)

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
end

function mod:OnEngage()
	p2 = false
	self:CDBar(192706, self:Normal() and 23 or 26) -- Arcane Bomb
	self:CDBar(192617, 12) -- Massive Deluge
	self:CDBar(197365, 20) -- Crushing Depths
	self:CDBar(192675, 8) -- Mystic Tornado
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg, _, _, _, unit) -- Arcane Bomb
	if msg:find("192708", nil, true) then -- Fires with _START, target scanning doesn't work.
		self:TargetMessage(192706, unit, "Important", "Alarm")
		self:CDBar(192706, p2 and 23 or 30) -- pull:23.1, 30.4, 23.1 / hc pull:26.7, 31.2, 23.1
	end
end

function mod:MassiveDeluge(args)
	self:Message(args.spellId, "Attention", self:Tank() and "Warning")
	self:CDBar(args.spellId, self:Normal() and 51 or 56) -- pull:12.1, 51.0 / hc pull:12.1, 55.9
end

function mod:CryOfWrath(args)
	p2 = true
	self:Message(args.spellId, "Positive", "Long", "10% - ".. args.spellName)
end

do
	local function printTarget(self, player, guid)
		if self:Me(guid) then
			self:Say(197365)
		end
		self:SecondaryIcon(197365, player)
		self:TargetMessage(197365, player, "Important", "Alarm", nil, nil, true)
	end
	function mod:CrushingDepths(args) -- Heroic+
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(args.spellId, 41) -- pull:20.8, 41.3
	end
	function mod:CrushingDepthsEnd(args)
		self:SecondaryIcon(args.spellId)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellId)
	if spellId == 192680 then -- Mystic Tornado
		self:RangeMessage(192675, "Urgent", "Alert")
		self:CDBar(192675, p2 and 15 or 25)
	end
end

