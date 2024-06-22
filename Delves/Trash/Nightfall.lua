if not BigWigsLoader.isBeta then return end
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Nightfall Delve Trash", 2686) -- Nightfall Sanctum
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	217572, -- Great Kyron (Nightfall Sanctum gossip NPC)
	217151, -- Dark Bombardier
	217518, -- Nightfall Inquisitor
	217870, -- Devouring Shade
	217268 -- Weeping Shade
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.dark_bombardier = "Dark Bombardier"
	L.nightfall_inquisitor = "Nightfall Inquisitor"
	L.devouring_shade = "Devouring Shade"
	L.weeping_shade = "Weeping Shade"
end

--------------------------------------------------------------------------------
-- Initialization
--

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
	}, {
		[441129] = L.dark_bombardier,
		[434740] = L.nightfall_inquisitor,
		[443292] = L.devouring_shade,
		[434281] = L.weeping_shade,
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
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Autotalk

function mod:GOSSIP_SHOW()
	if self:GetOption(autotalk) then
		if self:GetGossipID(120767) then -- Nightfall Sanctum, start Delve (Great Kyron)
			-- 120767:|cFF0000FF(Delve)|r I'll hop on a ballista to recover the oil in order to destroy the cult's barrier.
			self:SelectGossipID(120767)
		end
	end
end

-- Dark Bombardier

function mod:Spotted(args)
	self:TargetMessage(args.spellId, "red", args.destName)
	self:PlaySound(args.spellId, "alarm", nil, args.destName)
end

-- Nightfall Inquisitor

function mod:ShadowBarrier(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "info")
end

-- Devouring Shade

function mod:UmbralSlam(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

-- Weeping Shade

function mod:EchoOfRenilash(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
end
