// House pressure sensor enclosure: Waveshare ESP32-C3-Zero-M + Sensirion SDP810-125Pa
//
// Coordinates (box on the wall, seen from the front):
//   X = left -> right, Y = bottom -> top, Z = back (wall) -> front (lid).
// The base is the carrier. Its back plate lies on the print bed and every part
// mounts to it. The SDP810 ports and the USB-C cable come out of the bottom wall.
// The lid is a flat cover that snaps (or screws) on from the front.
//
// Lines tagged "MEASURE" are physical dimensions of the parts or hardware.
// Check them with calipers before you print the full box (print the coupon first).
// The other parameters are design choices.
//
// Sources: Sensirion SDP8xx-Digital datasheet v1.1, Figures 2 and 3.
//          docs.waveshare.com/ESP32-C3-Zero, dimension drawing.

/* [Output] */
part = "assembly";          // [assembly, base, lid, coupon]
lid_fastening = "screw";    // [screw, snap]
explode = 18;               // assembly view only: lid lift (mm)
show_lid = true;            // assembly view only
show_components = true;     // assembly view only: draw the boards
$fn = 48;

/* [General] */
wall = 2.0;                 // wall, floor and lid thickness
clr = 0.3;                  // fit clearance per side
emboss = 0.6;               // raised height of the port labels
label_size = 2.5;           // port label text height
label_font = "Liberation Sans:style=Bold";

/* [ESP32-C3-Zero-M] */
c3_w = 18.0;                // MEASURE PCB width (pin-row direction)
c3_l = 23.5;                // MEASURE PCB length (USB-C edge to antenna edge)
c3_t = 1.0;                 // MEASURE PCB thickness
c3_pin_inset = 1.38;        // MEASURE PCB long edge to pin-row centre
c3_first_pin = 1.59;        // MEASURE USB-C edge to first pin centre
c3_pin_pitch = 2.54;        // MEASURE
c3_pins = 9;                // pins per side
c3_hdr_h = 2.5;             // MEASURE header plastic spacer height (sits on top when upside down)
c3_hdr_w = 2.54;            // MEASURE header plastic spacer width
c3_pin_len = 6.0;           // MEASURE pin length above the spacer
c3_usb_w = 8.94;            // MEASURE USB-C receptacle width
c3_usb_h = 3.2;             // MEASURE USB-C receptacle height (hangs below the PCB)
c3_usb_l = 7.3;             // MEASURE USB-C receptacle length
c3_usb_overhang = 0.0;      // MEASURE how far the receptacle sticks out past the PCB edge
c3_usb_dx = 0.0;            // MEASURE receptacle offset from PCB centre line (+ = right, seen from the lid)
c3_antenna_zone = 5.0;      // MEASURE antenna end kept free of plastic under the board
c3_ledge = 0.5;             // MEASURE support ledge under each long PCB edge; must stay clear of the header solder stubs
c3_l_play = 2.0;            // extra cradle length at the antenna end, so the board drops in past the snap
c3_w_play = 4.5;            // extra cradle width, split between the two rails
back_window = true;         // open the back plate under the C3 to reach the buttons and see the LED
back_window_keep = 2.0;     // back plate kept between the window and the bottom wall

/* [USB-C plug] */
usb_plug_w = 13.0;          // MEASURE plug body (overmould) width + margin
usb_plug_h = 7.5;           // MEASURE plug body height + margin
usb_plug_r = 1.5;           // cutout corner radius
usb_center_z = 6.0;         // USB-C centre height above the back plate (plug must clear the wall behind)

/* [Dupont wiring] */
dupont_h = 14.0;            // MEASURE female Dupont housing length
wire_bend = 4.0;            // room above the Dupont housings for the wires to bend

