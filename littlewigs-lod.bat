@echo off

cd ..
rmdir /s /q BigWigs_BloodFurnace
rmdir /s /q BigWigs_ManaTombs
rmdir /s /q BigWigs_Mechanar
rmdir /s /q BigWigs_SethekkHalls
rmdir /s /q BigWigs_ShadowLab
rmdir /s /q BigWigs_ShatteredHalls

cd BigWigs_BC5Mans

move BloodFurnace ..\BigWigs_BloodFurnace
move ManaTombs ..\BigWigs_ManaTombs
move Mechanar ..\BigWigs_Mechanar
move SethekkHalls ..\BigWigs_SethekkHalls
move ShadowLab ..\BigWigs_ShadowLab
move ShatteredHalls ..\BigWigs_ShatteredHalls

cd ..
rmdir /s /q BigWigs_BC5Mans
