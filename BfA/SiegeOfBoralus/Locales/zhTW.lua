local L = BigWigs:NewBossLocale("Siege of Boralus Trash", "zhTW")
if not L then return end
if L then
	L.cannoneer = "艾胥凡砲手"
	L.commander = "艾胥凡指揮官"
	L.spotter = "艾胥凡偵察兵"
	L.demolisher = "污鼠會毀滅者"
	L.pillager = "污鼠會掠取者"
	L.tempest = "污鼠會風暴法師"
	L.wavetender = "庫爾提拉斯平浪者"
	L.halberd = "庫爾提拉斯長戟兵"
	L.raider = "鐵潮劫掠者"
	L.vanguard = "庫爾提拉斯先鋒"
	L.marksman = "庫爾提拉斯神射手"
	L.buccaneer = "污鼠會海盜"
	L.invader = "艾胥凡入侵者"
	-- L.dockhound = "Snarling Dockhound"
	-- L.shredder = "Riptide Shredder"
	-- L.packmaster = "Dockhound Packmaster"
	-- L.bomber = "Blackar Bomber"
end

L = BigWigs:NewBossLocale("Sergeant Bainbridge", "zhTW")
if L then
	L.remaining = "%2$s中了%1$s，場上還剩%3$d個"
	L.remaining_boss = "王中了%s，場上還剩%d個"
end

L = BigWigs:NewBossLocale("Chopper Redhook", "zhTW")
if L then
	L.remaining = "%2$s中了%1$s，場上還剩%3$d個"
	L.remaining_boss = "王中了%s，場上還剩%d個"
end

L = BigWigs:NewBossLocale("Viq'Goth", "zhTW")
if L then
	L.demolishing_desc = "為滅擊觸鬚的出現顯示警告與計時。"
end
