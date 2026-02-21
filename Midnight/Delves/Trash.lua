--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Midnight Delve Trash", {2933, 2952, 2953, 2961, 2962, 2963, 2964, 2965, 2979, 3003}) -- All Midnight Delves (except Torment's Rise)
if not mod then return end
mod.displayName = CL.trash
mod:SetPrivateAuraSounds({
	{1256045, sound = "underyou"}, -- Null Zone
})

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.nullaeus = "Nullaeus"
end

--------------------------------------------------------------------------------
-- Initialization
--

local autotalk = mod:AddAutoTalkOption(false)
function mod:GetOptions()
	return {
		autotalk,
		-- Nullaeus
		{1256045, "PRIVATE"}, -- Null Zone
	}, {
		[1256045] = L.nullaeus,
	}
end

function mod:OnBossEnable()
	-- Autotalk
	self:RegisterEvent("GOSSIP_SHOW")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Autotalk

function mod:GOSSIP_SHOW()
	if self:GetOption(autotalk) then
		if self:GetGossipID(135708) then -- Collegiate Calamity, start Delve (Bloomkeeper Thornflare)
			-- 135708:|cFF0000FF(Delve)|r I'll get rid of these weeds!
			self:SelectGossipID(135708)
		elseif self:GetGossipID(137619) then -- The Shadow Enclave, start Delve (Doleana Silverstalk)
			-- 137619:Looting and killing, understood!
			self:SelectGossipID(137619)
		end
	end
end
