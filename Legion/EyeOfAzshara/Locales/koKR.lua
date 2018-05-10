local L = BigWigs:NewBossLocale("Eye of Azshara Trash", "koKR")
if not L then return end
if L then
	L.wrangler = "증오갈퀴 사냥꾼"
	L.stormweaver = "증오갈퀴 폭풍술사"
	L.crusher = "증오갈퀴 분쇄자"
	L.oracle = "증오갈퀴 점쟁이"
	L.siltwalker = "마크라나 진흙방랑자"
	L.tides = "안식 없는 조류"
	L.arcanist = "증오갈퀴 비전술사"
end

L = BigWigs:NewBossLocale("Lady Hatecoil", "koKR")
if L then
	L.custom_on_show_helper_messages = "정전기 회오리/집중된 번개 도우미"
	L.custom_on_show_helper_messages_desc = "이 옵션을 활성화하면 보스가 |cff71d5ff정전기 회오리|r 나 |cff71d5ff집중된 번개|r 를 시전할때 땅/물 중 어디가 안전한지 알려주는 도우미 메세지를 표시합니다."

	L.water_safe = "%s (물이 안전!)"
	L.land_safe = "%s (땅이 안전!)"
end
