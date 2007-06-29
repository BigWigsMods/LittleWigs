@echo off

cd ..
rmdir /s /q LittleWigs_Auchindoun
rmdir /s /q LittleWigs_Coilfang
rmdir /s /q LittleWigs_HellfireCitadel
rmdir /s /q LittleWigs_TempestKeep
rmdir /s /q LittleWigs_CoT

cd LittleWigs

move Auchindoun ..\LittleWigs_Auchindoun
move Coilfang ..\LittleWigs_Coilfang
move HellfireCitadel ..\LittleWigs_HellfireCitadel
move TempestKeep ..\LittleWigs_TempestKeep
move CoT ..\LittleWigs_CoT

del /q modules.xml

