#/bin/bash

cd ..
rm -rf BigWigs_BloodFurnace
rm -rf BigWigs_ManaTombs
rm -rf BigWigs_Mechanar
rm -rf BigWigs_SethekkHalls
rm -rf BigWigs_ShadowLab
rm -rf BigWigs_ShatteredHalls

cd BigWigs_BC5mans

mv BloodFurnace ../BigWigs_BloodFurnace
mv ManaTombs ../BigWigs_ManaTombs
mv Mechanar ../BigWigs_Mechanar
mv SethekkHalls ../BigWigs_SethekkHalls
mv ShadowLab ../BigWigs_ShadowLab
mv ShatteredHalls ../BigWigs_ShatteredHalls

cd ..
rm -Rf BigWigs_BC5manss
