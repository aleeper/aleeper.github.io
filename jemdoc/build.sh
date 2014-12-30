#chmod a+r *.pdf
#chmod a+r */*.pdf

JEMDOC="python jemdoc.py -c site.conf"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
#echo "DIR=$DIR"

pushd `pwd` > /dev/null 2>&1
cd $DIR

for file in *.jemdoc; do
  CURR_COMMAND="$JEMDOC $file"
  echo "$CURR_COMMAND"
  $CURR_COMMAND
done

mv -v *.html ../

popd > /dev/null 2>&1
