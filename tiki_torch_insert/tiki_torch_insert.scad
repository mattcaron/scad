$fn = 360;

// actual is 11.62
NARROW_PIPE_DIAMETER = 12.5;

// actual is 15.19
WIDE_PIPE_DIAMETER = 16;

// actual is 19.26mm
MOUNT_INTERNAL_DIAMETER = 19;

MOUNT_OUTER_DIAMETER = 24.46;

UPPER_MOUNT_HEIGHT = 24.53;
LOWER_MOUNT_HEIGHT = 18.39;

SUPPORT_BAR_HEIGHT = 1;
SUPPORT_BAR_WIDTH = 1;

SUPPORT_FLANGE_THICKNESS = 2;

DELTA = 0.001;

// all measurements in mm

module lower_spacer() {
    cube([MOUNT_INTERNAL_DIAMETER, SUPPORT_BAR_WIDTH, SUPPORT_BAR_HEIGHT]);
    translate([MOUNT_INTERNAL_DIAMETER/2 + SUPPORT_BAR_WIDTH/2, -MOUNT_INTERNAL_DIAMETER/2 + SUPPORT_BAR_WIDTH/2 , 0]) {
        rotate([0,0,90]) {
            cube([MOUNT_INTERNAL_DIAMETER, SUPPORT_BAR_WIDTH, SUPPORT_BAR_HEIGHT]);
        }
    }

    translate([MOUNT_INTERNAL_DIAMETER/2, SUPPORT_BAR_WIDTH/2, SUPPORT_BAR_HEIGHT]) {
        difference() {
            cylinder(h = LOWER_MOUNT_HEIGHT - SUPPORT_BAR_HEIGHT, d = MOUNT_INTERNAL_DIAMETER);
            translate([0, 0, -DELTA]) {
                cylinder(h = LOWER_MOUNT_HEIGHT, d = NARROW_PIPE_DIAMETER);
            }
        }
    }
}

module upper_spacer() {
    difference() {
        union() {
            cylinder(h = SUPPORT_FLANGE_THICKNESS, d = MOUNT_OUTER_DIAMETER);
            translate([0, 0, SUPPORT_FLANGE_THICKNESS]) {
                cylinder(h = UPPER_MOUNT_HEIGHT, d = MOUNT_INTERNAL_DIAMETER);
            }
        }
        translate([0, 0, -25]) {
            cylinder(h = 100, d = WIDE_PIPE_DIAMETER);
        }
    }
}


lower_spacer();
// upper_spacer();