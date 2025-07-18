-- End Time

local L = BigWigs:NewBossLocale("Echo of Baine", "esES")
if not L then return end
if L then
	L.totemDrop = "Cae Tótem"
	L.totemThrow = "Tótem lanzado por %s"
end

-- Grim Batol

L = BigWigs:NewBossLocale("Erudax", "esES")
if L then
	L.summon = "Invoca Corruptor ignoto"
	L.summon_desc = "Alerta cuando Erudax invoca a un Corruptor ignoto."
	L.summon_message = "Corruptor ignoto invocado"
	L.summon_trigger = "invoca un"
end

L = BigWigs:NewBossLocale("Grim Batol Trash", "esES")
if L then
	L.twilight_earthcaller = "Clamatierras crepuscular"
	L.twilight_brute = "Tosco Crepuscular"
	L.twilight_destroyer = "Draco Crepuscular"
	L.twilight_overseer = "Sobrestante Crepuscular"
	L.twilight_beguiler = "Cautivador Crepuscular"
	L.molten_giant = "Gigante fundido"
	L.twilight_warlock = "Brujo crepuscular"
	L.twilight_flamerender = "Desgarrallamas crepuscular"
	L.twilight_lavabender = "Doblalava crepuscular"
	L.faceless_corruptor = "Corruptor ignoto"
end

-- Hour of Twilight

L = BigWigs:NewBossLocale("The Hour of Twilight Trash", "esES")
if L then
	L.custom_on_autotalk_desc = "Selecciona al instante las opciones de conversación de Thrall."
end

-- Lost City of the Tol'vir

L = BigWigs:NewBossLocale("Siamat", "esES")
if L then
	L.servant = "Invocar Sirviente"
	L.servant_desc = "Avisar cuando invoque un Sirviente de Siamat."
end

-- Shadowfang Keep

L = BigWigs:NewBossLocale("Lord Walden", "esES")
if L then
	-- %s will be either "Coagulante tóxico" or "Catalizador tóxico"
	L.coagulant = "%s: Muévete para disipar"
	L.catalyst = "%s: Crit Buff"
	L.toxin_healer_message = "%s: DoT en todos"
end

-- The Stonecore

L = BigWigs:NewBossLocale("Corborus", "esES")
if L then
	L.burrow = "Esconderse/emerger"
	L.burrow_desc = "Avisar cuando Corborus se esconde o emerge."
	L.burrow_message = "Corborus se esconde"
	L.burrow_warning = "¡Se esconde en 5 seg!"
	L.emerge_message = "¡Corborus emerge!"
	L.emerge_warning = "¡Emerge en 5 seg!"
end

-- Throne of the Tides

L = BigWigs:NewBossLocale("Throne of the Tides Trash", "esES")
if L then
	L.nazjar_oracle = "Oráculo Naz'jar"
	L.vicious_snap_dragon = "Bocadragón sañoso"
	L.nazjar_sentinel = "Centinela Naz'jar"
	L.nazjar_ravager = "Devastador Naz'jar"
	L.nazjar_tempest_witch = "Bruja de la tempestad Naz'jar"
	L.faceless_seer = "Vidente ignoto"
	L.faceless_watcher = "Vigía ignoto"
	L.tainted_sentry = "Avizor corrupto"

	L.ozumat_warmup_trigger = "¡La bestia ha regresado! ¡No debe contaminar mis aguas!"
end

L = BigWigs:NewBossLocale("Lady Naz'jar", "esES")
if L then
	L.high_tide_trigger1 = "¡A lasss armasss, esbirrosss! ¡Alzaos de las heladas profundidadesss!"
	L.high_tide_trigger2 = "¡Dessstruid a los intrusosss! ¡Que losss devore la ossscuridad del másss allá!"
end

-- The Vortex Pinnacle

L = BigWigs:NewBossLocale("The Vortex Pinnacle Trash", "esES")
if L then
	L.armored_mistral = "Mistral acorazado"
	L.gust_soldier = "Soldado de ráfaga"
	L.wild_vortex = "Vórtice salvaje"
	L.lurking_tempest = "Tempestad acechante"
	L.cloud_prince = "Príncipe de las Nubes"
	L.turbulent_squall = "Borrasca turbulenta"
	L.empyrean_assassin = "Asesino empíreo"
	L.young_storm_dragon = "Dragón de tormenta joven"
	L.executor_of_the_caliph = "Ejecutor del califa"
	L.temple_adept = "Adepto del templo"
	L.servant_of_asaad = "Sirviente de Asaad"
	L.minister_of_air = "Ministro del Aire"
end

-- Well of Eternity

L = BigWigs:NewBossLocale("Well Of Eternity Trash", "esES")
if L then
	L.custom_on_autotalk_desc = "Selecciona al instante las opciones de conversación de Illidan."
end

-- Zul'Aman

L = BigWigs:NewBossLocale("Daakara", "esES")
if L then
	L[42594] = "Forma de oso" -- short form for "Esencia del espíritu de oso"
	L[42607] = "Forma de lince"
	L[42606] = "Forma del águila"
	L[42608] = "Forma de dracohalcón"
end

L = BigWigs:NewBossLocale("Halazzi", "esES")
if L then
	L.spirit_message = "Fase de espíritu"
	L.normal_message = "Fase normal"
end

L = BigWigs:NewBossLocale("Nalorakk", "esES")
if L then
	L.troll_message = "Forma de troll"
	L.troll_trigger = "¡Dejad paso al Nalorakk!"
end

-- Zul'Gurub

L = BigWigs:NewBossLocale("Jin'do the Godbreaker", "esES")
if L then
	L.barrier_down_message = "Barrera derribada, %d restantes" -- short name for "Barrera quebradiza" (97417)
end
