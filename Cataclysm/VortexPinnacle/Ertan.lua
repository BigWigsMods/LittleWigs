--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Grand Vizier Ertan", 657, 114)
if not mod then return end
mod:RegisterEnableMob(43878)
mod:SetEncounterID(1043)
mod:SetRespawnTime(30)

--------------------------------------------------------------------------------
-- Initialization
--

--[[ XXX uncomment this block when 10.1 is live everywhere
-- this commented block is to make gen_option_values work
function mod:GetOptions()
	return {
		86292, -- Cyclone Shield
		-2422, -- Summon Tempest
		411001, -- Lethal Current
	}, {
		[86292] = self.displayName, -- Grand Vizier Ertan
		[411001] = -2423, -- Lurking Tempest
	}
end
--]]
-- XXX delete this entire if block below when 10.1 is live everywhere
if select(4, GetBuildInfo()) >= 100100 then
	-- 10.1 and up
	function mod:GetOptions()
		return {
			86292, -- Cyclone Shield
			-2422, -- Summon Tempest
			411001, -- Lethal Current
		}, {
			[86292] = self.displayName, -- Grand Vizier Ertan
			[411001] = -2423, -- Lurking Tempest
		}
	end
else
	-- before 10.1
	function mod:GetOptions()
		return {
			86292, -- Cyclone Shield
			-2422, -- Summon Tempest
		}, {
			[86292] = self.displayName, -- Grand Vizier Ertan
		}
	end
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE") -- Cyclone Shield
	self:Log("SPELL_AURA_APPLIED", "CycloneShieldApplied", 86292)
	self:Log("SPELL_CAST_START", "SummonTempest", 86340)
	self:Log("SPELL_CAST_START", "LethalCurrent", 411001)
end

function mod:OnEngage()
	if not self:Normal() then
		self:CDBar(-2422, 5.7, nil, 86340) -- Summon Tempest
	end
	self:CDBar(86292, 22.9) -- Cyclone Shield
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, _, source)
	-- %s retracts her cyclone shield!#Grand Vizier Ertan#####0#0##0#28#nil#0#false#false#false#false
	if source == self.displayName then
		self:Message(86292, "orange")
		self:PlaySound(86292, "long")
		self:CDBar(86292, 30.3)
	end
end

do
	local prev = 0
	function mod:CycloneShieldApplied(args)
		if self:Me(args.destGUID) then
			local t = args.time
			if t - prev > 2 then
				prev = t
				self:PersonalMessage(args.spellId, "near")
				self:PlaySound(args.spellId, "underyou")
			end
		elseif self:Player(args.destFlags) and self:Dispeller("movement") then
			self:TargetMessage(args.spellId, "yellow", args.destName)
			self:PlaySound(args.spellId, "alert", nil, args.destName)
		end
	end
end

function mod:SummonTempest(args)
	self:Message(-2422, "yellow", nil, args.spellId)
	self:PlaySound(-2422, "info")
	self:CDBar(-2422, 17.0, nil, args.spellId)
end

-- Lurking Tempest

do
	local prev = 0
	function mod:LethalCurrent(args)
		if self:MobId(args.sourceGUID) == 204337 then -- Lurking Tempest (boss version)
			local t = args.time
			if t - prev > 1.5 then
				prev = t
				self:Message(args.spellId, "red", CL.casting:format(args.spellName))
				self:PlaySound(args.spellId, "alarm")
			end
		end
	end
end
