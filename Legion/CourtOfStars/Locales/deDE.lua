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
	L["Jemand erwähnte, dass der Spion vorhin hier hereinkam und einen Umhang trug."] = 1
	L["Mir ist zu Ohren gekommen, dass der Spion gerne Umhänge trägt."] = 1

	-- Kein Umhang
	L["Ich hörte, dass der Spion seinen Umhang im Palast gelassen hat, bevor er hierhergekommen ist."] = 2
	L["Ich hörte, dass der Spion keine Umhänge mag und sich weigert, einen zu tragen."] = 2

	-- Geldbeutel
	L["Ich hörte, dass der Gürtelbeutel des Spions mit ausgefallenem Garn gesäumt wurde."] = 3
	L["Ein Freund behauptet, dass der Spion Gold liebt und einen Gürtelbeutel voll davon hat."] = 3
	L["Mir ist zu Ohren gekommen, dass der Gürtelbeutel des Spions mit Gold gefüllt ist, um besonders extravagant zu erscheinen."] = 3
	L["Ich hörte, dass der Spion immer einen magischen Beutel mit sich herumträgt."] = 3

	-- Fläschchen
	L["Ich bin mir ziemlich sicher, dass der Spion Tränke am Gürtel trägt."] = 4
	L["Ich hörte, dass der Spion Tränke mitgebracht hat... Ich frage mich wieso?"] = 4
	L["Wie ich hörte, hat der Spion einige Tränke mitgebracht... für alle Fälle."] = 4
	L["Von mir habt Ihr das nicht... aber der Spion verkleidet sich als Alchemist und trägt Tränke an seinem Gürtel."] = 4

	-- Lange Ärmel
	L["Wie ich hörte, trägt der Spion heute Abend Kleidung mit langen Ärmeln."] = 5
	L["Einer meiner Freunde erwähnte, dass der Spion lange Ärmel trägt."] = 5
	L["Jemand sagte, dass der Spion heute Abend seine Arme mit langen Ärmeln bedeckt."] = 5
	L["Ich habe am frühen Abend einen kurzen Blick auf die langen Ärmel des Spions erhascht."] = 5

	-- Kurze Ärmel
	L["Jemand sagte mir, dass der Spion lange Ärmel hasst."] = 6
	L["Mir ist zu Ohren gekommen, dass der Spion kurze Ärmel trägt, damit er seine Arme ungehindert bewegen kann."] = 6
	L["Man hat mir zugetragen, dass der Spion die kühle Luft mag und deshalb heute Abend keine langen Ärmel trägt."] = 6
	L["Eine meiner Freundinnen sagte, dass sie die Kleidung des Spions gesehen hat. Er trägt keine langen Ärmel."] = 6

	-- Handschuhe
	L["Einem Gerücht zufolge trägt der Spion immer Handschuhe."] = 7
	L["Wie ich hörte, verbirgt der Spion sorgfältig die Hände."] = 7
	L["Jemand behauptete, dass der Spion Handschuhe trägt, um sichtbare Narben zu verbergen."] = 7
	L["Ich hörte, dass der Spion immer Handschuhe anlegt."] = 7

	-- Keine Handschuhe
	L["Wisst Ihr... Ich habe ein zusätzliches Paar Handschuhe im Hinterzimmer gefunden. Wahrscheinlich ist der Spion hier irgendwo mit bloßen Händen unterwegs."] = 8
	L["Es gibt Gerüchte, dass der Spion niemals Handschuhe trägt."] = 8
	L["Ich hörte, dass der Spion es vermeidet, Handschuhe zu tragen, falls er schnell handeln muss."] = 8
	L["Mir ist zu Ohren gekommen, dass der Spion ungern Handschuhe trägt."] = 8

	-- Männlich
	L["Irgendwo habe ich gehört, dass der Spion nicht weiblich ist."] = 9
	L["Ich hörte, dass der Spion ein äußerst gutaussehender Herr ist."] = 9
	L["Ein Gast sagte, sie sah, wie ein Herr an der Seite der Großmagistrix das Anwesen betreten hat."] = 9
	L["Einer der Musiker sagte, er stellte unablässig Fragen über den Bezirk."] = 9

	-- Weiblich
	L["Jemand hat behauptet, dass unser neuester Gast nicht männlich ist."] = 10
	L["Ein Gast hat beobachtet, wie sie und Elisande vorhin gemeinsam eingetroffen sind."] = 10
	L["Man sagt, die Spionin wäre hier und sie wäre eine wahre Augenweide."] = 10
	L["Wie ich höre, hat eine Frau sich ständig nach diesem Bezirk erkundigt..."] = 10

	-- Helle Weste
	L["Der Spion bevorzugt auf jeden Fall Westen mit hellen Farben."] = 11
	L["Wie ich hörte, trägt der Spion auf der Party heute Abend eine helle Weste."] = 11
	L["Die Leute sagen, dass der Spion heute Abend keine dunkle Weste trägt."] = 11

	-- Dunkle Weste
	L["Der Spion bevorzugt auf alle Fälle dunkle Kleidung."] = 12
	L["Ich hörte, dass die Weste des Spions heute Abend von dunkler, kräftiger Farbe ist."] = 12
	L["Dem Spion gefallen Westen mit dunklen Farben... dunkel wie die Nacht."] = 12
	L["Gerüchten zufolge vermeidet der Spion es, helle Kleidung zu tragen, damit er nicht so auffällt."] = 12

	-- Kein Fläschchen
	L["Eine Musikerin erzählte mir, dass sie gesehen hat, wie der Spion seinen letzten Trank wegwarf und jetzt keinen mehr übrig hat."] = 13
	L["Wie ich hörte, hat der Spion keine Tränke bei sich."] = 13

	-- Buch
	L["Gerüchten zufolge liest der Spion gerne und trägt immer mindestens ein Buch bei sich."] = 14
	L["Ich hörte, dass der Spion immer ein Buch mit niedergeschriebenen Geheimnissen am Gürtel trägt."] = 14
end

L = BigWigs:NewBossLocale("Advisor Melandrus", "deDE")
if L then
	L.warmup_trigger = "Eine weitere Fehlleistung, Melandrus. Aber Ihr könnt es wiedergutmachen. Vernichtet die Eindringlinge. Ich muss zurück zur Nachtfestung."
end
