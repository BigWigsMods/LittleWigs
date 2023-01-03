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
	L.Imacutya = "Imacu'tya"
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
end

L = BigWigs:NewBossLocale("Advisor Melandrus", "deDE")
if L then
	L.warmup_trigger = "Eine weitere Fehlleistung, Melandrus. Aber Ihr könnt es wiedergutmachen. Vernichtet die Eindringlinge. Ich muss zurück zur Nachtfestung."
end
