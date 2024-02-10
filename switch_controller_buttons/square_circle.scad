$fn = 360;

// Actual measured button dimensions in mm.
ACTUAL_SQUARE_SIDE = 6;
ACTUAL_CIRCLE_DIAMETER = 4;
ACTUAL_HEIGHT = 0.2;

// set to how much larger than actual it should be.
SCALING_FACTOR = 3.56;

scale(v = [SCALING_FACTOR, SCALING_FACTOR, SCALING_FACTOR]) {

    difference() {
        cube([ACTUAL_SQUARE_SIDE, ACTUAL_SQUARE_SIDE, ACTUAL_HEIGHT]);
        
        translate([ACTUAL_SQUARE_SIDE / 2, ACTUAL_SQUARE_SIDE / 2, ACTUAL_HEIGHT * .75]) {
            cylinder(d = ACTUAL_CIRCLE_DIAMETER);
        }
    }

}


