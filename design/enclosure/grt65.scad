// Dimensions in mm. Coordinate origin is the bottom center of the case.
// In use, +Y is the near (trackpad) side and -Y is the far (keys) side.
part = "assembly"; // [assembly,tray,deck,pad,sensor,caps,keys,controller,battery,switch,section]
layout = "reference"; // [compact,reference]
reference = layout == "reference";
// Envelopes are provisional. Set these values using worst-case measured stacks.
reference_shell_height = 12.8;
reference_key_pcb_top = 5.3;
section_x = -17;
$fn = 48;

case_size = reference ? [85, 76] : [85, 102];
case_top = reference ? reference_shell_height : 9.5;
target_height = 12;
outer_radius = 4;
wall = 1.5;
floor_z = 1.2;
deck_thickness = 1.4;
deck_z = case_top - deck_thickness;

pad_center = [0, reference ? 10 : 1.5];
pad_size = [65, 49];
pad_panel_width = 79;
pad_pcb = 1.6;
overlay = 2;
pad_z = case_top - overlay - pad_pcb;

key_centers = [-19, 0, 19];
key_y = reference ? -25.5 : -36;
key_pcb_center = [0, key_y];
key_pcb_size = [72, 21];
key_pcb_top = reference ? reference_key_pcb_top : 3;
key_pcb_thickness = 1.2;
cap_height_from_pcb = 8.6; // Replace with measured unpressed assembly.
cap_size = [17.5, 16.5]; // Clearance model only.
cap_thickness = 2.5;
key_opening = [18.3, 17.3];
key_top = key_pcb_top + cap_height_from_pcb;

xiao_center = [16, reference ? 10 : 38.5];
xiao_envelope = [17.5, 21, 4.2];
xiao_z = 2;
battery_center = [-17, reference ? 10 : 38];
battery_envelope = [34, 22, 5.5]; // Space claim including insulation and growth.
battery_z = floor_z;
switch_center = reference ? [32, -33] : [33.5, 43];
switch_envelope = [12, 7, reference ? 2.5 : 4];
usb_opening = reference ? [10, 3] : [10, 4.6];
far_usb_envelope = [12, 8, 2.5];
far_usb_center = [0, -32];
usb_z = reference ? 2.7 : 4.5;

function disjoint(a, as, b, bs) =
    abs(a[0] - b[0]) >= (as[0] + bs[0]) / 2 ||
    abs(a[1] - b[1]) >= (as[1] + bs[1]) / 2;

envelopes = concat([
    [pad_center, [pad_panel_width, pad_size[1]], pad_z, pad_z+pad_pcb],
    [key_pcb_center, key_pcb_size, key_pcb_top-key_pcb_thickness, key_pcb_top],
    [xiao_center, xiao_envelope, xiao_z, xiao_z+xiao_envelope[2]],
    [battery_center, battery_envelope, battery_z, battery_z+battery_envelope[2]],
    [switch_center, switch_envelope, floor_z, floor_z+switch_envelope[2]],
], reference ? [[far_usb_center, far_usb_envelope, floor_z, floor_z+far_usb_envelope[2]]] : []);
inner_size = case_size - [2*wall, 2*wall];
inner_radius = outer_radius - wall;

function inside_tray(point) =
    abs(point[0]) <= inner_size[0]/2 && abs(point[1]) <= inner_size[1]/2 &&
    norm([for (i = [0:1]) max(0, abs(point[i]) - (inner_size[i]/2-inner_radius))]) <= inner_radius;

for (i = [0:len(envelopes)-1]) {
    center = envelopes[i][0];
    size = envelopes[i][1];
    for (dx = [-1, 1], dy = [-1, 1])
        assert(inside_tray(center + [dx*size[0]/2, dy*size[1]/2]),
               str("Envelope hits rounded case wall: ", i));
    for (j = [0:len(envelopes)-1])
        if (j > i)
            assert(disjoint(center, size, envelopes[j][0], envelopes[j][1]) ||
                   envelopes[i][3] <= envelopes[j][2] || envelopes[j][3] <= envelopes[i][2],
                   str("Overlapping envelopes: ", i, ", ", j));
}
assert(floor_z + switch_envelope[2] < deck_z, "Switch envelope hits deck");
assert(reference || max(case_top, key_top) <= target_height, "Nominal height exceeds target");
assert(battery_z + battery_envelope[2] < deck_z, "Battery envelope hits deck");
assert(xiao_z + xiao_envelope[2] < deck_z, "Controller envelope hits deck");
assert(key_pcb_top - key_pcb_thickness >= floor_z, "Key PCB hits floor");
echo(nominal_height = max(case_top, key_top), target = target_height);
if (reference) {
    key_pcb_bottom = key_pcb_top - key_pcb_thickness;
    echo(battery_to_bare_sensor = pad_z - battery_z - battery_envelope[2],
         xiao_to_bare_sensor = pad_z - xiao_z - xiao_envelope[2],
         usb_to_bare_key_pcb = key_pcb_bottom - floor_z - far_usb_envelope[2],
         switch_to_bare_key_pcb = key_pcb_bottom - floor_z - switch_envelope[2]);
}

