local L = BigWigs:NewBossLocale("Court of Stars Trash", "deDE")
if not L then return end
if L then
	L.Guard = "Wachposten der Dämmerwache"
	L.Construct = "Wächterkonstrukt"
	L.Enforcer = "Dämonenversklavte Vollstreckerin"
	L.Hound = "Legionshund"
	L.Mistress = "Schattenmeisterin"
	L.Gerenth = "Verdächtiger Adliger"
	L.Jazshariu = "Jazshariu"
	L.Imacutya = "Imacutya"
	L.Baalgar = "Baalgar der Wachsame"
	L.Inquisitor = "Wachsamer Inquisitor"
	L.BlazingImp = "Lodernder Wichtel"
	L.Energy = "Gebundene Energie"
	L.Manifestation = "Arkane Manifestation"
	L.Wyrm = "Manawyrm"
	L.Arcanist = "Arkanist der Dämmerwache"
	L.InfernalImp = "Höllenwichtel"
	L.Malrodi = "Arkanistin Malrodi"
	L.Velimar = "Velimar"
	L.ArcaneKeys = "Arkane Schlüssel"
	L.clues = "Hinweise"

	L.InfernalTome = "Höllischer Foliant"
	L.MagicalLantern = "Magische Laterne"
	L.NightshadeRefreshments = "Nachtschattenerfrischungen"
	L.StarlightRoseBrew = "Sternlichtrosenbräu"
	L.UmbralBloom = "Umbralblüte"
	L.WaterloggedScroll = "Durchnässte Schriftrolle"
	L.BazaarGoods = "Basarwaren"
	L.LifesizedNightborneStatue = "Lebensgroße Nachtgeborenenstatue"
	L.DiscardedJunk = "Ausrangierter Schrott"
	L.WoundedNightborneCivilian = "Verwundeter Zivilist der Nachtgeborenen"

	L.announce_buff_items = "Buff-Items bekanntgeben"
	L.announce_buff_items_desc = "Gibt bekannt, welche verfügbaren Buff-Items in der Instanz vorhanden sind und wer sie benutzen kann."

	L.available = "%s|cffffffff%s|r vorhanden" -- Context: item is available to use
	L.usableBy = "benutzbar von %s" -- Context: item is usable by someone

	L.custom_on_use_buff_items = "Buff-Items sofort benutzen"
	L.custom_on_use_buff_items_desc = "Durch die Aktivierung dieser Option werden die Buff-Items beim anklicken sofort benutzt, ausgenommen derjenigen, die eine der drei Botschafter des zweiten Bosses rufen."

	L.spy_helper = "Spion Event Helfer"
	L.spy_helper_desc = "Zeigt eine Infobox mit allen Hinweisen über den Spion an. Diese Hinweise werden ebenfalls im Chat an deine Gruppe geschickt."

	L.clueFound = "Hinweise gefunden (%d/5): |cffffffff%s|r"
	L.spyFound = "Der Spion wurde von %s gefunden!"
	L.spyFoundChat = "Ich habe den Spion gefunden!"
	L.spyFoundPattern = "Na, na, wir wollen doch nicht voreilig sein" -- Na, na, wir wollen doch nicht voreilig sein, [player]. Wieso folgt Ihr mir nicht, damit wir in etwas privaterer Umgebung darüber sprechen können...

	L.hints = {
		"Umhang",
		"Kein Umhang",
		"Geldbeutel",
		"Fläschchen",
		"Lange Ärmel",
		"Kurze Ärmel",
		"Handschuhe",
		"Keine Handschuhe",
		"Männlich",
		"Weiblich",
		"Helle Weste",
		"Dunkle Weste",
		"Kein Fläschchen",
		"Buch",
	}

	--[[ !!! WICHTIGE INFORMATION FÜR ALLE ÜBERSETZER !!! ]]--
	--[[ Die folgenden Übersetzungen müssen exakt mit den Texten der Geschwätzige Plaudertaschen übereinstimmen. ]]--

	-- Umhang
	L.clue_1_1 = "Jemand erwähnte, dass der Spion vorhin hier hereinkam und einen Umhang trug."
	L.clue_1_2 = "Mir ist zu Ohren gekommen, dass der Spion gerne Umhänge trägt."

	-- Kein Umhang
	L.clue_2_1 = "Ich hörte, dass der Spion seinen Umhang im Palast gelassen hat, bevor er hierhergekommen ist."
	L.clue_2_2 = "Ich hörte, dass der Spion keine Umhänge mag und sich weigert, einen zu tragen."

	-- Geldbeutel
	L.clue_3_1 = "Ich hörte, dass der Gürtelbeutel des Spions mit ausgefallenem Garn gesäumt wurde."
	L.clue_3_2 = "Ein Freund behauptet, dass der Spion Gold liebt und einen Gürtelbeutel voll davon hat."
	L.clue_3_3 = "Mir ist zu Ohren gekommen, dass der Gürtelbeutel des Spions mit Gold gefüllt ist, um besonders extravagant zu erscheinen."
	L.clue_3_4 = "Ich hörte, dass der Spion immer einen magischen Beutel mit sich herumträgt."

	-- Fläschchen
	L.clue_4_1 = "Ich bin mir ziemlich sicher, dass der Spion Tränke am Gürtel trägt."
	L.clue_4_2 = "Ich hörte, dass der Spion Tränke mitgebracht hat... Ich frage mich wieso?"
	L.clue_4_3 = "Wie ich hörte, hat der Spion einige Tränke mitgebracht... für alle Fälle."
	L.clue_4_4 = "Von mir habt Ihr das nicht... aber der Spion verkleidet sich als Alchemist und trägt Tränke an seinem Gürtel."

	-- Lange Ärmel
	L.clue_5_1 = "Wie ich hörte, trägt der Spion heute Abend Kleidung mit langen Ärmeln."
	L.clue_5_2 = "Einer meiner Freunde erwähnte, dass der Spion lange Ärmel trägt."
	L.clue_5_3 = "Jemand sagte, dass der Spion heute Abend seine Arme mit langen Ärmeln bedeckt."
	L.clue_5_4 = "Ich habe am frühen Abend einen kurzen Blick auf die langen Ärmel des Spions erhascht."

	-- Kurze Ärmel
	L.clue_6_1 = "Jemand sagte mir, dass der Spion lange Ärmel hasst."
	L.clue_6_2 = "Mir ist zu Ohren gekommen, dass der Spion kurze Ärmel trägt, damit er seine Arme ungehindert bewegen kann."
	L.clue_6_3 = "Man hat mir zugetragen, dass der Spion die kühle Luft mag und deshalb heute Abend keine langen Ärmel trägt."
	L.clue_6_4 = "Eine meiner Freundinnen sagte, dass sie die Kleidung des Spions gesehen hat. Er trägt keine langen Ärmel."

	-- Handschuhe
	L.clue_7_1 = "Einem Gerücht zufolge trägt der Spion immer Handschuhe."
	L.clue_7_2 = "Wie ich hörte, verbirgt der Spion sorgfältig die Hände."
	L.clue_7_3 = "Jemand behauptete, dass der Spion Handschuhe trägt, um sichtbare Narben zu verbergen."
	L.clue_7_4 = "Ich hörte, dass der Spion immer Handschuhe anlegt."

	-- Keine Handschuhe
	L.clue_8_1 = "Wisst Ihr... Ich habe ein zusätzliches Paar Handschuhe im Hinterzimmer gefunden. Wahrscheinlich ist der Spion hier irgendwo mit bloßen Händen unterwegs."
	L.clue_8_2 = "Es gibt Gerüchte, dass der Spion niemals Handschuhe trägt."
	L.clue_8_3 = "Ich hörte, dass der Spion es vermeidet, Handschuhe zu tragen, falls er schnell handeln muss."
	L.clue_8_4 = "Mir ist zu Ohren gekommen, dass der Spion ungern Handschuhe trägt."

	-- Männlich
	L.clue_9_1 = "Irgendwo habe ich gehört, dass der Spion nicht weiblich ist."
	L.clue_9_2 = "Ich hörte, dass der Spion ein äußerst gutaussehender Herr ist."
	L.clue_9_3 = "Ein Gast sagte, sie sah, wie ein Herr an der Seite der Großmagistrix das Anwesen betreten hat."
	L.clue_9_4 = "Einer der Musiker sagte, er stellte unablässig Fragen über den Bezirk."

	-- Weiblich
	L.clue_10_1 = "Jemand hat behauptet, dass unser neuester Gast nicht männlich ist."
	L.clue_10_2 = "Ein Gast hat beobachtet, wie sie und Elisande vorhin gemeinsam eingetroffen sind."
	L.clue_10_3 = "Man sagt, die Spionin wäre hier und sie wäre eine wahre Augenweide."
	L.clue_10_4 = "Wie ich höre, hat eine Frau sich ständig nach diesem Bezirk erkundigt..."

	-- Helle Weste
	L.clue_11_1 = "Der Spion bevorzugt auf jeden Fall Westen mit hellen Farben."
	L.clue_11_2 = "Wie ich hörte, trägt der Spion auf der Party heute Abend eine helle Weste."
	L.clue_11_3 = "Die Leute sagen, dass der Spion heute Abend keine dunkle Weste trägt."

	-- Dunkle Weste
	L.clue_12_1 = "Der Spion bevorzugt auf alle Fälle dunkle Kleidung."
	L.clue_12_2 = "Ich hörte, dass die Weste des Spions heute Abend von dunkler, kräftiger Farbe ist."
	L.clue_12_3 = "Dem Spion gefallen Westen mit dunklen Farben... dunkel wie die Nacht."
	L.clue_12_4 = "Gerüchten zufolge vermeidet der Spion es, helle Kleidung zu tragen, damit er nicht so auffällt."

	-- Kein Fläschchen
	L.clue_13_1 = "Eine Musikerin erzählte mir, dass sie gesehen hat, wie der Spion seinen letzten Trank wegwarf und jetzt keinen mehr übrig hat."
	L.clue_13_2 = "Wie ich hörte, hat der Spion keine Tränke bei sich."

	-- Buch
	L.clue_14_1 = "Gerüchten zufolge liest der Spion gerne und trägt immer mindestens ein Buch bei sich."
	L.clue_14_2 = "Ich hörte, dass der Spion immer ein Buch mit niedergeschriebenen Geheimnissen am Gürtel trägt."
end

L = BigWigs:NewBossLocale("Advisor Melandrus", "deDE")
if L then
	L.warmup_trigger = "Eine weitere Fehlleistung, Melandrus. Aber Ihr könnt es wiedergutmachen. Vernichtet die Eindringlinge. Ich muss zurück zur Nachtfestung."
end
