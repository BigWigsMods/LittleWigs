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
		if self:GetGossipID(136318) then -- Atal'Aman, start Delve (Fleek)
			-- 136318:|cFF0000FF(Delve)|r I will save them!
			self:SelectGossipID(136318)
		elseif self:GetGossipID(135708) then -- Collegiate Calamity, start Delve (Bloomkeeper Thornflare)
			-- 135708:|cFF0000FF(Delve)|r I'll get rid of these weeds!
			self:SelectGossipID(135708)
		elseif self:GetGossipID(135798) then -- Collegiate Calamity, start Delve (Thalandri Fatesinger)
			-- 135798:|cFF0000FF(Delve)|r I'll stop this invasion!
			self:SelectGossipID(135798)
		elseif self:GetGossipID(136477) then -- Parhelion Plaza, start Delve (Grand Artificer Romuul)
			-- 136477:|cFF0000FF(Delve)|r I will break that shield and eliminate the units inside.
			self:SelectGossipID(136477)
		elseif self:GetGossipID(136275) then -- Sunkiller Sanctum, start Delve (Riftblade Maella)
			-- 136275:|cFF0000FF(Delve)|r I'll deal with this mess!
			self:SelectGossipID(136275)
		elseif self:GetGossipID(138009) then -- The Darkway, start Delve (Technician Mireille)
			-- 138009:I will re-align the conduits and restore the energy.
			self:SelectGossipID(138009)
		elseif self:GetGossipID(137248) then -- The Gulf of Memory, start Delve (Ashayo)
			-- 137248:Release the moths near Lightbloom patches on the ground and they'll eat it. Seems easy enough.
			self:SelectGossipID(137248)
		elseif self:GetGossipID(137619) then -- The Shadow Enclave, start Delve (Doleana Silverstalk)
			-- 137619:Looting and killing, understood!
			self:SelectGossipID(137619)
		elseif self:GetGossipID(135634) then -- Twilight Crypts, start Delve (Twilight Hostage)
			-- 135634:I'll take care of it!
			self:SelectGossipID(135634)
		end
	end
end
