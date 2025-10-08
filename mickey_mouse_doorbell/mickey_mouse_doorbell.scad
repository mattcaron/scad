include <../Chamfers-for-OpenSCAD/Chamfer.scad>

$fn = 360;

// all measurements in mm

HEAD_DIAMETER = 24.5;
EARS_DIAMETER = 18;

BUTTON_DIAMETER = 17;
BUTTON_SPRING_DIAMETER = 18;

// depth of button up to flange
// minimum is 21mm
BUTTON_DEPTH = 25;

WALL_THICKNESS = 2;
LIP_THICKNESS = 1.5;

SCREW_HOLE_DIAMETER = 4;
WIRING_HOLE_DIAMETER = 6;

delta = 0.01;

// NOTE: max width is 50mm

module trim_piece_mock_up() {
    color("white") {
        translate([0,0,-1]) { 
            cube([100, 50, 1], center = true);
        }
    }
}    
    

module basic_head(){
    HEAD_THICKNESS = BUTTON_DEPTH + WALL_THICKNESS;
    
    chamferCylinder(h = HEAD_THICKNESS, r = HEAD_DIAMETER/2, ch = 0, ch2 = 1, a = 360, q = 2);
    translate([HEAD_DIAMETER / 2, HEAD_DIAMETER / 2, 0]) {
        chamferCylinder(h = HEAD_THICKNESS, r = EARS_DIAMETER/2, ch = 0, ch2 = 1, a = 360, q = 2);
    }
    translate([HEAD_DIAMETER / 2, -HEAD_DIAMETER / 2, 0]) {
        chamferCylinder(h = HEAD_THICKNESS, r = EARS_DIAMETER/2, ch = 0, ch2 = 1, a = 360, q = 2);
    }
}

module doorbell() {
    difference() {
        basic_head();
        
        // button cutout
        translate([0, 0, WALL_THICKNESS + delta]) {
            cylinder(h = BUTTON_DEPTH, d = BUTTON_DIAMETER);
        }
        
        // "lip" for button flange
        translate([0, 0, WALL_THICKNESS + delta]) {
            cylinder(h = BUTTON_DEPTH - LIP_THICKNESS, d = BUTTON_SPRING_DIAMETER);
        }
        
        // top screw hole
        translate([BUTTON_DIAMETER / 2 - WALL_THICKNESS * 1.5, 0, -delta]) {
            cylinder(h = WALL_THICKNESS * 2, d = SCREW_HOLE_DIAMETER);
        }
        
        // bottom screw hole
        translate([-(BUTTON_DIAMETER / 2 - WALL_THICKNESS * 1.5), 0, -delta]) {
            cylinder(h = WALL_THICKNESS * 2, d = SCREW_HOLE_DIAMETER);
        }
        
        // wiring hole
        translate([0, 0, -delta]) {
            cylinder(h = WALL_THICKNESS * 2, d = WIRING_HOLE_DIAMETER);
        }
    }
}

// trim_piece_mock_up();
doorbell();