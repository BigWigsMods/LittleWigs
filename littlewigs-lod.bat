@echo off

cd ..
rmdir /s /q LittleWigs_BloodFurnace
rmdir /s /q LittleWigs_ManaTombs
rmdir /s /q LittleWigs_Mechanar
rmdir /s /q LittleWigs_SethekkHalls
rmdir /s /q LittleWigs_ShadowLab
rmdir /s /q LittleWigs_ShatteredHalls

cd LittleWigs

move BloodFurnace ..\LittleWigs_BloodFurnace
move ManaTombs ..\LittleWigs_ManaTombs
move Mechanar ..\LittleWigs_Mechanar
move SethekkHalls ..\LittleWigs_SethekkHalls
move ShadowLab ..\LittleWigs_ShadowLab
move ShatteredHalls ..\LittleWigs_ShatteredHalls

cd ..
rmdir /s /q LittleWigs
