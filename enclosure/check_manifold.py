#!/usr/bin/env python3
"""Check that STL files are closed, consistently oriented 2-manifolds.

Usage: check_manifold.py file.stl [...]
Exit code 1 if any file fails. No dependencies beyond the standard library.
"""
import struct
import sys
from collections import Counter


def read_stl(path):
    data = open(path, "rb").read()
    if data[:5] == b"solid" and b"facet" in data[:400]:
        tris, cur = [], []
        for line in data.decode().splitlines():
            parts = line.split()
            if parts and parts[0] == "vertex":
                cur.append(tuple(float(v) for v in parts[1:4]))
                if len(cur) == 3:
                    tris.append(cur)
                    cur = []
        return tris
    n = struct.unpack_from("<I", data, 80)[0]
    tris = []
    for i in range(n):
        v = struct.unpack_from("<12f", data, 84 + 50 * i)
        tris.append([v[3:6], v[6:9], v[9:12]])
    return tris


def check(path):
    tris = read_stl(path)
    index = {}

    def vid(p):
        return index.setdefault(tuple(round(c, 5) for c in p), len(index))

    faces = [tuple(vid(p) for p in t) for t in tris]
    degenerate = sum(1 for f in faces if len(set(f)) < 3)
    directed = Counter()
    for a, b, c in faces:
        for e in ((a, b), (b, c), (c, a)):
            directed[e] += 1
    undirected = Counter()
    for (a, b), n in directed.items():
        undirected[(min(a, b), max(a, b))] += n
    bad_count = sum(1 for n in undirected.values() if n != 2)
    bad_orient = sum(1 for n in directed.values() if n != 1)

    vol = 0.0
    for t in tris:
        (x1, y1, z1), (x2, y2, z2), (x3, y3, z3) = t
        vol += (x1 * (y2 * z3 - y3 * z2) - x2 * (y1 * z3 - y3 * z1) + x3 * (y1 * z2 - y2 * z1)) / 6
    xs, ys, zs = zip(*[p for t in tris for p in t])
    V, E, F = len(index), len(undirected), len(faces)
    ok = degenerate == 0 and bad_count == 0 and bad_orient == 0 and vol > 0
    print(f"{'OK  ' if ok else 'FAIL'} {path}: {F} triangles, "
          f"bbox {max(xs)-min(xs):.1f} x {max(ys)-min(ys):.1f} x {max(zs)-min(zs):.1f} mm, "
          f"volume {vol/1000:.1f} cm3, Euler {V-E+F} "
          f"(open/non-manifold edges {bad_count}, flipped {bad_orient}, degenerate {degenerate})")
    return ok


if __name__ == "__main__":
    results = [check(p) for p in sys.argv[1:]]
    sys.exit(0 if results and all(results) else 1)
