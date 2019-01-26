local L = BigWigs:NewBossLocale("Aqu'sirr", "esES") or BigWigs:NewBossLocale("Aqu'sirr", "esMX")
if not L then return end
if L then
	-- L.warmup_trigger = "How dare you sully this holy place with your presence!"
end

L = BigWigs:NewBossLocale("Lord Stormsong", "esES") or BigWigs:NewBossLocale("Lord Stormsong", "esMX")
if L then
	-- L.warmup_trigger_horde = "Intruders?! I shall cast your bodies to the blackened depths, to be crushed for eternity!"
	-- L.warmup_trigger_alliance = "Master! Stop this madness at once! The Kul Tiran fleet must not fall to darkness!"
end

L = BigWigs:NewBossLocale("Shrine of the Storm Trash", "esES") or BigWigs:NewBossLocale("Shrine of the Storm Trash", "esMX")
if L then
	L.templar = "Templario del santuario"
	L.spiritualist = "Espiritualista Sabiomar"
	L.galecaller_apprentice = "Aprendiz Clamavendavales"
	L.windspeaker = "Hablavientos Heldis"
	L.ironhull_apprentice = "Aprendiz Cascoférreo"
	L.runecarver = "Grabador de runas Sorn"
	L.guardian_elemental = "Elemental guardián"
	L.ritualist = "Ritualista de fondo marino"
	L.cultist = "Cultor abisal"
	L.depthbringer = "Liberabismos ahogado"
	L.living_current = "Corriente viva"
	L.enforcer = "Déspota Sabiomar"
end
