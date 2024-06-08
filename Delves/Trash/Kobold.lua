if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Kobold Delve Trash", {2681, 2683}) -- Kriegval's Rest, The Waterworks
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	213447, -- Kuvkel (Kriegval's Rest gossip NPC)
	214143, -- Foreman Bruknar (The Waterworks gossip NPC)
	204127, -- Kobold Taskfinder
	213577, -- Spitfire Charger
	211777 -- Spitfire Fusetender
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.kobold_taskfinder = "Kobold Taskfinder"
	L.spitfire_charger = "Spitfire Charger"
	L.spitfire_fusetender = "Spitfire Fusetender"
end

--------------------------------------------------------------------------------
-- Initialization
--

local autotalk = mod:AddAutoTalkOption(true)
function mod:GetOptions()
	return {
		autotalk,
		-- Kobold Taskfinder
		449071, -- Blazing Wick
		-- Spitfire Charger
		445210, -- Fire Charge
		-- Spitfire Fusetender
		448528, -- Throw Dynamite
	}, {
		[449071] = L.kobold_taskfinder,
		[445210] = L.spitfire_charger,
		[448528] = L.spitfire_fusetender,
	}
end

function mod:OnBossEnable()
	-- Autotalk
	self:RegisterEvent("GOSSIP_SHOW")

	-- Kobold Taskfinder
	self:RegisterEvent("UNIT_SPELLCAST_START") -- Blazing Wick

	-- Spitfire Charger
	self:Log("SPELL_CAST_START", "FireCharge", 445210)

	-- Spitfire Fusetender
	self:Log("SPELL_CAST_SUCCESS", "ThrowDynamite", 448528)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Autotalk

function mod:GOSSIP_SHOW()
	if self:GetOption(autotalk) then
		if self:GetGossipID(119802) then -- Kriegval's Rest, start Delve
			-- 119802:I'll get your valuables back from the kobolds.
			self:SelectGossipID(119802)
		elseif self:GetGossipID(120018) then -- The Waterworks, start Delve
			-- 120018:|cFF0000FF(Delve)|r I'll rescue the rest of your workers from the kobolds.
			self:SelectGossipID(120018)
		end
	end
end

-- Kobold Taskfinder

do
	local prev = nil
	function mod:UNIT_SPELLCAST_START(_, _, castGUID, spellId)
		if spellId == 449071 and castGUID ~= prev then -- Blazing Wick
			prev = castGUID
			self:Message(spellId, "orange")
			self:PlaySound(spellId, "alarm")
		end
	end
end

-- Spitfire Charger

function mod:FireCharge(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
end

-- Spitfire Fusetender

function mod:ThrowDynamite(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end
