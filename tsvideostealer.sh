VIDURL=$1
VIDNAME=$2
VIDSLICENBR=99999

set -e

function usage {
	echo "Usage: $0 [VideoURL] [VideoName]"
	exit 1
}

[ -z $VIDURL ] && usage
[ -z $VIDNAME ] && VIDNAME=chardi

if [[ $VIDURL == *"#"* ]]; then
	for i in $(seq 0 $VIDSLICENBR); do
		echo -n "Downloading video...#$i"$'\r'
		wget -q $(echo $VIDURL | sed s/#/$i/)
		cat $(basename $(echo $VIDURL | sed s/#/$i/)) >> $VIDNAME.ts
		rm $(basename $(echo $VIDURL | sed s/#/$i/))
	done
else
	wget -c $VIDURL -O $VIDNAME.ts
fi

