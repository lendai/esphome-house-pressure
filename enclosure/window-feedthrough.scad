// Flat window feedthrough for the outdoor pressure tube.
//
// A thin L-shaped blade with an air channel inside. It goes through the gap between
// the window sash and the frame and bends around the L-shaped ledge. The gasket presses on
// the flat blade instead of pinching the soft tube. Each end has a hub with a hose barb:
// the room side goes to the "- UTE" port, the outside end gets a short tube pointing down.
//
// Print it lying on its side as exported: the L lies on the bed, the barbs point up.
// The channel walls are then 2 perimeters, and the channel roof is a short bridge.
// Print in PETG, 100 % infill, and check that it is airtight before you use it.
//
// Lines tagged "MEASURE" depend on your window or tube.

/* [Output] */
part = "feedthrough";       // [feedthrough, preview]
$fn = 40;

/* [Window gap] */
gap = 3.0;                  // MEASURE gap thickness with the window closed (squeeze Blu-Tack, measure it)
leg_in = 85.0;              // MEASURE room-side leg: from the room-side edge of the gap to the ledge corner
leg_out = 30.0;             // MEASURE outside leg: from the ledge corner to the outside edge of the gap
mirror_l = false;           // turn the L the other way (keeps the barbs on the same side)

/* [Blade] */
fit = 0.3;                  // blade is this much thinner than the gap, so the window still latches
width = 8.0;                // blade width along the window edge
skin = 0.8;                 // channel wall (2 perimeters / 4 layers at 0.2 mm)

/* [Tube and barbs] */
// Same barb profile as the SDP810 ports, so any tube that fits the sensor fits here too
barb_d = 5.2;               // MEASURE barb diameter (SDP810: 5.2)
barb_tip = 3.5;             // MEASURE barb tip diameter (SDP810: 3.5)
bore_d = 1.8;               // air hole through the barbs
hub = 7.0;                  // hub size; the hubs sit outside the gap
barb_l = 3.0;               // length of each barb ring
barb_rings = 2;

// ---------------------------------------------------------------- derived
t = gap - fit;              // blade thickness
ch_h = t - 2 * skin;        // channel height (across the blade)
ch_w = width - 2 * skin;    // channel width (along the window edge)
sy = mirror_l ? -1 : 1;
path = [[0, 0], [leg_in, 0], [leg_in, sy * leg_out]];
// hub centres, one hub/2 beyond each end of the blade
hub_a = [-hub / 2, 0];
hub_b = [leg_in, sy * (leg_out + hub / 2)];
channel = concat([hub_a], path, [hub_b]);

echo(str("Blade ", t, " mm thick, channel ", ch_h, " x ", ch_w, " mm"));
assert(ch_h >= 0.6, "gap too small: the channel would be under 0.6 mm (lower skin or fit, or route elsewhere)");
assert(hub >= barb_d + 1.6, "hub too small for the barb");

// Polyline drawn with a round pen of radius r. Inner corners stay sharp.
module stroke(pts, r) {
    for (i = [0 : len(pts) - 2])
        hull() { translate(pts[i]) circle(r); translate(pts[i + 1]) circle(r); }
}

module barb() {
    cylinder(d = barb_tip + 0.5, h = 1.5);
    for (i = [0 : barb_rings - 1])
        translate([0, 0, 1.5 + i * barb_l]) cylinder(d1 = barb_d, d2 = barb_tip, h = barb_l);
}

module feedthrough() {
    difference() {
        union() {
            linear_extrude(width) stroke(path, t / 2);
            for (c = [hub_a, hub_b]) {
                translate([c[0] - hub / 2, c[1] - hub / 2, 0]) cube([hub, hub, width]);
                translate([c[0], c[1], width - 0.01]) barb();
            }
        }
        translate([0, 0, skin]) linear_extrude(ch_w) stroke(channel, ch_h / 2);
        for (c = [hub_a, hub_b])
            translate([c[0], c[1], skin + ch_w / 2]) cylinder(d = bore_d, h = width + barb_rings * barb_l + 3);
    }
}

// Ghost frame ledge (inside the L) and sash (outside the L), for the preview only.
// The room is at x < 0, outdoors is past the end of the outside leg.
module window_ghost() {
    d = 15;
    mirror([0, mirror_l ? 1 : 0, 0]) {
        color("tan", 0.35) translate([0, t / 2, -4]) cube([leg_in - t / 2, leg_out - t / 2, width + 8]);
        color("white", 0.35) {
            translate([0, -t / 2 - d, -4]) cube([leg_in + t / 2 + d, d, width + 8]);
            translate([leg_in + t / 2, -t / 2, -4]) cube([d, leg_out + t / 2, width + 8]);
        }
    }
}

feedthrough();
if (part == "preview") window_ghost();
