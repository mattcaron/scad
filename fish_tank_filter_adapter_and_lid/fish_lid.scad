include <../triangles.scad>;

$fn = 360;

// Lid:
// 128mm rim OD
// 15mm rim height
LID_INNER_DIAMETER = 130;
LID_INNER_HEIGHT = 15;
LID_THICKNESS = 2;

LID_INNER_RING_DIAMETER = 127;
LID_INNER_RING_HEIGHT = 3;
LID_INNER_RING_THICKNESS = 4;

PROTECTIVE_RING_HEIGHT = 20;
PROTECTIVE_RING_EARS_WIDTH = 20;

// Filter hole:
// 65mm x 80mm oval
FILTER_HOLE_WIDTH = 65;
FILTER_HOLE_LENGTH = 85;

// 5mm wire hole
WIRE_HOLE_DIAMETER = 5;

// offset from inner wall of rim
INNER_RIM_OFFSET = 20;

delta = 1;

module lid_base() {
    difference() {
        cylinder(h = LID_INNER_HEIGHT + LID_THICKNESS, d = LID_INNER_DIAMETER + LID_THICKNESS * 2);
    
        translate([0,0,-delta]){
            cylinder(h = LID_INNER_HEIGHT + delta, d = LID_INNER_DIAMETER);
        }
    }
}

module snap_ring() {
    difference() {
       cylinder(h = LID_INNER_RING_HEIGHT, d = LID_INNER_RING_DIAMETER + LID_INNER_RING_THICKNESS);
    
        translate([0,0,-delta]){
            cylinder(h = LID_INNER_RING_HEIGHT * 2, d = LID_INNER_RING_DIAMETER);
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
        translate([LID_INNER_DIAMETER / 4, LID_THICKNESS, LID_INNER_HEIGHT /2 ]) {
            rotate([0,90,-90]) {
                Right_Angled_Triangle(a=LID_THICKNESS*4,
                                      b=LID_INNER_HEIGHT,
                                      height = LID_THICKNESS * 2,
                                      centerXYZ=[false,false,false]);
            }
            
        }
    translate([-LID_INNER_DIAMETER / 4, -LID_THICKNESS, LID_INNER_HEIGHT /2 ]) {
            rotate([0,90,90]) {
                Right_Angled_Triangle(a=LID_THICKNESS*4,
                                      b=LID_INNER_HEIGHT,
                                      height = LID_THICKNESS * 2,
                                      centerXYZ=[false,false,false]);
            }
            
        }        
    }
}

module wire_hole() {
    cylinder(h = LID_INNER_HEIGHT * 2, d = WIRE_HOLE_DIAMETER);
}

module protection_ring() {
    translate([0,0, LID_INNER_HEIGHT + LID_THICKNESS]) {
        difference() {
            difference () {
                difference() {
                    cylinder(h = PROTECTIVE_RING_HEIGHT, d = LID_INNER_DIAMETER + LID_INNER_RING_THICKNESS);
                    translate([0,0, -delta]) {
                        cylinder(h = PROTECTIVE_RING_HEIGHT * 2, d = LID_INNER_DIAMETER);
                    }
                }
                translate([LID_INNER_DIAMETER/3 + LID_THICKNESS + delta, LID_INNER_DIAMETER/3 + LID_THICKNESS + delta, -delta/2 ]) {
                    wire_hole();
                }
            }
            translate([0,0, PROTECTIVE_RING_HEIGHT - LID_THICKNESS / 2 + delta / 2]) {
                cube([PROTECTIVE_RING_EARS_WIDTH, LID_INNER_DIAMETER + LID_THICKNESS * 2, LID_THICKNESS + delta], center = true);
            }            
        }
    }
}

module lid () {
    difference() {
        lid_base();
        // off center, towards "back" rim
        translate([0, INNER_RIM_OFFSET, 0]) {
            pump_hole();
        }
    }

    pump_support();
    snap_ring();
    protection_ring();
}

module grate_holes() {
    for (x=[0:7]) {
        for (y=[0:7]) {
            translate([x * LID_THICKNESS * 4, y * LID_THICKNESS * 4, delta]) {
                cube([LID_THICKNESS * 2, LID_THICKNESS * 2, LID_THICKNESS +delta ], center=true);
            }
        }
    }
}

module cover() {
    difference() {
        union() {
            cylinder(h = LID_THICKNESS, d = LID_INNER_DIAMETER  - 1);
            translate([-(PROTECTIVE_RING_EARS_WIDTH - 1) / 2, -(LID_INNER_DIAMETER + LID_THICKNESS) / 2, 0]) {
                cube([PROTECTIVE_RING_EARS_WIDTH - 1, LID_INNER_DIAMETER + LID_THICKNESS, LID_THICKNESS]);
            }
        }
        translate([0, -(LID_INNER_DIAMETER + LID_THICKNESS * 4)/3.5, 0]) {
            rotate([0, 0, 45]) {
                grate_holes();
            }
        }
    }
}

module assembly() {
    lid();
    translate([0,0, LID_INNER_HEIGHT + PROTECTIVE_RING_HEIGHT]) {
        cover();
    }
}
    

// lid();
// cover();
assembly();
