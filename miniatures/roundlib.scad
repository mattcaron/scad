use <BezierCone.scad>

// This is not super accurate for anything past where it's seated into
// the cartridge, because we don't care.
// It also doesn't suppor any type of flat-nosed spitzer
// bullet. Again, we don't care.
module makeSpitzerBullet(bullet_diameter, base_length, ogive_length)
{
    union() {
        cylinder(h = base_length, r = bullet_diameter / 2);
        translate([0, 0, base_length]) {
            BezCone(d = bullet_diameter, h = ogive_length, curve=3);
        }
    }
}

module makeRound(bullet_diameter, neck_diameter, shoulder_diameter,
                 base_diameter, rim_diameter, rim_thickness, case_length,
                 overall_length, case_length_before_shoulder, neck_length,
                 rim_recess, recess_diameter, base_thickness, primer_diameter,
                 straight_part, isLoaded)
{
    difference() {
        // Outside of the case
        union() {
            // Rim
            cylinder(h = rim_thickness, r = rim_diameter / 2);

            // Check for extractor groove
            if (rim_recess > 0 && recess_diameter > 0) {
                // Extractor groove
                cylinder(h = rim_recess, r = recess_diameter / 2);

                // Extractor groove -> main body transition.
                // This angle is estimated that it flares out as much
                // as the rim.
                translate([0, 0, rim_recess]) {
                    cylinder(h = base_thickness,
                             r1 = recess_diameter / 2,
                             r2 = base_diameter / 2);
                }
            }

            if (case_length_before_shoulder > 0 ) {
                // Main case body - bottlenecked case
                translate([0, 0, rim_recess + base_thickness]) {
                    cylinder(h = case_length_before_shoulder -
                             rim_recess - base_thickness,
                             r = base_diameter / 2);
                }
            }
            else {
                // Main case body - straight walled case
                translate([0, 0, rim_recess + base_thickness]) {
                    cylinder(h = case_length - rim_recess - base_thickness,
                             r = base_diameter / 2);
                }
            }

            // Check for a bottlenecked case
            if (shoulder_diameter > 0 && case_length_before_shoulder > 0 &&
                neck_length > 0) {

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

            // Optional bullet
            // A straight part followed by a taper, with a rounded tip.
            if (isLoaded == 1) {
                translate([0, 0, case_length - straight_part]) {
                    makeSpitzerBullet(bullet_diameter, straight_part,
                                      overall_length - case_length);
                }
            }	
        }
	
        if (isLoaded == 0) {
            // Inside of the case.
            // This is a cavity the size of the bullet, so the neck
            // is correct, but the interior volume won't be accuate
            // (but who cares).
            translate([0, 0, rim_recess + base_thickness]) {
                cylinder(h = case_length, r = bullet_diameter / 2);
            }
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
}

module 50bmg(isLoaded)
{
    // sizes are in mm, from wikipedia (both listed and drawing)
    // http://en.wikipedia.org/wiki/.50_BMG
    bullet_diameter = 13.0;
    neck_diameter = 14.2;
    shoulder_diameter = 18.1;
    base_diameter = 20.4;
    rim_diameter = 20.4;
    rim_thickness = 2.1;
    case_length = 99;
    overall_length = 138;
    case_length_before_shoulder = 76.4;
    neck_length = 16.1;
    // distance between bottom of cartridge to where the case begins
    // to return to normal diameter
    rim_recess = 5.3;
    recess_diameter = 17.3;
    // Estimated base thickness (not the rim, but the bottom of the
    // interior cavity)
    base_thickness = 2;
    // Large primers are approximately 5.4mm.
    primer_diameter = 5.4;

    // Straight part of bullet before it starts to taper
    straight_part = (overall_length - case_length) / 4;

    makeRound(bullet_diameter, neck_diameter, shoulder_diameter, base_diameter,
              rim_diameter, rim_thickness, case_length, overall_length,
              case_length_before_shoulder, neck_length, rim_recess,
              recess_diameter, base_thickness, primer_diameter, straight_part,
              isLoaded);
}

module 45_70(isLoaded)
{
    // sizes are in mm, from wikipedia:
    // http://en.wikipedia.org/wiki/.45-70
    bullet_diameter = 11.6;
    neck_diameter = 12.2;
    shoulder_diameter = 0;
    base_diameter = 12.8;
    rim_diameter = 15.4;
    rim_thickness = 1.8;
    case_length = 53.5;
    overall_length = 64.8;
    case_length_before_shoulder = 0;
    neck_length = 0;
    // distance between bottom of cartridge to where the case begins
    // to return to normal diameter
    rim_recess = 0;
    recess_diameter = 0;
    // Estimated base thickness (not the rim, but the bottom of the
    // interior cavity)
    base_thickness = 2;
    // Large primers are approximately 5.4mm.
    primer_diameter = 5.4;

    // Straight part of bullet before it starts to taper
    straight_part = (overall_length - case_length) / 4;

    makeRound(bullet_diameter, neck_diameter, shoulder_diameter, base_diameter,
              rim_diameter, rim_thickness, case_length, overall_length,
              case_length_before_shoulder, neck_length, rim_recess,
              recess_diameter, base_thickness, primer_diameter, straight_part,
              isLoaded);
}
