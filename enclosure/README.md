# Enclosure

A two-part 3D-printable box for the SDP810 + ESP32-C3-Zero sensor. There is no breadboard: the base is
the carrier and both boards mount directly to it. The box is 65.5 × 50 × 31 mm and hangs on the wall from
two keyhole slots. The SDP810 ports and the USB-C cable come out of the bottom.

![Assembly](png/assembly.png)

| File | What |
|---|---|
| [`house-pressure-enclosure.scad`](house-pressure-enclosure.scad) | Parametric model. All dimensions are named parameters at the top. Physical part dimensions are tagged `MEASURE`. |
| `stl/base.stl` | Base / carrier, oriented for printing (back plate down) |
| `stl/lid.stl` | Lid, oriented for printing (outer face down) |
| `stl/coupon.stl` | Test-fit coupon: C3 cradle, USB-C cutout, SDP810 wall with port holes, bosses and labels |
| `png/*.png` | Preview renders |
| [`build.sh`](build.sh) | Re-exports all STLs and PNGs and runs the manifold check |
| [`check_manifold.py`](check_manifold.py) | Checks that every edge is shared by exactly two consistently oriented triangles |

```bash
./build.sh                                  # snap-fit lid (default)
```

```bash
./build.sh -D 'lid_fastening="screw"'       # M3 screw lid instead
```

You can also open the `.scad` file in OpenSCAD and use the Customizer. Set `part` to `base`, `lid`,
`coupon` or `assembly`.

## Layout

Seen from the front, with the box on the wall:

- **SDP810**, bottom left. It is screwed to two bosses on the inside of the bottom wall, and its ports go
  down through the wall. "High" is on the left and is marked **+ INNE**. "Low" is marked **− UTE**.
  The labels are raised on the underside, above each port. There is 15 mm of free space behind the pins
  for the 2.0 mm header and its wires. Two holes in the top wall line up with the screws, so a long
  screwdriver can reach them.
- **ESP32-C3-Zero-M**, bottom right. It sits upside down: components face the wall and the header pins point
  at the lid. The USB-C edge is against the bottom wall cutout, which is sized for a normal 13 × 7.5 mm plug
  body. The PCB rests on two 0.5 mm edge ledges. Two hooks on the bottom wall hold the ends of the header
  spacers at the USB end. One thin snap holds the antenna end. There is no plastic under the antenna.
- **Wire clip** between the two boards.
- **Vents** in the left wall (the "+" side), the right wall and the top wall. The "+" barb is open to room air.
- **Keyholes**, 36 mm apart, in the back plate.

## Print settings

| Setting | Value |
|---|---|
| Material | PLA or PETG |
| Nozzle / layer | 0.4 mm / 0.2 mm |
| Perimeters | 3 (the bosses, snaps and hooks are thin, so they should be solid perimeters) |
| Infill | 20 % |
| Supports | **None**. Horizontal holes are teardrops, the bosses have a 45° underside, and the keyhole pockets are short bridges. |
| Orientation | As exported: base on its back plate, lid on its outer face, coupon on its back plate |

PETG holds threads better but shrinks less. For PETG, set `sdp_pilot_d = 2.2` and `m3_pilot_d = 2.6`.

## Hardware

| Qty | Part |
|---|---|
| 2 | M2.5 × 14 screws, self-tapping into the plastic (SDP810). This assumes the ear holes run through the full 10.25 mm body. If your ears are thinner, use screws that are 3–4 mm longer than the ear. |
| 4 | M3 × 8 screws (only with `lid_fastening = "screw"`) |
| 2 | Wall screws: head ≤ 8 mm, shank ≤ 4 mm, e.g. 3.5 × 30 mm with a plug. Leave the heads about 2.5 mm proud of the wall. |
| 1 | 4-pin 2.0 mm female header with wires (SDP810 side) |
| 4 | Female Dupont connectors (C3 side) |
| 2 | 4.7 kΩ resistors (I²C pull-ups, see below) |

## Assembly order

