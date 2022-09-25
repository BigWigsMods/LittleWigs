local L = BigWigs:NewBossLocale("Karazhan Trash", "zhTW")
if not L then return end
if L then
	-- Opera Event
	L.custom_on_autotalk = "自動對話"
	--L.custom_on_autotalk_desc = "Instantly selects Barnes' gossip option to start the Opera Hall encounter."
	L.opera_hall_wikket_story_text = "歌劇大廳：綠野巫蹤"
	--L.opera_hall_wikket_story_trigger = "Shut your jabber" -- Shut your jabber, drama man! The Monkey King got another plan!
	L.opera_hall_westfall_story_text = "歌劇大廳：西荒故事"
	--L.opera_hall_westfall_story_trigger = "we meet two lovers" -- Tonight... we meet two lovers born on opposite sides of Sentinel Hill.
	L.opera_hall_beautiful_beast_story_text = "歌劇大廳：美女與猛獸"
	--L.opera_hall_beautiful_beast_story_trigger = "a tale of romance and rage" -- Tonight... a tale of romance and rage, one which will prove once and for all if beaty is more than skin deep.

	-- Return to Karazhan: Lower
	--L.barnes = "Barnes"
	--L.ghostly_philanthropist = "Ghostly Philanthropist"
	--L.skeletal_usher = "Skeletal Usher"
	--L.spectral_attendant = "Spectral Attendant"
	--L.spectral_valet = "Spectral Valet"
	--L.spectral_retainer = "Spectral Retainer"
	--L.phantom_guardsman = "Phantom Guardsman"
	--L.wholesome_hostess = "Wholesome Hostess"
	--L.reformed_maiden = "Reformed Maiden"
	--L.spectral_charger = "Spectral Charger"

	-- Return to Karazhan: Upper
	L.chess_event = "西洋棋事件"
	--L.king = "King"
end

L = BigWigs:NewBossLocale("Moroes", "zhTW")
if L then
	--L.cc = "Crowd Control"
	--L.cc_desc = "Timers and alerts for crowd control on the dinner guests."
end

local L = BigWigs:NewBossLocale("Nightbane", "zhTW")
if L then
	--L.name = "Nightbane"
end
