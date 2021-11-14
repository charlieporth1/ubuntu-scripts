#!/bin/bash
function trim() {
  local s2 s="$*"
  until s2="${s#[[:space:]]}"; [ "$s2" = "$s" ]; do s="$s2"; done
  until s2="${s%[[:space:]]}"; [ "$s2" = "$s" ]; do s="$s2"; done
  echo "$s"
}

function trim1() {
        awk '{$1=$1;print}'
}
export -f trim1
export -f trim

min_line_count=4

LIST="$1"

echo $LIST
TMP_F=$LIST.tmp

cp -rf $LIST $LIST.bk
cp -rf $LIST $LIST.bk.unsorted

parallel -P4 -j1 --lb -m --trim rl --lb --no-run-if-empty "printf '%s\n' {}" :::: $LIST | sed -e 's/^\([^.]*\.[^.]*\)$/.\1/' | sort -t . -k2 | sed -e 's/^\.//' | sort | uniq | sort -u | awk '{$1=$1;print}' > $TMP_F

perl -i -ne 'print if ! $x{$_}++' $TMP_F
new_linify $TMP_F > $TMP_F.tmp

if [[ -f  $TMP_F.tmp ]] && [[ `wc -l $TMP_F.tmp | awk '{print $1}'` -ge $min_line_count ]]; then
	mv $TMP_F.tmp $TMP_F
fi

if [[ -f $TMP_F ]] && [[ `wc -l $TMP_F | awk '{print $1}'` -ge $min_line_count ]]; then
	mv $TMP_F $LIST
	cat $LIST
fi
echo sorted
