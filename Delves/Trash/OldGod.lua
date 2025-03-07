--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Old God Delve Trash", {2815}) -- Excavation Site 9
if not mod then return end
mod:RegisterEnableMob(
	234269, -- Craggle Fritzbrains (Excavation Site 9 gossip NPC)
	234553, -- Dark Walker
	234208, -- Hideous Amalgamation
	234209, -- Coagulated Mass
	234210 -- Silent Slitherer
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.old_god_trash = "Old God Trash"

	L.dark_walker = "Dark Walker"
	L.hideous_amalgamation = "Hideous Amalgamation"
	L.coagulated_mass = "Coagulated Mass"
	L.silent_slitherer = "Silent Slitherer"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:OnRegister()
	self.displayName = L.old_god_trash
end

local autotalk = mod:AddAutoTalkOption(false)
function mod:GetOptions()
	return {
		autotalk,
		-- Dark Walker
		474325, -- Abyssal Grasp
		474482, -- Lure of the Void
		474511, -- Shadow Smash
		-- Hideous Amalgamation
		474206, -- Shadow Stomp
		474223, -- Concussive Smash
		-- Coagulated Mass
		474155, -- Slime Trail
		-- Silent Slitherer
		474228, -- Shadow Blast
	}, {
		[474325] = L.dark_walker,
		[474206] = L.hideous_amalgamation,
		[474155] = L.coagulated_mass,
		[474228] = L.silent_slitherer,
	}
end

function mod:OnBossEnable()
	-- Autotalk
	self:RegisterEvent("GOSSIP_SHOW")

	-- Dark Walker
	self:Log("SPELL_CAST_START", "AbyssalGrasp", 474325)
	self:Log("SPELL_CAST_START", "LureOfTheVoid", 474482)
	self:Log("SPELL_CAST_START", "ShadowSmash", 474511)

	-- Hideous Amalgamation
	self:Log("SPELL_CAST_START", "ShadowStomp", 474206)
	self:Log("SPELL_CAST_START", "ConcussiveSmash", 474223)

	-- Coagulated Mass
	self:Log("SPELL_PERIODIC_DAMAGE", "SlimeTrailDamage", 474155)
	self:Log("SPELL_PERIODIC_MISSED", "SlimeTrailDamage", 474155)

	-- Silent Slitherer
	self:Log("SPELL_CAST_START", "ShadowBlast", 474228)

	-- also enable the Rares module
	local raresModule = BigWigs:GetBossModule("Underpin Rares", true)
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
		if self:GetGossipID(131159) then -- Excavation Site 9, start Delve (Craggle Fritzbrains)
			-- 131159:|cFF0000FF(Delve)|r I'll deploy those drilling units. Let's make lots of money!
			self:SelectGossipID(131159)
		elseif self:GetGossipID(131162) then -- Excavation Site 9, continue Delve (Craggle Fritzbrains)
			-- 131162:|cFF0000FF(Delve)|r Maybe we should leave before you give in to the whispers of this place.
			self:SelectGossipID(131162)
		end
	end
end

-- Dark Walker

function mod:AbyssalGrasp(args)
	self:Message(args.spellId, "cyan")
	self:PlaySound(args.spellId, "long")
end

function mod:LureOfTheVoid(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
end

function mod:ShadowSmash(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
end

-- Hideous Amalgamation

function mod:ShadowStomp(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alarm")
end

function mod:ConcussiveSmash(args)
	self:Message(args.spellId, "purple")
	self:PlaySound(args.spellId, "alert")
end

-- Coagulated Mass

do
	local prev = 0
	function mod:SlimeTrailDamage(args)
		if self:Me(args.destGUID) and args.time - prev > 1.5 then
			prev = args.time
			self:PersonalMessage(args.spellId, "underyou")
			self:PlaySound(args.spellId, "underyou")
		end
	end
end

-- Silent Slitherer

function mod:ShadowBlast(args)
	self:Message(args.spellId, "red", CL.casting:format(args.spellName))
	self:PlaySound(args.spellId, "alert")
end
