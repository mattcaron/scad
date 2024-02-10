$fn = 360;

include<dome.scad>
include<triangles.scad>

// Actual measured button dimensions in mm.
ACTUAL_DIAMETER = 7.1;
ACTUAL_HEIGHT = 1.4;
TRIANGLE_SIDE = 2.5;

// set to how much larger than actual it should be.
SCALING_FACTOR = 3.56;

// set to true for inset triangle "arrow"
DRAW_TRIANGLE = true;

// This is a WAG approximation - 25% of the height is domed.
dome_height = ACTUAL_HEIGHT / 4;
cylinder_height = ACTUAL_HEIGHT - dome_height;

scale(v = [SCALING_FACTOR, SCALING_FACTOR, SCALING_FACTOR]) {

    cylinder(h = cylinder_height, d = ACTUAL_DIAMETER);

    difference() {
        translate([0,0,cylinder_height]) {
            dome(d = ACTUAL_DIAMETER, h = dome_height);
        }
        
        if (DRAW_TRIANGLE) {
            translate([0,-(TRIANGLE_SIDE/3),cylinder_height+(dome_height / 2)]) {
                Equilateral_Triangle(l=TRIANGLE_SIDE);
            }
        }
    }

}


