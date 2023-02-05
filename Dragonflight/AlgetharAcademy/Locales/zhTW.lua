local L = BigWigs:NewBossLocale("Algeth'ar Academy Trash", "zhTW")
if not L then return end
if L then
	L.custom_on_recruiter_autotalk = "自動對話"
	L.custom_on_recruiter_autotalk_desc = "與招募員對話時自動確認選項，獲取增益。"
	L.critical_strike = "+5% 致命一擊"
	L.haste = "+5% 加速"
	L.mastery = "+精通"
	L.versatility = "+5% 臨機應變"
	L.healing_taken = "+10% 受到治療"

	--L.vexamus_warmup_trigger = "created a powerful construct named Vexamus"
	--L.overgrown_ancient_warmup_trigger = "Ichistrasz! There is too much life magic"
	--L.crawth_warmup_trigger = "At least we know that works. Watch yourselves."

	L.corrupted_manafiend = "腐敗的法力惡魔"
	--L.spellbound_battleaxe = "Spellbound Battleaxe"
	L.spellbound_scepter = "錮法權杖"
	L.arcane_ravager = "秘法劫毀者"
	L.unruly_textbook = "難懂的教科書"
	L.guardian_sentry = "守護者哨衛"
	L.alpha_eagle = "鷹王"
	L.vile_lasher = "暗邪鞭笞者"
	L.algethar_echoknight = "阿爾蓋薩回音騎士"
	--L.spectral_invoker = "Spectral Invoker"
	L.ethereal_restorer = "以太復原者"
end
