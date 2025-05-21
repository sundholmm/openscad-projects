// ======================================
// 1968 CHEVROLET CHEVELLE RADIO FACE PLATE WITH KNOB CUPS
// ======================================

// General parameters
$fn = 20;
depth = 3;

// Radio face dimensions
radio_face_width = 119.3;
radio_face_height = 47.2;

// Plate dimensions
plate_edge_width = 4;
plate_width = 209; // 213 as plate_edge_width is added on both edges
plate_height = radio_face_height + 2;

// Radio face paddings
radio_face_padding = (plate_width - radio_face_width) / 2;
radio_face_padding_vertical = (plate_height - radio_face_height) / 2;

// Screw hole parameters
screw_hole_radius = 1;
screw_hole_inset = 4;

// Knob parameters
knob_hole_radius = 15;
knob_y_position = plate_height / 2;

// Calculated knob positions
left_knob_x = radio_face_padding - knob_hole_radius - depth;
right_knob_x = plate_width - radio_face_padding + knob_hole_radius + depth;

// Plate support parameters
support_height = 3;
support_y_offset = -2;
support_width = radio_face_width + (knob_hole_radius * 2) + (depth * 4);

// Cup common parameters
cup_wall_thickness = 2;
cup_taper = 3;
center_hole_radius = 6;

// Cup dimensions - Left
cup_left_height = 11; // depth adjusted

// Cup dimensions - Right
cup_right_height = 21; // depth adjusted

// Derived cup parameters
function cup_outer_radius_bottom(base_radius) = base_radius + cup_wall_thickness;
function cup_outer_radius_top(base_radius) = base_radius + cup_wall_thickness - cup_taper;
function cup_inner_radius_bottom(base_radius) = base_radius;
function cup_inner_radius_top(base_radius) = base_radius - cup_taper;

// ======================================
// MODULES
// ======================================

// Create a knob cup with specified height and z-offset
module knob_cup(height) {
    inner_height = height - depth;
    
    difference() {
        cylinder(height, 
                cup_outer_radius_bottom(knob_hole_radius), 
                cup_outer_radius_top(knob_hole_radius));
        
        cylinder(inner_height, 
                cup_inner_radius_bottom(knob_hole_radius), 
                cup_inner_radius_top(knob_hole_radius));
        
        translate([0, 0, inner_height]) 
            cylinder(depth, center_hole_radius, center_hole_radius);
    }
}

// Create a screw hole at specified position
module screw_hole(x, y) {
    translate([x, y, 0]) 
        cylinder(depth, screw_hole_radius, screw_hole_radius);
}

// Create an angled edge
module angled_edge(width, height, angle) {
    difference() {
        cube([width, height, depth]);
        translate([0, 0, -0.2]) {
            rotate([0, 0, angle]) {
                cube([64, 64, depth + 1]);
            }
        }
    }
}

// ======================================
// MAIN PLATE
// ======================================

difference() {
    // Main plate
    cube([plate_width, plate_height, depth]);
    
    // Radio face hole
    translate([radio_face_padding, radio_face_padding_vertical, 0]) 
        cube([radio_face_width, radio_face_height, depth]);
    
    // Radio knob holes
    translate([left_knob_x, knob_y_position, 0]) 
        cylinder(depth, knob_hole_radius, knob_hole_radius);
    translate([right_knob_x, knob_y_position, 0]) 
        cylinder(depth, knob_hole_radius, knob_hole_radius);
    
    // Screw holes
    screw_hole(screw_hole_inset, screw_hole_inset);
    screw_hole(screw_hole_inset, plate_height - screw_hole_inset);
    screw_hole(plate_width - screw_hole_inset, screw_hole_inset);
    screw_hole(plate_width - screw_hole_inset, plate_height - screw_hole_inset);
}

// Right plate edge
translate([plate_width, 0, 0]) 
    angled_edge(plate_height, plate_height, -plate_edge_width);

// Left plate edge
translate([-plate_edge_width, 0, 0]) 
    angled_edge(plate_edge_width, plate_height, 90 - plate_edge_width);

// ======================================
// SUPPORT STRUCTURES
// ======================================

// Plate support
translate([radio_face_padding - knob_hole_radius - depth, support_y_offset, 0]) 
    cube([support_width, support_height, depth]);

// ======================================
// KNOB CUPS
// ======================================

// Right knob cup
translate([right_knob_x, knob_y_position, depth]) 
    knob_cup(cup_left_height);

// Left knob cup
translate([left_knob_x, knob_y_position, depth]) 
    knob_cup(cup_right_height);
