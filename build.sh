mkdir data
mkdir data/lang

wget https://github.com/nxengine/tsc-converter/releases/download/v1.0/tsc.tar.gz
tar -zxf tsc.tar.gz

wget https://github.com/nxengine/nx-fontgen/releases/download/v1.2/fontbm.tar.gz
tar -zxf fontbm.tar.gz


git clone https://github.com/nxengine/lang_russian
git clone https://github.com/nxengine/lang_japanese
git clone https://github.com/B4rabbas/lang_french
git clone https://github.com/nxengine/lang_polish
git clone https://github.com/nxengine/lang_german
git clone https://github.com/nxengine/lang_italian
git clone https://github.com/nxengine/lang_chinese


for i in lang*
do

    echo "Processing $i"
    lang=`echo $i | sed 's/lang_//'`
    mkdir "data/lang/$lang"
    cp -r $i/* "data/lang/$lang"
    for n in data/lang/$lang/*.txt
    do
        ./tsc $n `echo $n | sed 's/txt/tsc/'`
        rm $n
    done
    for n in data/lang/$lang/Stage/*.txt
    do
        ./tsc $n `echo $n | sed 's/txt/tsc/'`
        rm $n
    done
    str=`cat $i/metadata`
    arr=(${str// / })
    for key in {1..5}
    do
      ./fontbm -F ${arr[0]} --texture-width=1024 --texture-height=1024 -O data/lang/$lang/font_${key} -S ${arr[$key]} --chars ${arr[6]}
    done

    zip -r $lang.zip data/lang/$lang/
done

zip -r all.zip data/
