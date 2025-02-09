--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Dark Rider", 2875)
if not mod then return end
mod:RegisterEnableMob(238055) -- Dark Rider
mod:SetEncounterID(3143)
--mod:SetRespawnTime(30)
mod:SetAllowWin(true)

--------------------------------------------------------------------------------
-- Locals
--

local etherealChargeCount = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.dark_rider = "Dark Rider"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.dark_rider
end

function mod:GetOptions()
	return {
		1219814, -- Grasping Spirits
		1223264, -- Rushing Dark Riders
		1220939, -- Ethereal Charge
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED") -- Grab Torch, Grasping Spirits, Rushing Dark Riders
	self:Log("SPELL_CAST_SUCCESS", "EtherealCharge", 1220939)
end

function mod:OnEngage()
	etherealChargeCount = 1
	self:CDBar(1219814, 1.6) -- Grasping Spirits
	self:CDBar(1223264, 6.5) -- Rushing Dark Riders
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev
	function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, castGUID, spellId)
		if spellId == 1220904 and castGUID ~= prev then -- Grab Torch
			prev = castGUID
			self:StopBar(1219814) -- Grasping Spirits
			self:StopBar(1223264) -- Rushing Dark Riders
			self:Message(1220939, "cyan", CL.soon:format(self:SpellName(1220939))) -- Ethereal Charge
		elseif spellId == 1219814 and castGUID ~= prev then -- Grasping Spirits
			prev = castGUID
			self:Message(spellId, "yellow")
			self:CDBar(spellId, 10.2)
			self:PlaySound(spellId, "info")
		elseif spellId == 1223264 and castGUID ~= prev then -- Rushing Dark Riders
			prev = castGUID
			self:Message(spellId, "red")
			self:CDBar(spellId, 11.3)
			self:PlaySound(spellId, "alarm")
		end
	end
end

do
	local prev = 0
	function mod:EtherealCharge(args)
		-- cast once by each clone (npc:238499)
		if args.time - prev > 5 then
			prev = args.time
			self:StopBar(1219814) -- Grasping Spirits
			self:StopBar(1223264) -- Rushing Dark Riders
			if etherealChargeCount == 1 then
				self:Message(args.spellId, "orange", CL.percent:format(75, args.spellName))
			elseif etherealChargeCount == 2 then
				self:Message(args.spellId, "orange", CL.percent:format(50, args.spellName))
			else -- 3
				self:Message(args.spellId, "orange", CL.percent:format(25, args.spellName))
			end
			etherealChargeCount = etherealChargeCount + 1
			self:PlaySound(args.spellId, "alarm")
		end
	end
end