1. **Print the coupon first** and test both boards in it (see "If it doesn't fit").
2. **Make the harness.** Solder the four wires to the 2.0 mm header. Without a breadboard, put the two
   4.7 kΩ pull-ups at the header end: one from SDA to VDD and one from SCL to VDD. Cover them with heat-shrink.
   Crimp Dupont housings on the other end.
3. **Mount the SDP810.** Push the barbs out through the bottom wall from the inside, with "High" on the left.
   Put the M2.5 screws through the ears and drive them through the access holes in the top wall.
   Tighten until snug. Don't overtighten, or you'll strip the plastic.
4. **Push the 2.0 mm header** onto the SDP810 pins.
5. **Insert the C3-Zero** upside down. Tilt it, slide the USB end against the bottom wall so the ends of the
   header spacers go under the two hooks, then press the antenna end down until the snap clicks.
6. **Plug in the Duponts.** Use the pin row facing the SDP810. Pin 1 (5V) is the one nearest the USB-C
   connector. Counting from there:
   pin 2 = **GND**, pin 3 = **3V3**, pin 8 = **GPIO4 (SDA)**, pin 9 = **GPIO5 (SCL)**.
   See the wiring table in the [main README](../README.md#wiring).
7. **Route the wires** through the clip, plug in USB and check that the sensor reports values.
8. **Close the lid.** For the snap lid, press until both long sides click. To open it, lever it up
   at the notch in the right wall.
9. **Hang the box.** Put two screws in the wall 36 mm apart and level. Push the heads through the big holes,
   then slide the box down.
10. **Fit the tube.** Push the outdoor tube onto the **− UTE** barb. Leave **+ INNE** open.

## If it doesn't fit

Change the parameter, then run `./build.sh` again. Print the coupon again before you print the full box.

| Symptom | Parameter(s) |
|---|---|
| C3 PCB too tight or too loose between the rails | `c3_w`, `c3_l`, `clr` |
| C3 won't go under the USB-end hooks, or rattles under them | `c3_hdr_h` (measure the header spacer), `c3_t` |
| Antenna-end snap won't click, or the board lifts | `snap_hook` (0.5–1.0), `snap_t` (thinner = softer) |
| Ledge hits the solder stubs on the component side | `c3_ledge` (smaller) |
| USB-C plug doesn't reach the receptacle | `usb_plug_w`, `usb_plug_h` (measure your cable), `c3_usb_overhang`, `c3_usb_dx` |
| USB-C plug body hits the wall behind the box | `usb_center_z` (higher) |
| SDP810 barbs don't line up with the holes | `sdp_port_dx`, `sdp_port_off`, `sdp_hole_dx` |
| Barbs are tight in the wall | `clr` or `sdp_barb_d` |
| Port flange touches the wall | `sdp_boss_h` (higher; must be at least `sdp_flange_z` + 0.4) |
| "High" / "Low" labels are on the wrong ports | `sdp_high_left = false` |
| M2.5 screws strip or crack the bosses | `sdp_pilot_d` (2.1 for PLA, 2.2 for PETG) |
| Dupont wires press against the lid | `dupont_h`, `wire_bend` |
| Lid snap too hard or too soft | `snap_bump` (0.6–1.0), `snap_len` |
| Keyhole doesn't take your wall screw | `key_head_d`, `key_shank_d`, `key_head_h` |

## Assumed dimensions (check with calipers)

The SDP810 dimensions come from Figures 2 and 3 of the Sensirion SDP8xx-Digital datasheet (v1.1). The
C3-Zero dimensions come from Waveshare's drawing. These values were **not** in either drawing, so the model
uses typical values:

- `c3_t` = 1.0 mm PCB thickness
- `c3_hdr_h` = 2.5 mm header spacer height, and `c3_pin_len` = 6 mm
- `c3_usb_h` = 3.2 mm, `c3_usb_overhang` = 0 (the receptacle ends flush with the PCB edge)
- The SDP810 body is centred on the ear-hole line, and the ear holes run through the full body height.
- "High" is on the left when you look at the port face with the ear-hole line above the ports.
  The datasheet's port-side view shows it this way. Check the marking on your sensor.