/* [SDP810-125Pa] */
sdp_l = 29.0;               // MEASURE body length incl. ears
sdp_w = 18.0;               // MEASURE body width
sdp_h = 10.25;              // MEASURE body height (port face to pin face)
sdp_hole_d = 2.9;           // MEASURE ear hole diameter
sdp_hole_dx = 24.0;         // MEASURE ear hole spacing
sdp_port_dx = 12.6;         // MEASURE port spacing
sdp_port_off = 4.5;         // MEASURE ear hole line to port centre line
sdp_pin_off = 2.75;         // MEASURE ear hole line to pin row (other side from the ports)
sdp_pin_pitch = 2.0;        // MEASURE
sdp_pin_len = 2.7;          // MEASURE pins above the pin face
sdp_barb_d = 5.2;           // MEASURE barb diameter
sdp_tube_od = 8.0;          // MEASURE tube outer diameter; the port holes let the tube through to the flange (0 = barb-size holes)
sdp_flange_d = 8.0;         // MEASURE port flange diameter
sdp_flange_z = 2.6;         // MEASURE port face to far side of the flange
sdp_port_len = 13.5;        // MEASURE port length from the port face
sdp_high_left = true;       // MEASURE "High" port on the left seen from the front (flip if your sensor is the other way)
sdp_hdr_clear = 15.0;       // free space behind the pins for the 2.0 mm header and its wires

/* [Hardware] */
sdp_boss_d = 5.5;           // boss diameter for the SDP810 screws
sdp_boss_h = 3.2;           // standoff from the wall; must clear the port flange
sdp_pilot_d = 2.1;          // MEASURE M2.5 self-tapping pilot hole (2.1 for PLA, 2.2 for PETG)
sdp_access_d = 8.0;         // screwdriver access holes in the top wall
lid_pilot_d = 2.2;          // pilot hole in the corner bosses
lid_clear_d = 3.3;          // through-hole in the lid
lid_head_d = 5.0;           // MEASURE screw head diameter; the lid hole is countersunk to fit (0 = no countersink)
lid_boss_d = 6.0;           // corner boss diameter
lid_screw_depth = 10.0;     // pilot hole depth: screw length minus the 2 mm lid

/* [Layout] */
margin = 3.0;               // free space between parts and walls
sdp_c3_gap = 5.0;           // gap between the SDP810 bosses and the C3 cradle
inner_d = 47.0;             // inside height (Y) of the box
rail = 1.2;                 // C3 cradle side rail thickness
sdp_floor_gap = 0.8;        // gap between the SDP810 body and the back plate
snap_w = 10.0;              // C3 antenna-end snap width
snap_t = 1.2;               // C3 antenna-end snap thickness
snap_hook = 0.8;            // C3 snap overhang over the PCB
usb_hook_reach = 1.0;       // USB-end hooks: reach over the header spacer, from the PCB edge
clip_gap = 6.0;             // wire clip opening
clip_h = 12.0;              // wire clip height
vent_w = 1.6;               // vent slot width
vent_pitch = 4.0;           // vent slot pitch
skirt_h = 5.0;              // lid skirt depth
skirt_t = 1.6;              // lid skirt thickness
snap_len = 10.0;            // lid snap tab length
snap_bump = 0.8;            // lid snap bump height (engagement = bump - clr)

// ---------------------------------------------------------------- derived
eps = 0.01;
screw_lid = lid_fastening == "screw";
corner_keep = screw_lid ? max(0, lid_boss_d - margin) : 0;   // keep parts 1 mm clear of the corner bosses

sdp_ext = max(sdp_l / 2, sdp_hole_dx / 2 + sdp_boss_d / 2);
xs = wall + margin + corner_keep + sdp_ext;   // SDP810 centre X
sdp_y0 = wall + sdp_boss_h;                   // SDP810 port face Y
sdp_top = sdp_y0 + sdp_h;                     // SDP810 pin face Y
zh = wall + sdp_floor_gap + sdp_w / 2;        // ear hole line Z
zp = zh - sdp_port_off;                       // port centre Z (ports toward the back)
zpin = zh + sdp_pin_off;                      // SDP810 pin row Z
side = sdp_high_left ? -1 : 1;
x_high = xs + side * sdp_port_dx / 2;
x_low = xs - side * sdp_port_dx / 2;

