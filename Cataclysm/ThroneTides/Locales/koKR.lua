local L = BigWigs:NewBossLocale("Throne of the Tides Trash", "koKR")
if not L then return end
if L then
	L.nazjar_oracle = "나즈자르 예언자"
	L.vicious_snap_dragon = "흉포한 치악룡"
	L.nazjar_sentinel = "나즈자르 파수꾼"
	L.nazjar_ravager = "나즈자르 괴멸자"
	L.nazjar_tempest_witch = "나즈자르 폭풍우 마녀"
	L.faceless_seer = "얼굴 없는 선견자"
	L.faceless_watcher = "얼굴 없는 감시자"
	L.tainted_sentry = "타락한 파수병"

	--L.ozumat_warmup_trigger = "The beast has returned! It must not pollute my waters!"
end

L = BigWigs:NewBossLocale("Lady Naz'jar", "koKR")
if L then
	--L.high_tide_trigger1 = "Take arms, minions! Rise from the icy depths!"
	--L.high_tide_trigger2 = "Destroy these intruders! Leave them for the great dark beyond!"
end

L = BigWigs:NewBossLocale("Ozumat", "koKR")
if L then
	L.custom_on_autotalk = "자동 대화"
	L.custom_on_autotalk_desc = "전투를 시작하는 대화 선택지를 즉시 선택합니다."
end
