local L = BigWigs:NewBossLocale("Corborus", "koKR")
if not L then return end
if L then
	L.burrow = "잠복/출현"
	L.burrow_desc = "코보루스가 잠복하거나 지상으로 나타나면 경보합니다."
	L.burrow_message = "코보루스 잠복!"
	L.burrow_warning = "5초 후 잠복!"
	L.emerge_message = "코보루스 출현!"
	L.emerge_warning = "5초 후 출현!"
end
