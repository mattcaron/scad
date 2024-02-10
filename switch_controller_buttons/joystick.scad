$fn = 360;

include<dome.scad>

// From the bottom, there's a base (which is just a flat to mount it on, instead of a recess), capped by a dome, which attackes to the part where your thumb goes

// Actual measured button dimensions in mm.
ACTUAL_STICK_DIAMETER = 15.25;
ACTUAL_STICK_THICKNESS = 3.5;
ACTUAL_THUMB_BUTTON_DIAMETER = 1;

// Assume the top 25% is domed
stick_dome_thickness = ACTUAL_STICK_THICKNESS / 4;

ACTUAL_BASE_DOME_DIAMETER = 10;
ACTUAL_BASE_DOME_HEIGHT = 3;


ACTUAL_TOPPER_DOME_DIAMETER = 5;
ACTUAL_TOPPER_DOME_HEIGHT = 1;


BASE_THICKNESS = 0.1;

// set to how much larger than actual it should be.
SCALING_FACTOR = 3.56;

module thumb_rest() {
    rotate_extrude(angle = 86) {
        translate([ACTUAL_STICK_DIAMETER/2 - ACTUAL_THUMB_BUTTON_DIAMETER/2, 0, 0]) {
        circle(d = ACTUAL_THUMB_BUTTON_DIAMETER);
        }
    }
}

scale(v = [SCALING_FACTOR, SCALING_FACTOR, SCALING_FACTOR]) {

    cylinder(d = ACTUAL_STICK_DIAMETER, h = BASE_THICKNESS);
    dome(d = ACTUAL_BASE_DOME_DIAMETER, h = ACTUAL_BASE_DOME_HEIGHT);
    
    translate([0,0,ACTUAL_BASE_DOME_HEIGHT + ACTUAL_TOPPER_DOME_HEIGHT / 2]) {
        rotate([0,180,0]) {
            dome(d = ACTUAL_TOPPER_DOME_DIAMETER, h = ACTUAL_TOPPER_DOME_HEIGHT);
        }
        cylinder(d = ACTUAL_STICK_DIAMETER, h = ACTUAL_STICK_THICKNESS - stick_dome_thickness);
        translate([0,0, ACTUAL_STICK_THICKNESS - stick_dome_thickness]) {
            dome(d = ACTUAL_STICK_DIAMETER, h = stick_dome_thickness);
            thumb_rest();
            rotate([0, 0, 90]) {
                thumb_rest();
            }
            rotate([0, 0, 180]) {
                thumb_rest();
            }            
            rotate([0, 0, 270]) {
                thumb_rest();
            }
        }
    }
}


