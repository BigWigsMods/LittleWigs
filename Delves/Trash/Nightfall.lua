--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Nightfall Delve Trash", {2685, 2686}) -- Skittering Breach, Nightfall Sanctum
if not mod then return end
mod:RegisterEnableMob(
	217572, -- Great Kyron (Nightfall Sanctum gossip NPC)
	217151, -- Dark Bombardier
	217517, -- Nightfall Hopestealer
	217518, -- Nightfall Inquisitor
	217519, -- Nightfall Shadeguard
	217870, -- Devouring Shade
	217268, -- Weeping Shade
	217541, -- Nightfall Initiate
	217485, -- Nightfall Lookout
	220572, -- Shadow Elemental
	220573 -- Shadow Elemental
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.nightfall_trash = "Nightfall Trash"

	L.dark_bombardier = "Dark Bombardier"
	L.nightfall_inquisitor = "Nightfall Inquisitor"
	L.devouring_shade = "Devouring Shade"
	L.weeping_shade = "Weeping Shade"
	L.nightfall_shadeguard = "Nightfall Shadeguard"
	L.shadow_elemental = "Shadow Elemental"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.nightfall_trash
end

local autotalk = mod:AddAutoTalkOption(true)
function mod:GetOptions()
	return {
		autotalk,
		-- Dark Bombardier
		441129, -- Spotted!
		-- Nightfall Inquisitor
		434740, -- Shadow Barrier
		-- Devouring Shade
		443292, -- Umbral Slam
		-- Weeping Shade
		434281, -- Echo of Renilash
		-- Nightfall Shadeguard
		443482, -- Blessing of Dusk
		-- Shadow Elemental
		440205, -- Inflict Death
	}, {
		[441129] = L.dark_bombardier,
		[434740] = L.nightfall_inquisitor,
		[443292] = L.devouring_shade,
		[434281] = L.weeping_shade,
		[443482] = L.nightfall_shadeguard,
		[440205] = L.shadow_elemental,
	}
end

function mod:OnBossEnable()
	-- Autotalk
	self:RegisterEvent("GOSSIP_SHOW")

	-- Dark Bombardier
	self:Log("SPELL_AURA_APPLIED", "Spotted", 441129)

	-- Nightfall Inquisitor
	self:Log("SPELL_CAST_START", "ShadowBarrier", 434740)

	-- Devouring Shade
	self:Log("SPELL_CAST_START", "UmbralSlam", 443292)

	-- Weeping Shade
	self:Log("SPELL_CAST_START", "EchoOfRenilash", 434281)

	-- Nightfall Shadeguard
	self:Log("SPELL_CAST_START", "BlessingOfDusk", 443482)

	-- Shadow Elemental
	self:Log("SPELL_CAST_START", "InflictDeath", 440205)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Autotalk

function mod:GOSSIP_SHOW()
	local info = self:GetWidgetInfo("delve", 6183)
	local level = info and tonumber(info.tierText)
	if (not level or level > 3) and self:GetOption(autotalk) then
		if self:GetGossipID(120767) then -- Nightfall Sanctum, start Delve (Great Kyron)
			-- 120767:|cFF0000FF(Delve)|r I'll hop on a ballista to recover the oil in order to destroy the cult's barrier.
			self:SelectGossipID(120767)
		end
	end
end

-- Dark Bombardier

function mod:Spotted(args)
	self:TargetMessage(args.spellId, "cyan", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
end

-- Nightfall Inquisitor

function mod:ShadowBarrier(args)
	self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "info")
end

-- Devouring Shade

function mod:UmbralSlam(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Weeping Shade

function mod:EchoOfRenilash(args)
	-- also cast by a boss (Reformed Fury)
	if self:MobId(args.sourceGUID) ~= 218034 then -- Reformed Fury
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "alarm")
	end
end

-- Nightfall Shadeguard

function mod:BlessingOfDusk(args)
	-- also cast by a boss (Speaker Davenruth)
	if self:MobId(args.sourceGUID) == 217519 then -- Nightfall Shadeguard
		self:Message(args.spellId, "red", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
	end
end

-- Shadow Elemental

function mod:InflictDeath(args)
	-- also cast by a boss (Reformed Fury)
	if self:MobId(args.sourceGUID) ~= 218034 then -- Reformed Fury
		self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
		self:PlaySound(args.spellId, "alert")
	end
end
