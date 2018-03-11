--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Warp Splinter", 729, 562)
if not mod then return end
mod:RegisterEnableMob(17977)
mod.engageId = 1929
-- mod.respawnTime = 0 -- resets, doesn't respawn

--------------------------------------------------------------------------------
-- Locals
--

local addsAlive = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		34716, -- Stomp
		-5478, -- Summon Saplings
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "Stomp", 34716)

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Death("AddDeath", 19949)
end

function mod:OnEngage()
	addsAlive = 0
	self:CDBar(-5478, 15) -- Summon Saplings
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local playerList = mod:NewTargetList()
	function mod:Stomp(args)
		playerList[#playerList+1] = args.destName
		if #playerList == 1 then
			self:ScheduleTimer("TargetMessage", 0.3, args.spellId, playerList, "Urgent", "Alert", nil, nil, self:Healer())
		end
	end
end

do
	local barText = CL.onboss:format(mod:SpellName(32130)) -- "Heal on BOSS", the boss gets healed if these don't die within 25 seconds
	function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellId)
		if spellId == 34741 then -- Summon Saplings
			addsAlive = 6 -- when they despawn to heal him, they don't fire any event; fortunately, no 2 waves can be alive at the same time
			self:Message(-5478, "Important", "Alarm")
			self:Bar(-5478, 25, barText, 38658) -- 38658 = "Healing Touch", because it fits the theme
			self:CDBar(-5478, 45)
		end
	end

	function mod:AddDeath()
		addsAlive = addsAlive - 1
		self:Message(-5478, "Positive", "Info", CL.add_remaining:format(addsAlive))
		if addsAlive == 0 then
			self:StopBar(barText)
		end
	end
end
