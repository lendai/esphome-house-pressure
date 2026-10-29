#!/usr/bin/env bash
# Export STLs and preview PNGs, then check the STLs are manifold.
# Usage: ./build.sh [extra openscad args for the enclosure, e.g. -D 'lid_fastening="snap"']
set -euo pipefail
cd "$(dirname "$0")"
SCAD=house-pressure-enclosure.scad
mkdir -p stl png

for p in base lid lid_body lid_text coupon; do
  echo "== $p"
  openscad --backend=manifold -q -D "part=\"$p\"" "$@" -o "stl/${p/_/-}.stl" "$SCAD"
done

png() {  # name camera(rotx,roty,rotz) extra-args...
  local name=$1 cam=$2; shift 2
  openscad -q --imgsize=1400,1050 --viewall --autocenter --colorscheme=Tomorrow \
    --camera="0,0,0,$cam,0" "$@" -o "png/$name.png" "$SCAD"
}
png assembly        50,0,20
png assembly-inside 55,0,25   -D show_lid=false
png assembly-bottom 115,0,-20 -D explode=0
png base            50,0,200  -D show_lid=false -D show_components=false
png lid             35,0,30   -D 'part="lid"'
png lid-text        0,0,0     -D 'part="lid_preview"'
png coupon          45,0,200  -D 'part="coupon"'
png back            180,0,0   -D 'part="base"'

echo "== window-feedthrough"
FT=window-feedthrough.scad
openscad --backend=manifold -q -o stl/window-feedthrough.stl "$FT"
openscad -q --imgsize=1400,1050 --viewall --autocenter --colorscheme=Tomorrow \
  --camera=0,0,0,55,0,25,0 -o png/window-feedthrough.png "$FT"
openscad -q --imgsize=1400,1050 --viewall --autocenter --colorscheme=Tomorrow \
  --camera=0,0,0,40,0,30,0 -D 'part="preview"' -o png/window-feedthrough-in-gap.png "$FT"

python3 check_manifold.py stl/*.stl
