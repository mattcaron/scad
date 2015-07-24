// Dimensions are on mm

// There should be this much additional space to allow for
// some slop in the fit. This is per side.
gap = 6;

// Avoid surface overlap
delta = .1;

// Fragment count. Use this many fragments to make a circle.
$fn = 360;

// We want it to hold a cup this big and it should come about halfway
// up the cup.
cup_diameter = 80;
cup_height = 130;

// The thing on which the clip rests.
wood_thickness = 23.8;
wood_height=77.3;

// Cupholder dimensions
cupholder_wall_thickness = 5;
cupholder_bottom_thickness = 10;
cupholder_diameter = cup_diameter + gap;
// We derive height below...

// Derived values
cupholder_radius = cupholder_diameter / 2;

// The clip dimensions.
clip_wall_thickness = cupholder_wall_thickness;
clip_x = wood_thickness + (cupholder_wall_thickness * 2) + gap;
clip_y = cupholder_radius;
clip_z = wood_height + clip_wall_thickness;

// Area removed from the clip.
clip_cutout_x = wood_thickness + gap;
clip_cutout_y = clip_y + delta;
clip_cutout_z = wood_height;

cupholder_height = clip_z;

union() {
    difference() {
        cylinder(h=cupholder_height,
                 r=cupholder_radius + cupholder_wall_thickness);
        translate([0, 0, cupholder_bottom_thickness]) {
            cylinder(h=cupholder_height, r=cupholder_radius);
        }
    }
    difference() {
        // Note that the clip is centered, so this is all relative to
        // the center of the clip, not the bottom.
        translate([cupholder_radius + (clip_x / 2),
                   0,
                   clip_z - (cupholder_height / 2)]) {
            cube([clip_x, clip_y, clip_z], center = true);
        }
        translate([cupholder_radius + clip_x / 2,
                   0,
                   clip_z -
                   (cupholder_height / 2) -
                   clip_wall_thickness]) {
            cube([clip_cutout_x, clip_cutout_y, clip_cutout_z],
                 center = true);
        }
    }
}
