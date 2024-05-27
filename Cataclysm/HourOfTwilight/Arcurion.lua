--------------------------------------------------------------------------------
--  Module Declaration
--

local mod, CL = BigWigs:NewBoss("Arcurion", 940, 322)
if not mod then return end
mod:RegisterEnableMob(54590) -- Arcurion
mod:SetEncounterID(1337)
mod:SetRespawnTime(30)
mod:SetStage(1)

--------------------------------------------------------------------------------
--  Initialization
--

local icyTombMarker = mod:AddMarkerOption(true, "npc", 8, 103252, 8) -- Icy Tomb
function mod:GetOptions()
	return {
		102582, -- Chains of Frost
		103252, -- Icy Tomb
		icyTombMarker,
		104050, -- Torrent of Frost
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "ChainsOfFrost", 102582)
	self:Log("SPELL_CAST_SUCCESS", "IcyTomb", 103252)
	self:Log("SPELL_AURA_REMOVED", "IcyTombRemoved", 103251)
	self:Log("SPELL_CAST_START", "TorrentOfFrost", 104050)
end

function mod:OnEngage()
	self:SetStage(1)
	self:CDBar(102582, 12.1) -- Chains of Frost
	self:CDBar(103252, 30.3) -- Icy Tomb
end

--------------------------------------------------------------------------------
--  Event Handlers
--

function mod:ChainsOfFrost(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	self:CDBar(args.spellId, 15.8)
end

function mod:IcyTomb(args)
	self:StopBar(args.spellId)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	-- register events to auto-mark Icy Tomb
	if self:GetOption(icyTombMarker) then
		self:RegisterTargetEvents("MarkIcyTomb")
	end
end

function mod:MarkIcyTomb(_, unit, guid)
	-- there is no SPELL_SUMMON for the crystals the debuff is applied by the boss,
	-- so scan for the correct mob id.
	if self:MobId(guid) == 54995 then -- Icy Tomb
		self:CustomIcon(icyTombMarker, unit, 8)
		self:UnregisterTargetEvents()
	end
end

function mod:IcyTombRemoved(args)
	self:Message(103252, "green", CL.removed:format(args.spellName))
	self:PlaySound(103252, "info")
	if self:GetStage() == 1 then
		-- Icy Tomb being removed starts the timer for the next Icy Tomb
		self:CDBar(103252, 30.5)
	end
end

function mod:TorrentOfFrost(args)
	self:StopBar(102582) -- Chains of Frost
	self:StopBar(103252) -- Icy Tomb
	self:SetStage(2)
	self:Message(args.spellId, "cyan", CL.percent:format(30, args.spellName))
	self:PlaySound(args.spellId, "long")
end
