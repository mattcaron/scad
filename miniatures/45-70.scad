// sizes are in mm, from wikipedia (both listed and drawing)

bullet_diameter = 13.0;
neck_diameter = 14.2;
shoulder_diameter = 18.1;
base_diameter = 20.4;
rim_diameter = 20.4;
rim_thickness = 2.1;
case_length = 99;
overall_length = 138;
case_length_before_shoulder=76.4;
neck_length=16.1;
// distance between bottom of cartridge to where the case begins
// to return to normal diameter
rim_recess=5.3;
recess_diameter=17.3;
// Estimated base thickness (not the rim, but the bottom of the
// interior cavity)
base_thickness = 2;
primer_diameter = 8;

$fn=100;

difference() {
    // Outside of the case
    union() {
        // Rim
        cylinder(h = rim_thickness, r = rim_diameter / 2);
        // Rebate
        cylinder(h = rim_recess, r = recess_diameter / 2);
        // Rebate -> main body transition
        translate([0, 0, rim_recess]) {
            cylinder(h = base_thickness,
                     r1 = recess_diameter / 2,
                     r2 = base_diameter / 2);
        }
        // Main case body
        translate([0, 0, rim_recess + base_thickness]) {
            cylinder(h = case_length_before_shoulder - 
                     rim_recess - base_thickness,
                     r = base_diameter / 2);
        }
        // Body -> neck transition
        translate([0, 0, case_length_before_shoulder]) {
            cylinder(h = case_length - 
                     case_length_before_shoulder - 
                     neck_length,
                     r1 = base_diameter / 2,
                     r2 = neck_diameter / 2);
        }
        // Neck
        translate([0, 0, case_length - neck_length]) {
            cylinder(h = neck_length, r = neck_diameter / 2);
        }
    }

    // Inside of the case.
    // This is a cavity the size of the bullet, so the neck is correct,     
    // but the interior volume won't be accuate (but who cares).
    translate([0, 0, rim_recess + base_thickness]) {
        cylinder(h = case_length, r = bullet_diameter / 2);
    }

    // Firing pin dimple
    translate([0, 0, -(rim_thickness / 2)]) {
        cylinder(h = rim_thickness, r1 = .5, r2 = .35);
    }

    // Primer "ring"
    translate([0, 0, -1]) {
        difference() {
            cylinder(h = 1.1, r = primer_diameter / 2);
            translate([0, 0, -1]) {
                cylinder(h = 2.5, r = (primer_diameter / 2) - .25);
            }
        }	
    }
}