cr_x0 = xs + sdp_ext + sdp_c3_gap;            // cradle left rail, outer face
c3_gap = clr + c3_w_play / 2;                 // gap between each PCB long edge and its rail
bx = cr_x0 + rail + c3_gap;                   // PCB left edge
by = wall + clr + c3_usb_overhang;            // PCB USB-C edge
bz = usb_center_z + c3_usb_h / 2;             // PCB underside (component side, facing the back)
board_top = bz + c3_t;
hdr_top = board_top + c3_hdr_h;
pocket_d = c3_usb_h + 0.2;
b_end = by + c3_l;                            // PCB antenna edge
usb_x = bx + c3_w / 2 + c3_usb_dx;
c3_y1 = b_end + clr + c3_l_play;              // cradle end, inner face of the antenna-end snap
port_r = max(sdp_barb_d, sdp_tube_od) / 2 + clr;
label_z = zp + port_r + 1.5;

W = bx + c3_w + c3_gap + rail + margin + corner_keep + wall;
D = inner_d + 2 * wall;
Hb = max(hdr_top + dupont_h + wire_bend, wall + sdp_floor_gap + sdp_w + 2);  // base wall top
H = Hb + wall;                                // closed box height

groove_z = Hb - skirt_h + 1.5;
clip_x = (xs + sdp_ext + cr_x0) / 2;
clip_y = b_end + 4;

echo(str("Box outside: ", W, " x ", D, " x ", H, " mm"));
assert(usb_center_z - usb_plug_h / 2 >= 1, "USB plug would hit the mounting wall: raise usb_center_z");
assert(sdp_boss_h >= sdp_flange_z + 0.4, "sdp_boss_h too small: port flange hits the wall");
assert(sdp_top + sdp_pin_len + sdp_hdr_clear <= D - wall, "inner_d too small for the SDP810 header clearance");
assert(sdp_port_dx - 2 * port_r >= 2.5, "port holes too close together: sdp_tube_od too large");
assert(zp - port_r >= wall + 0.4, "port holes cut into the back plate");

// ---------------------------------------------------------------- helpers
module box(p0, p1) { translate(p0) cube([p1[0] - p0[0], p1[1] - p0[1], p1[2] - p0[2]]); }

// 2D teardrop, tip toward +y (horizontal holes print without support)
module teardrop2d(r) { hull() { circle(r); rotate(45) square(r); } }

// Extrude a 2D profile drawn in (X, Z) along +Y, from y0 to y0 + len
module along_y(y0, len) { translate([0, y0 + len, 0]) rotate([90, 0, 0]) linear_extrude(len) children(); }

// Extrude a 2D profile drawn in (Y, Z) along +X, from x0 to x0 + len
module along_x(x0, len) { translate([x0, 0, 0]) rotate([90, 0, 90]) linear_extrude(len) children(); }

module rrect2d(w, h, r) { offset(r) square([w - 2 * r, h - 2 * r], center = true); }

// ---------------------------------------------------------------- base
module shell() {
    difference() {
        cube([W, D, Hb]);
        translate([wall, wall, wall]) cube([W - 2 * wall, D - 2 * wall, Hb]);
    }
}

// SDP810 screw bosses on the inside of the bottom wall. Teardrop profile with
// the tip toward the back plate, so they print without support.
module sdp_bosses() {
    for (s = [-1, 1])
        along_y(wall - eps, sdp_boss_h + eps)
            translate([xs + s * sdp_hole_dx / 2, zh]) rotate(180) teardrop2d(sdp_boss_d / 2);
}

module sdp_cuts() {
    // pilot holes (blind, 0.8 mm skin left on the outside)
    for (s = [-1, 1])
        along_y(0.8, wall + sdp_boss_h)
            translate([xs + s * sdp_hole_dx / 2, zh]) circle(d = sdp_pilot_d);
    // port holes, big enough for the tube to slide through onto the barb; teardrop with a flat top
    for (x = [x_high, x_low])
        along_y(-1, wall + 2)
            translate([x, zp]) intersection() {
                teardrop2d(port_r);
                translate([-port_r - 1, -port_r - 1]) square([2 * port_r + 2, 2 * port_r + 1.5]);
            }
    // screwdriver access through the top wall
    for (s = [-1, 1])
        along_y(D - wall - 1, wall + 2)
            translate([xs + s * sdp_hole_dx / 2, zh]) teardrop2d(sdp_access_d / 2);
}

