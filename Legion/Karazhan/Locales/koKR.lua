local L = BigWigs:NewBossLocale("Karazhan Trash", "koKR")
if not L then return end
if L then
	-- Opera Event
	L.custom_on_autotalk = "자동 대화"
	L.custom_on_autotalk_desc = "오페라 극장 우두머리 전투를 시작하는 반즈의 대화 선택지를 즉시 고릅니다."
	L.opera_hall_wikket_story_text = "오페라 극장: 우끼드"
	--L.opera_hall_wikket_story_trigger = "Shut your jabber" -- Shut your jabber, drama man! The Monkey King got another plan!
	L.opera_hall_westfall_story_text = "오페라 극장: 서부 몰락지대 이야기"
	--L.opera_hall_westfall_story_trigger = "we meet two lovers" -- Tonight... we meet two lovers born on opposite sides of Sentinel Hill.
	L.opera_hall_beautiful_beast_story_text = "오페라 극장: 미녀와 짐승"
	--L.opera_hall_beautiful_beast_story_trigger = "a tale of romance and rage" -- Tonight... a tale of romance and rage, one which will prove once and for all if beaty is more than skin deep.

	-- Return to Karazhan: Lower
	L.barnes = "반즈"
	L.ghostly_philanthropist = "유령 자선가"
	L.skeletal_usher = "해골 안내인"
	L.spectral_attendant = "수행원 유령"
	L.spectral_valet = "유령 종업원"
	L.spectral_retainer = "유령 당원"
	L.phantom_guardsman = "유령 경비병"
	L.wholesome_hostess = "건전한 시녀"
	L.reformed_maiden = "교화된 무희"
	L.spectral_charger = "유령 준마"

	-- Return to Karazhan: Upper
	L.chess_event = "체스 이벤트"
	L.king = "킹"
end

L = BigWigs:NewBossLocale("Moroes", "koKR")
if L then
	L.cc = "군중 제어"
	--L.cc_desc = "Timers and alerts for crowd control on the dinner guests."
end

L = BigWigs:NewBossLocale("Nightbane", "koKR")
if L then
	L.name = "파멸의 어둠"
end
