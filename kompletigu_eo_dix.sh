#!/bin/bash

PREF=/tmp/kompletigu_fr-eo

 lt-expand apertium-eo-fr.fr.dix |grep -v REGEXP | grep -e ':>:' -e '\w:\w' | sed 's/:>:/%/g' | sed 's/:/%/g' | cut -f2 -d'%' | uniq -u | sed 's/^/^/g' | sed 's/$/$^;<sent>$/g' | 
#	head -1000 |
        apertium-pretransfer|
        apertium-transfer-j fr-eo.t1x.class fr-eo.t1x.bin fr-eo.autobil.bin |
#        apertium-transfer apertium-eo-fr.fr-eo.t1x fr-eo.t1x.bin fr-eo.autobil.bin |
        apertium-interchunk apertium-eo-fr.fr-eo.t2x fr-eo.t2x.bin |
	apertium-postchunk apertium-eo-fr.fr-eo.t3x fr-eo.t3x.bin | tee ${PREF}2.txt | 
	grep -v '@' | grep -v '/' | 
        lt-proc -d fr-eo.autogen.bin >  ${PREF}3.txt

#paste -d _  ${PREF}1.txt  ${PREF}2.txt  ${PREF}3.txt | sed 's/\^;<sent>\$//g' | sed 's/ \.//g' | sed 's/_/   ---------> /g' > $0.txt
#grep '@' ${PREF}2.txt | grep -v ' ' | sed 's/\^;<sent>\$//g' | sed 's/ \.//g' > ${PREF}2x.txt
#grep '#' ${PREF}3.txt | grep -v ' ' | sed 's/\^;<sent>\$//g' | sed 's/ \.//g' > ${PREF}3x.txt

grep '@' ${PREF}2.txt | grep -v ' ' | sed 's/\^;<sent>\$//g' | sed 's/@//g;s/\\//g;s/\^//g;s/\$//g' > mankas-eo-fr.txt
grep '#' ${PREF}3.txt | grep -v ' ' | sed 's/#//g;s/;//g;s/\\//g' > mankas-eo.txt