// "+ INNE" / "− UTE", raised on the outside of the bottom wall, above each port.
// They read correctly when you look up at the bottom of the box from the front.
module labels() {
    for (l = [[x_high, "+ INNE"], [x_low, "− UTE"]])
        translate([l[0], eps, label_z])
            rotate([90, 0, 0]) linear_extrude(emboss + eps)
                text(l[1], size = label_size, font = label_font, halign = "center", valign = "bottom");
}

// Cradle for the C3-Zero, mounted upside down (components toward the back,
// header pins toward the lid). The PCB rests on two edge ledges. Two hooks on
// the bottom wall hold the header spacer ends at the USB end, one thin snap
// holds the antenna end.
module c3_cradle() {
    y1 = c3_y1;
    for (m = [0, 1]) {
        xl = m == 0 ? bx - c3_gap - rail : bx + c3_w + c3_gap;
        box([xl, wall - eps, 0], [xl + rail, y1, board_top]);               // side rail
        xe = m == 0 ? bx - c3_gap : bx + c3_w - c3_ledge;
        box([xe, wall - eps, 0], [xe + c3_ledge + c3_gap, y1, bz]);            // edge ledge
    }
    // backstop under the components; the antenna end stays open
    box([bx - eps, wall - eps, 0], [bx + c3_w + eps, b_end - c3_antenna_zone, bz - pocket_d]);
    // antenna-end snap
    zb = board_top + 0.15;
    translate([bx + c3_w / 2 - snap_w / 2, 0, 0]) {
        box([0, y1, 0], [snap_w, y1 + snap_t, zb]);
        hull() {
            // the hook reaches over the play as well, so it still covers snap_hook of the PCB
            box([0, y1 - snap_hook - c3_l_play, zb], [snap_w, y1 + snap_t, zb + 0.4]);
            box([0, y1, zb + 0.4 + snap_hook + c3_l_play], [snap_w, y1 + snap_t, zb + 0.4 + snap_hook + c3_l_play + eps]);
        }
    }
    // USB-end hooks over the header spacer ends (pins 1 and 18 stay free)
    for (x0 = [bx + 0.4, bx + c3_w - 2.4]) {
        z0 = hdr_top + 0.15;
        hull() {
            box([x0, wall - eps, z0], [x0 + 2, by + usb_hook_reach, z0 + 0.8]);
            box([x0, wall - eps, z0 + 0.8 + (by + usb_hook_reach - wall)], [x0 + 2, wall, z0 + 0.8 + (by + usb_hook_reach - wall) + eps]);
        }
    }
}

module usb_cut() {
    along_y(-1, wall + 1 + clr + eps)
        translate([usb_x, usb_center_z]) rrect2d(usb_plug_w, usb_plug_h, usb_plug_r);
}

// Two posts with lips that hold the 4 Dupont wires between the SDP810 and the C3
module wire_clip() {
    for (s = [-1, 1]) {
        xi = clip_x + s * clip_gap / 2;               // inner face
        xo = xi + s * 1.6;
        box([min(xi, xo), clip_y - 2, 0], [max(xi, xo), clip_y + 2, clip_h]);
        hull() {   // lip, 45 degrees underneath
            box([min(xi, xo), clip_y - 2, clip_h - 1.6], [max(xi, xo), clip_y + 2, clip_h]);
            box([min(xi - s * 1.0, xi), clip_y - 2, clip_h - 0.6], [max(xi - s * 1.0, xi), clip_y + 2, clip_h]);
        }
    }
}

