--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Commander Malor", 329, 749)
if not mod then return end
mod:RegisterEnableMob(11032) -- Commander Malor
mod:SetEncounterID(476)
--mod:SetRespawnTime(0) resets, doesn't respawn

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		12734, -- Ground Smash
		16172, -- Head Crack
		17228, -- Shadow Bolt Volley
	}
end

function mod:OnBossEnable()
	if self:Retail() then -- no start event on Classic
		self:Log("SPELL_CAST_START", "GroundSmash", 12734)
	end
	self:Log("SPELL_CAST_SUCCESS", "GroundSmashSuccess", 12734)
	if self:Retail() then -- no start event on Classic
		self:Log("SPELL_CAST_START", "HeadCrack", 16172)
	end
	self:Log("SPELL_CAST_SUCCESS", "HeadCrackSuccess", 16172)
	if self:Retail() then
		self:Log("SPELL_CAST_START", "ShadowBoltVolley", 17228)
	else -- Classic
		self:Log("SPELL_CAST_START", "HolyLight", 15493)
	end
	if self:Heroic() then -- no encounter events in Timewalking
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
		self:Death("Win", 11032)
	end
end

function mod:OnEngage()
	self:CDBar(12734, 4.9) -- Ground Smash
	self:CDBar(17228, 7.3) -- Shadow Bolt Volley
	self:CDBar(16172, 18.2) -- Head Crack
end

--------------------------------------------------------------------------------
-- Classic Initialization
--

if mod:Classic() then
	function mod:GetOptions()
		return {
			12734, -- Ground Smash
			16172, -- Head Crack
			15493, -- Holy Light
		}
	end

	function mod:OnEngage()
		self:CDBar(12734, 6.2) -- Ground Smash
		self:CDBar(16172, 10.1) -- Head Crack
		-- Holy Light cast is probably health based
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = 0
	function mod:GroundSmash(args)
		-- throttle the alert, cast can cancel to cast again
		if args.time - prev > 2 then
			prev = args.time
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
	end
end

function mod:GroundSmashSuccess(args)
	self:CDBar(args.spellId, 8.0) -- 10s - 2s cast time
	if not self:Retail() then
		self:Message(args.spellId, "orange")
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:HeadCrack(args) -- Retail only
	if self:MobId(args.sourceGUID) == 11032 then -- Commander Malor
		self:Message(args.spellId, "purple")
		self:PlaySound(args.spellId, "alert")
	end
end

function mod:HeadCrackSuccess(args)
	if self:MobId(args.sourceGUID) == 11032 then -- Commander Malor
		self:CDBar(args.spellId, 12.5) -- 14s - 1.5s cast time
		if not self:Retail() then
			self:Message(args.spellId, "purple")
			self:PlaySound(args.spellId, "alert")
		end
	end
end

function mod:ShadowBoltVolley(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 18.2)
	self:PlaySound(args.spellId, "alert")
end

--------------------------------------------------------------------------------
-- Classic Event Handlers
--

function mod:HolyLight(args)
	if self:MobId(args.sourceGUID) == 11032 then -- Malor the Zealous
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
	end
end
