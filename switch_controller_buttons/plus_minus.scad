$fn = 360;

// Actual measured button dimensions in mm.
ACTUAL_LENGTH = 5.25;
ACTUAL_WIDTH = 1.53;
ACTUAL_HEIGHT = 0.8;

// set to how much larger than actual it should be.
SCALING_FACTOR = 3.56;

// false is just the minus. true will do the plus
DRAW_PLUS = false;

scale(v = [SCALING_FACTOR, SCALING_FACTOR, SCALING_FACTOR]) {

    cube([ACTUAL_LENGTH, ACTUAL_WIDTH, ACTUAL_HEIGHT]);

    if (DRAW_PLUS) {
        translate([ACTUAL_LENGTH / 2 - ACTUAL_WIDTH / 2, -ACTUAL_LENGTH / 2 + ACTUAL_WIDTH / 2, 0]) {
            cube([ACTUAL_WIDTH, ACTUAL_LENGTH, ACTUAL_HEIGHT]);
        }
    }

}


