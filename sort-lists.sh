#!/bin/bash
function trim() {
  local s2 s="$*"
  until s2="${s#[[:space:]]}"; [ "$s2" = "$s" ]; do s="$s2"; done
  until s2="${s%[[:space:]]}"; [ "$s2" = "$s" ]; do s="$s2"; done
  echo "$s"
}
export -f trim
LIST="$1"
echo $LIST
TMP_F=$LIST.tmp
cp -rf $LIST $LIST.bk
cp -rf $LIST $LIST.bk.unsorted
parallel -j1 --lb -m --trim rl --lb --no-run-if-empty "printf '%s\n' {}" :::: $LIST | sed -e 's/^\([^.]*\.[^.]*\)$/.\1/' | sort -t . -k2 | sed -e 's/^\.//' | sort | uniq | sort -u > $TMP_F
perl -i -ne 'print if ! $x{$_}++' $TMP_F
if [[ -n  `cat $TMP_F` ]]; then
	mv $TMP_F $LIST
	cat $LIST
fi
echo sorted
