assmonkey=`echo hello world | awk '{gsub("\ ", "\\ "); print}'`

echo $assmonkey;

for monkey in `echo hello world | awk '{gsub("\ ", "\\ "); print}' `
do
	echo "$monkey";
done;
