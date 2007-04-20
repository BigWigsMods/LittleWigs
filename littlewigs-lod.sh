#/bin/bash

cd ..
rm -rf LittleWigs_BloodFurnace
rm -rf LittleWigs_ManaTombs
rm -rf LittleWigs_Mechanar
rm -rf LittleWigs_SethekkHalls
rm -rf LittleWigs_ShadowLab
rm -rf LittleWigs_ShatteredHalls

cd LittleWigs

mv BloodFurnace ../LittleWigs_BloodFurnace
mv ManaTombs ../LittleWigs_ManaTombs
mv Mechanar ../LittleWigs_Mechanar
mv SethekkHalls ../LittleWigs_SethekkHalls
mv ShadowLab ../LittleWigs_ShadowLab
mv ShatteredHalls ../LittleWigs_ShatteredHalls

cd ..
rm -Rf LittleWigs