module rounded_panel(size, radius, z, height) {
    translate([0, 0, z])
        linear_extrude(height)
            offset(r = radius) square([size[0] - 2*radius, size[1] - 2*radius], center = true);
}

module box_at(center, size, z, height) {
    translate([center[0] - size[0]/2, center[1] - size[1]/2, z])
        cube([size[0], size[1], height]);
}

module tray() {
    difference() {
        rounded_panel(case_size, outer_radius, 0, deck_z);
        rounded_panel(case_size - [2*wall, 2*wall], outer_radius - wall,
                      floor_z, deck_z - floor_z + 0.1);
        translate([(reference ? far_usb_center[0] : xiao_center[0]) - usb_opening[0]/2,
                   reference ? -case_size[1]/2-0.2 : case_size[1]/2-wall-0.2,
                   usb_z - usb_opening[1]/2])
            cube([usb_opening[0], wall + 0.4, usb_opening[1]]);
        if (reference) {
            translate([switch_center[0]-4, -case_size[1]/2-0.2, 2])
                cube([8, wall+0.4, 2]);
            translate([-13, -case_size[1]/2-0.2, 2.7])
                rotate([-90, 0, 0]) cylinder(d=1.4, h=wall+0.4);
        }
    }

    // Provisional support ledges outside the sensing area and switch tails.
    for (x = [pad_center[0]-30, pad_center[0]+30])
        for (y = [pad_center[1]-18, pad_center[1]+18])
            box_at([x, y], [3, 4], floor_z, pad_z-floor_z);
    for (y = [key_y-8, key_y+8])
        for (x = reference && y < key_y ? [-12, 12] : [-34, 34])
            box_at([x, y], [3, 3], floor_z, key_pcb_top-key_pcb_thickness-floor_z);
}

module deck() {
    difference() {
        rounded_panel(case_size, outer_radius, deck_z, deck_thickness);
        translate([pad_center[0], pad_center[1], 0])
            rounded_panel(pad_size + [0.5, 0.5], 4.25, deck_z-0.1, deck_thickness+0.2);
        for (x = key_centers)
            box_at([x, key_y], key_opening, deck_z-0.1, deck_thickness+0.2);
    }
}

module touch_surface() {
    translate([pad_center[0], pad_center[1], 0])
        rounded_panel(pad_size, 4, pad_z + pad_pcb, overlay);
}

module sensor_envelope() {
    // Gross panel outline, including sacrificial edges. Actual outline is irregular.
    box_at(pad_center, [pad_panel_width, pad_size[1]], pad_z, pad_pcb);
}

module caps() {
    for (x = key_centers)
        translate([x, key_y, 0])
            rounded_panel(cap_size, 2, key_top-cap_thickness, cap_thickness);
}

module key_assembly() {
    box_at(key_pcb_center, key_pcb_size, key_pcb_top-key_pcb_thickness, key_pcb_thickness);
    for (x = key_centers)
        box_at([x, key_y], [14, 14], key_pcb_top,
               key_top-cap_thickness-key_pcb_top);
}

module controller() {
    box_at(xiao_center, xiao_envelope, xiao_z, xiao_envelope[2]);
}

module battery() {
    box_at(battery_center, battery_envelope, battery_z, battery_envelope[2]);
}

module power_switch() {
    box_at(switch_center, switch_envelope, floor_z, switch_envelope[2]);
}

module assembly() {
    color("#18191c") tray();
    color("#292b30") deck();
    color("#363942") touch_surface();
    color("#325b4d") sensor_envelope();
    color("#16171a") caps();
    color("#386655") key_assembly();
    color("#3c5478") controller();
    color("#b09c63") battery();
    color("#53515b") power_switch();
    if (reference)
        color("#798495")
            box_at(far_usb_center, far_usb_envelope, floor_z, far_usb_envelope[2]);
}

if (part == "tray") tray();
else if (part == "deck") deck();
else if (part == "pad") touch_surface();
else if (part == "sensor") sensor_envelope();
else if (part == "caps") caps();
else if (part == "keys") key_assembly();
else if (part == "controller") controller();
else if (part == "battery") battery();
else if (part == "switch") power_switch();
else if (part == "assembly") assembly();
else if (part == "section")
    projection(cut = true)
        rotate([0, 90, 90]) translate([-section_x, 0, 0]) assembly();
else assert(false, "Unknown part");
