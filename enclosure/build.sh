#!/usr/bin/env bash
# Export STLs and preview PNGs, then check the STLs are manifold.
# Usage: ./build.sh [extra openscad args, e.g. -D 'lid_fastening="screw"']
set -euo pipefail
cd "$(dirname "$0")"
SCAD=house-pressure-enclosure.scad
mkdir -p stl png

for p in base lid coupon; do
  echo "== $p"
  openscad --backend=manifold -q -D "part=\"$p\"" "$@" -o "stl/$p.stl" "$SCAD"
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
png coupon          45,0,200  -D 'part="coupon"'
png back            180,0,0   -D 'part="base"'

python3 check_manifold.py stl/*.stl
