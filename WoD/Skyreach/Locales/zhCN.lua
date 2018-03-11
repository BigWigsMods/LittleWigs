local L = BigWigs:NewBossLocale("High Sage Viryx", "zhCN")
if not L then return end
if L then
	L.custom_on_markadd = "标记拜日狂信徒"
	L.custom_on_markadd_desc = "使用骷髅标记拜日狂信徒，需要权限。"

	L.add = "增援出现"
	L.add_desc = "当通天峰防护构装体出现时发出警报。"
end