// Window in the back plate under the C3 component side: reach BOOT / RESET with a
// finger or a pin and see the LED. The edge ledges and the rails stay intact.
module back_window() {
    x0 = bx + c3_ledge + 0.3;
    x1 = bx + c3_w - c3_ledge - 0.3;
    y0 = wall + back_window_keep;
    y1 = b_end - 1;
    translate([(x0 + x1) / 2, (y0 + y1) / 2, -1])
        linear_extrude(bz) rrect2d(x1 - x0, y1 - y0, 1.5);
}

module vents() {
    zb = wall + 3;
    zt = Hb - skirt_h - 2;
    // left wall (next to the "+" port) and right wall
    for (x0 = [-1, W - wall - 1])
        for (y = [wall + 8 : vent_pitch : D - wall - 8])
            along_x(x0, wall + 2) translate([y, (zb + zt) / 2]) rrect2d(vent_w, zt - zb, vent_w / 2 - eps);
    // top wall, right of the screwdriver access holes
    for (x = [xs + sdp_hole_dx / 2 + sdp_access_d + 3 : vent_pitch : W - wall - 8])
        along_y(D - wall - 1, wall + 2) translate([x, (zb + zt) / 2]) rrect2d(vent_w, zt - zb, vent_w / 2 - eps);
}

function corner_pts() = [for (x = [wall + lid_boss_d / 2 - 1, W - wall - lid_boss_d / 2 + 1])
                         for (y = [wall + lid_boss_d / 2 - 1, D - wall - lid_boss_d / 2 + 1]) [x, y]];

module base(full = true) {
    difference() {
        union() {
            shell();
            sdp_bosses();
            c3_cradle();
            if (full) wire_clip();
            labels();
            if (screw_lid) for (p = corner_pts()) translate(p) cylinder(d = lid_boss_d, h = Hb);
        }
        sdp_cuts();
        usb_cut();
        if (back_window) back_window();
        if (full) vents();
        if (!screw_lid) {
            for (y = [wall, D - wall]) groove(y);
            // pry notch for a fingernail / flat screwdriver
            box([W - wall - 1, D / 2 - 4, Hb - 1.2], [W + 1, D / 2 + 4, Hb + 1]);
        }
        if (screw_lid) for (p = corner_pts()) translate([p[0], p[1], Hb - lid_screw_depth]) cylinder(d = lid_pilot_d, h = lid_screw_depth + 1);
    }
}

// Triangular groove along X in the inner face of a wall at y
module groove(y) {
    s = (snap_bump + 0.1) * sqrt(2);
    translate([wall + 2, y, groove_z]) rotate([45, 0, 0]) translate([0, -s / 2, -s / 2]) cube([W - 2 * wall - 4, s, s]);
}

// ---------------------------------------------------------------- lid (modelled in place, on top of the base)
module lid() {
    o = wall + clr;
    snap_xs = [W / 3, 2 * W / 3];
    difference() {
        union() {
            translate([0, 0, Hb]) cube([W, D, wall]);
            difference() {
                box([o, o, Hb - skirt_h], [W - o, D - o, Hb + eps]);
                box([o + skirt_t, o + skirt_t, Hb - skirt_h - 1], [W - o - skirt_t, D - o - skirt_t, Hb + 1]);
            }
            if (!screw_lid)
                for (x = snap_xs, y = [o, D - o]) {
                    s = snap_bump * sqrt(2);
                    translate([x - snap_len / 2, y, groove_z]) rotate([45, 0, 0]) translate([0, -s / 2, -s / 2]) cube([snap_len, s, s]);
                }
        }
        if (!screw_lid)   // slits make each snap a flexible tab
            for (x = snap_xs, s = [-1, 1], y = [o - 2, D - o - skirt_t - 1])
                box([x + s * (snap_len / 2 + 0.5) - 0.5, y, Hb - skirt_h - 1], [x + s * (snap_len / 2 + 0.5) + 0.5, y + skirt_t + 3, Hb - 0.2]);
        if (screw_lid)
            for (p = corner_pts()) {
                translate([p[0], p[1], Hb - skirt_h - 1]) cylinder(d = lid_boss_d + 2 * clr, h = skirt_h + 1);
                translate([p[0], p[1], Hb - 1]) cylinder(d = lid_clear_d, h = wall + 2);
                // 90 degree countersink, flush with the lid face
                if (lid_head_d > 0)
                    translate([p[0], p[1], Hb + wall - lid_head_d / 2 - 0.2]) cylinder(d1 = 0, d2 = lid_head_d + 0.4, h = lid_head_d / 2 + 0.2 + eps);
            }
    }
}

