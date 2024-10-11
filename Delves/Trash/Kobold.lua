--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Kobold Delve Trash", {2681, 2683}) -- Kriegval's Rest, The Waterworks
if not mod then return end
mod:RegisterEnableMob(
	213447, -- Kuvkel (Kriegval's Rest gossip NPC)
	213775, -- Dagran Thaurissan II (Kriegval's Rest gossip NPC)
	214143, -- Foreman Bruknar (The Waterworks gossip NPC)
	214290, -- Pagsly (The Waterworks gossip NPC)
	204127, -- Kobold Taskfinder
	225568, -- Kobold Guardian
	213577, -- Spitfire Charger
	211777 -- Spitfire Fusetender
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.kobold_trash = "Kobold Trash"

	L.kobold_taskfinder = "Kobold Taskfinder"
	L.spitfire_charger = "Spitfire Charger"
	L.spitfire_fusetender = "Spitfire Fusetender"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.kobold_trash
	self:SetSpellRename(449071, CL.frontal_cone) -- Blazing Wick (Frontal Cone)
	self:SetSpellRename(445210, CL.charge) -- Fire Charge (Charge)
end

local autotalk = mod:AddAutoTalkOption(false)
function mod:GetOptions()
	return {
		autotalk,
		-- Kobold Taskfinder / Kobold Guardian
		449071, -- Blazing Wick
		448399, -- Battle Cry
		-- Spitfire Charger
		445210, -- Fire Charge
		445191, -- Wicklighter Volley
		-- Spitfire Fusetender
		448528, -- Throw Dynamite
	},{
		[449071] = L.kobold_taskfinder,
		[445210] = L.spitfire_charger,
		[448528] = L.spitfire_fusetender,
	},{
		[449071] = CL.frontal_cone, -- Blazing Wick (Frontal Cone)
		[445210] = CL.charge, -- Fire Charge (Charge)
	}
end

function mod:OnBossEnable()
	-- Autotalk
	self:RegisterEvent("GOSSIP_SHOW")

	-- Kobold Taskfinder / Kobold Guardian
	self:Log("SPELL_CAST_START", "BlazingWick", 449071)
	self:Log("SPELL_CAST_START", "BattleCry", 448399)
	self:Log("SPELL_AURA_APPLIED", "BattleCryApplied", 448399)

	-- Spitfire Charger
	self:Log("SPELL_CAST_START", "FireCharge", 445210)
	self:Log("SPELL_CAST_START", "WicklighterVolley", 445191)
	self:Log("SPELL_AURA_APPLIED", "WicklighterVolleyApplied", 445191)

	-- Spitfire Fusetender
	self:Log("SPELL_CAST_SUCCESS", "ThrowDynamite", 448528)

	-- also enable the Rares module
	local raresModule = BigWigs:GetBossModule("Delve Rares", true)
	if raresModule then
		raresModule:Enable()
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Autotalk

function mod:GOSSIP_SHOW()
	if self:GetOption(autotalk) then
		if self:GetGossipID(119802) then -- Kriegval's Rest, start Delve (Kuvkel)
			-- 119802:I'll get your valuables back from the kobolds.
			self:SelectGossipID(119802)
		elseif self:GetGossipID(119930) then -- Kriegval's Rest, start Delve (Dagran Thaurissan II)
			-- 119930:|cFF0000FF(Delve)|r <Interrupt Dagran> Let's get going Dagran. We'll collect some wax.
			self:SelectGossipID(119930)
		elseif self:GetGossipID(120018) then -- The Waterworks, start Delve (Foreman Bruknar)
			-- 120018:|cFF0000FF(Delve)|r I'll rescue the rest of your workers from the kobolds.
			self:SelectGossipID(120018)
		elseif self:GetGossipID(120096) then -- The Waterworks, continue Delve (Foreman Bruknar)
			-- 120096:|cFF0000FF(Delve)|r I'll take the stomping shoes and use them to get your stolen goods back.
			self:SelectGossipID(120096)
		elseif self:GetGossipID(120081) then -- The Waterworks, start Delve (Pagsly)
			-- 120081:|cFF0000FF(Delve)|r I'll help you recover the earthen treasures.
			self:SelectGossipID(120081)
		elseif self:GetGossipID(120082) then -- The Waterworks, continue Delve (Pagsly)
			-- 120082:|cFF0000FF(Delve)|r I'll fend off any kobolds while you get the treasures.
			self:SelectGossipID(120082)
		end
	end
end

-- Kobold Taskfinder

function mod:BlazingWick(args)
	self:Message(args.spellId, "orange", CL.frontal_cone)
	self:PlaySound(args.spellId, "alarm")
end

function mod:BattleCry(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:BattleCryApplied(args)
	if self:Dispeller("enrage", true) and args.sourceGUID == args.destGUID then -- Throttle to the caster
		self:Message(args.spellId, "yellow", CL.other:format(args.spellName, args.destName))
		self:PlaySound(args.spellId, "info")
	end
end

-- Spitfire Charger

function mod:FireCharge(args)
	self:Message(args.spellId, "orange", CL.charge)
	self:PlaySound(args.spellId, "alarm")
end

function mod:WicklighterVolley(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end

function mod:WicklighterVolleyApplied(args)
	if self:Me(args.destGUID) then
		self:PersonalMessage(args.spellId)
		self:PlaySound(args.spellId, "info")
	end
end

-- Spitfire Fusetender

function mod:ThrowDynamite(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end
