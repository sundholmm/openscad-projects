// Variables
depth = 2;

plate_width = 200;
plate_height = 55;

radio_face_width = 115;
radio_face_height = 48;

radio_face_padding = (plate_width - radio_face_width) / 2;
radio_face_padding_2 = (plate_height - radio_face_height) / 2;

screw_hole_factor = 5;

knob_hole_radius = 16;
knob_padding = plate_height / 2;

depth_factor = depth * 2;

plate_support_width = radio_face_width + (knob_hole_radius * 2) + depth_factor * 2;

// New variables for duplicate expressions
left_knob_x = radio_face_padding - knob_hole_radius - depth_factor;
right_knob_x = plate_width - radio_face_padding + knob_hole_radius + depth_factor;
cup_outer_radius_bottom = knob_hole_radius + 2;
cup_outer_radius_top = knob_hole_radius - 1;
cup_inner_radius_bottom = knob_hole_radius;
cup_inner_radius_top = knob_hole_radius - 2;
cup_height = 10;
cup_inner_height = 8;
center_hole_radius = 4;
center_hole_height = 2;
ring_outer_radius = 5;
ring_inner_radius = 4;

$fn = 20;

// LEVY

difference() {
    cube([plate_width, plate_height, depth]);
    translate([radio_face_padding, radio_face_padding_2, 0]) cube([radio_face_width, radio_face_height, depth]);
    
    translate([left_knob_x, knob_padding, 0]) cylinder(depth, knob_hole_radius, knob_hole_radius);
    translate([right_knob_x, knob_padding, 0]) cylinder(depth, knob_hole_radius, knob_hole_radius);
    
    // RUUVIREIÄT
    translate([screw_hole_factor, screw_hole_factor, 0]) cylinder(depth, 1, 1);
    translate([screw_hole_factor, plate_height - screw_hole_factor, 0]) cylinder(depth, 1, 1);
    translate([plate_width - screw_hole_factor, screw_hole_factor, 0]) cylinder(depth, 1, 1);
    translate([plate_width - screw_hole_factor, plate_height - screw_hole_factor, 0]) cylinder(depth, 1, 1);
}

// LEVYN REUNA

translate([plate_width, 0, 0]) difference() {
    cube([plate_height, plate_height, depth]);
    translate([0, 0, -0.2]){
    rotate([0, 0, -5]){
        cube([64, 64, depth + 1]);
    }
  }
}


// LEVYN TUET

translate([left_knob_x, 1, 2]) cube([plate_support_width, 1, 1]);
translate([left_knob_x, plate_height - 2, 2]) cube([plate_support_width, 1, 1]);

// KUPIT

translate([right_knob_x, knob_padding, 2]) difference() {
    cylinder(cup_height, cup_outer_radius_bottom, cup_outer_radius_top);
    cylinder(cup_inner_height, cup_inner_radius_bottom, cup_inner_radius_top);
    translate([0, 0, cup_inner_height]) cylinder(center_hole_height, center_hole_radius, center_hole_radius);
}

translate([left_knob_x, knob_padding, 0]) difference() {
    cylinder(cup_height, cup_outer_radius_bottom, cup_outer_radius_top);
    cylinder(cup_inner_height, cup_inner_radius_bottom, cup_inner_radius_top);
    translate([0, 0, cup_inner_height]) cylinder(center_hole_height, center_hole_radius, center_hole_radius);
    translate([-8, -8, cup_inner_height]) rotate([0, 0, 32]) cube([6, 6, center_hole_height]);
    rotate([0, 0, 45]) cube([20, 20, cup_height]);
}


// KUPIN RENGAS

translate([left_knob_x, knob_padding, cup_inner_height]) difference() {
    cylinder(center_hole_height, ring_outer_radius, ring_outer_radius);
    cylinder(center_hole_height, ring_inner_radius, ring_inner_radius);
}