// ---------------------------------------------------------------- test-fit coupon
// Bottom strip of the base: C3 cradle, USB-C cutout, SDP810 wall with port holes,
// bosses and labels.
coupon_d = c3_y1 + snap_t + 1.5;
coupon_h = max(zh + sdp_boss_d / 2, hdr_top + 0.15 + 0.8 + usb_hook_reach + 1, label_z + label_size) + 1.5;
module coupon() {
    intersection() {
        base(full = false);
        translate([-1, -2, -1]) cube([W + 2, coupon_d + 2, coupon_h + 1]);
    }
}

// ---------------------------------------------------------------- component models (assembly view only)
module sdp_model() {
    color("ivory") {
        box([xs - sdp_l / 2, sdp_y0, zh - sdp_w / 2], [xs + sdp_l / 2, sdp_top, zh + sdp_w / 2]);
    }
    color("goldenrod") for (i = [-1.5 : 1 : 1.5])
        translate([xs + i * sdp_pin_pitch - 0.25, sdp_top, zpin - 0.25]) cube([0.5, sdp_pin_len, 0.5]);
    color("ivory") for (x = [x_high, x_low]) {
        along_y(sdp_y0 - sdp_flange_z, 0.8) translate([x, zp]) circle(d = sdp_flange_d);
        along_y(sdp_y0 - sdp_port_len, sdp_port_len) translate([x, zp]) circle(d = sdp_barb_d);
    }
    // 2.0 mm female header
    color("dimgray") box([xs - 4, sdp_top + 0.5, zpin - 2], [xs + 4, sdp_top + 0.5 + 6, zpin + 2]);
    color("silver") for (s = [-1, 1]) along_y(sdp_y0 - 1, 1) translate([xs + s * sdp_hole_dx / 2, zh]) circle(d = 4.5);
}

module c3_model() {
    color("royalblue") box([bx, by, bz], [bx + c3_w, b_end, board_top]);
    color("silver") box([usb_x - c3_usb_w / 2, by - c3_usb_overhang, bz - c3_usb_h], [usb_x + c3_usb_w / 2, by - c3_usb_overhang + c3_usb_l, bz]);
    color("firebrick") box([bx + 6, b_end - 2.2, bz - 1.2], [bx + 12, b_end - 0.4, bz]);
    for (xr = [bx + c3_pin_inset, bx + c3_w - c3_pin_inset]) {
        color("black") box([xr - c3_hdr_w / 2, by + c3_first_pin - c3_pin_pitch / 2, board_top],
                           [xr + c3_hdr_w / 2, by + c3_first_pin + (c3_pins - 0.5) * c3_pin_pitch, hdr_top]);
        color("goldenrod") for (i = [0 : c3_pins - 1])
            translate([xr - 0.32, by + c3_first_pin + i * c3_pin_pitch - 0.32, board_top]) cube([0.64, 0.64, c3_hdr_h + c3_pin_len]);
    }
    // Dupont housings on pins 2, 3, 8, 9 (GND, 3V3, GPIO4, GPIO5), left row
    color("dimgray", 0.9) for (i = [1, 2, 7, 8])
        translate([bx + c3_pin_inset - 1.25, by + c3_first_pin + i * c3_pin_pitch - 1.25, hdr_top]) cube([2.5, 2.5, dupont_h]);
}

// ---------------------------------------------------------------- output
if (part == "base") base();
else if (part == "lid") translate([0, D, H]) rotate([180, 0, 0]) lid();   // print plate down
else if (part == "coupon") coupon();
else {
    color("lightgray") base();
    if (show_lid) color("white", 0.45) translate([0, 0, explode]) lid();
    if (show_components) { sdp_model(); c3_model(); }
}
