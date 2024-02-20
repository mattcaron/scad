$fn = 360;

include<triangles.scad>

// Actual measured button dimensions in mm.
// this just makes a single black button. We don't bother with the clear outer circle; it's included in this measurement.
ACTUAL_CIRCLE_DIAMETER = 7.5;
ACTUAL_HEIGHT = 0.2;

TRIANGLE_BASE = 4.5;
TRIANGLE_HEIGHT = 2;

WALL_HEIGHT = 2;
WALL_WIDTH = 1;
WALL_THICKNESS = 1;

BASE_WIDTH = 3;
BASE_HEIGHT = 1;


// set to how much larger than actual it should be.
SCALING_FACTOR = 3.56;

module home() {
    Isosceles_Triangle(b = TRIANGLE_BASE, H = TRIANGLE_HEIGHT);
    translate([WALL_WIDTH, -WALL_HEIGHT/2, WALL_THICKNESS/2]) {
        cube([WALL_WIDTH, WALL_HEIGHT, WALL_THICKNESS], true);
    }
    translate([-WALL_WIDTH, -WALL_HEIGHT/2, WALL_THICKNESS/2]) {
        cube([WALL_WIDTH, WALL_HEIGHT, WALL_THICKNESS], true);
    }
    translate([0, -WALL_HEIGHT + BASE_HEIGHT/2, WALL_THICKNESS/2]) {
        cube([BASE_WIDTH, BASE_HEIGHT, WALL_THICKNESS], true);
    }

}

scale(v = [SCALING_FACTOR, SCALING_FACTOR, SCALING_FACTOR]) {

    difference() {
        cylinder(d = ACTUAL_CIRCLE_DIAMETER, h = ACTUAL_HEIGHT);
        translate([0, ACTUAL_CIRCLE_DIAMETER/20 ,ACTUAL_HEIGHT/2]) {
            home();
        }
    }

}


