
# 256 byte string
str1="\
0123456789ABCDEF\
0123456789ABCDEF\
0123456789ABCDEF\
0123456789ABCDEF\
0123456789ABCDEF\
0123456789ABCDEF\
0123456789ABCDEF\
0123456789ABCDEF\
0123456789ABCDEF\
0123456789ABCDEF\
0123456789ABCDEF\
0123456789ABCDEF\
0123456789ABCDEF\
0123456789ABCDEF\
0123456789ABCDEF\
0123456789ABCDEF\
"

# 1K byte string
str_1k=$str1$str1$str1$str1

TMP_FILE=/tmp/.tmp.file

create_big()
{
    max=$1;
    i=0;
    while [ "$i" -lt $max ]
    do
        echo -n $str_1k;
        i=`expr $i + 1`;
    done
}

#create_big 1000 >$TMP_FILE
#str_1m="`cat $TMP_FILE`"

echo "### TEST 1K"
echo $str_1k |wc; echo $str_1k |xargs echo >/dev/null

#echo "### TEST 1M"
#echo $str_1m |wc; echo $str_1m |xargs echo >/dev/null

base=120

create_big $base >$TMP_FILE
str_test="`cat $TMP_FILE`"

echo "### TEST 120 - 130 K"
ksize=$base;
while [ "$ksize" -lt 130 ]
do
        echo "size: $ksize K"
        echo $str_test |wc
        echo $str_test |xargs echo >/dev/null

        str_tmp="$str_test$str_1k";
        str_test="$str_tmp";

    ksize=`expr $ksize + 1`;
done

