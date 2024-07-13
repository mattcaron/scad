$fn = 360;

// Lid:
// 128mm OD
// 15mm rim height
LID_INNER_DIAMETER = 128;
LID_INNER_HEIGHT = 15;
LID_THICKNESS = 2;

// Filter hole:
// 65mm x 80mm oval
FILTER_HOLE_WIDTH = 65;
FILTER_HOLE_LENGTH = 85;

// 5mm wire hole
WIRE_HOLE_DIAMETER = 5;

// offset from inner wall of rim
INNER_RIM_OFFSET = 20;

delta = 1;

module lid() {
    difference() {
        cylinder(h = LID_INNER_HEIGHT + LID_THICKNESS, d = LID_INNER_DIAMETER + LID_THICKNESS * 2);
    
        translate([0,0,-delta]){
            cylinder(h = LID_INNER_HEIGHT + delta, d = LID_INNER_DIAMETER);
        }
    }
}

module pump_hole() {
    cylinder(h = LID_INNER_HEIGHT * 2, d = FILTER_HOLE_WIDTH);
    
    translate([0, -abs(FILTER_HOLE_LENGTH - FILTER_HOLE_WIDTH), 0]) {
        cylinder(h = LID_INNER_HEIGHT * 2, d = FILTER_HOLE_WIDTH);
    }
    
    // the cube is the center of the ovoid
    
    translate([-FILTER_HOLE_WIDTH / 2, - FILTER_HOLE_LENGTH / 4, 0]) {
        cube([FILTER_HOLE_WIDTH, FILTER_HOLE_LENGTH / 4, LID_INNER_HEIGHT * 2]);
    }
}

module pump_support() {
    translate([0, INNER_RIM_OFFSET * 2, LID_THICKNESS + LID_INNER_HEIGHT / 2]) {
        cube([LID_INNER_DIAMETER / 2, LID_THICKNESS * 2, LID_INNER_HEIGHT], center=true);
        translate([LID_INNER_DIAMETER / 4, LID_THICKNESS / 6, LID_INNER_HEIGHT / 4]) {
            cube([LID_THICKNESS * 4, LID_THICKNESS * 3, LID_INNER_HEIGHT / 2], center = true);
        }
        translate([-LID_INNER_DIAMETER / 4, LID_THICKNESS / 6, LID_INNER_HEIGHT / 4]) {
            cube([LID_THICKNESS * 4, LID_THICKNESS * 3, LID_INNER_HEIGHT / 2], center = true);
        }
            
    }
}

module wire_hole() {
    cylinder(h = LID_INNER_HEIGHT * 2, d = WIRE_HOLE_DIAMETER);
}


difference() {
    difference() {
        difference() {
            lid();
            // off center, towards "back" rim
            translate([0, INNER_RIM_OFFSET, 0]) {
                pump_hole();
            }
        }
        translate([LID_INNER_DIAMETER/3 + LID_THICKNESS + delta, LID_INNER_DIAMETER/3 + LID_THICKNESS + delta, -delta/2 ]) {
            wire_hole();
        }
    }
            translate([-(LID_INNER_DIAMETER/3 + LID_THICKNESS + delta), (LID_INNER_DIAMETER/3 + LID_THICKNESS + delta), -delta/2 ]) {
            wire_hole();
        }
}
pump_support();