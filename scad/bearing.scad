// CoreBeam Laser Engraver
//
// Licence: CC BY-SA 3.0, http://creativecommons.org/licenses/by-sa/3.0/
// Author: Dominik Scholz <schlotzz@schlotzz.com>
// visit: http://www.schlotzz.com
//
// several bearings and holders


// include files
include <common.scad>;



// lm8uu bearing
module bearing_lm8uu(bearings)
{
	bearing_diameter = 15;
	bearing_length = 24 + .1;

	rotate([90, 0, 0])
		difference()
		{
			cylinder(r = bearing_diameter / 2, h = bearing_length * bearings, $fn = 32, center = true);
			cylinder(r = 8 / 2, h = bearing_length * bearings + 2 * epsilon, $fn = 16, center = true);
		}
}

// cutouts for lm8uu linear bearing with zipties
// Author: Dominik Scholz <schlotzz@schlotzz.com>
// original author: Josef Průša <iam@josefprusa.cz> and contributors
module bearing_cutout_lm8uu(bearings = 1)
{
	// dimensions
	bearing_diameter = 15;
	bearing_length = 24 + .1;
	cutter_length = 10 + bearings * bearing_length;
	one_holder_length = 8 + bearing_length;
	holder_length = 8 + bearings * bearing_length;
 
	// main bearing cut
	difference()
	{
		translate([0, 0, 12 + 1.5])
			rotate([90, 0, 0])
				translate([0, 0, -cutter_length / 2])
					cylinder(h = cutter_length, r = bearing_diameter / 2, $fn = 50);

		// bearing retainers
		translate([0, 1 - holder_length / 2, 3 + 1.5])
			cube([24, 6, 8], center = true);
		translate([0, -1 + holder_length / 2, 3 + 1.5])
			cube([24, 6, 8], center = true);
	}
 
	// ziptie cutouts
	for (i = [0 : bearings - 1])
	{
		translate([0, -holder_length / 2, 0])
		{
			translate([0, one_holder_length / 2 + i * 25,0])
			{
				difference()
				{
					union()
					{
						translate([0, 2 - 6, 12])
							rotate([90, 0, 0])
								cylinder(h = 4, r = 12.5, $fn = 50);
						translate([0, 2 + 6, 12])
							rotate([90, 0, 0])
								cylinder(h = 4, r = 12.5, $fn = 50);
  					}
					
					translate([0, 10, 12])
						rotate([90, 0, 0])
							cylinder(h = 24, r = 10, $fn = 50);
				}
			}
		}
	}

	// show bearing
	%translate([0, 0, 13])
		bearing_lm8uu(bearings);
 
}



// cutouts for lm8uu linear bearing
module bearing_cutout_lm8uu_simple(bearings = 1)
{
	// dimensions
	bearing_diameter = 15;
	bearing_length = 24 + .5;
	cutter_length = bearing_length * bearings;
 
	// main bearing cut
	rotate([90, 0, 0])
		cylinder(h = cutter_length, r = bearing_diameter / 2, center = true, $fn = 50);
 
	// show bearing
	%bearing_lm8uu(bearings);
}


// 2x623zz flanged bearing (3x10x4mm) as belt idler pulley
module bearing_623zz_pulley()
{
	// dimensions
	bearing_inner_diameter = 10;
	bearing_outer_diameter = 11.5;
	bearing_inner_height = 3;
	bearing_outer_height = 1;
	bearing_height = bearing_inner_height + bearing_outer_height;
	bearing_hole_diameter = 3;

	difference()
	{
		union()
		{
			// inner cylinder
			cylinder(r = bearing_inner_diameter / 2, h = bearing_height * 2, $fn = 32);
			
			// flanges
			for (z = [0, bearing_height * 2 - bearing_outer_height])
				translate([0, 0, z])
					cylinder(r = bearing_outer_diameter / 2, h = bearing_outer_height, $fn = 32);
		}

		// inner mounting hole
		translate([0, 0, -epsilon])
			cylinder(r = bearing_hole_diameter / 2, h = bearing_height * 2 + epsilon * 2, $fn = 16);
	}

}


// cutout for 623zz bearing pulley including belt path
module bearing_cutout_623zz_pulley()
{
	bearing_outer_diameter = 11.5 + 4.5;
	bearing_inner_height = 3;
	bearing_outer_height = 1;
	bearing_height = bearing_inner_height + bearing_outer_height;
	bearing_hole_diameter = 3;
	screw_length = 16;
	belt_width = 4;
	belt_length = 40;

	union()
	{
		// main body cutout
		translate([0, 0, screw_length - bearing_height * 2])
			cylinder(r = bearing_outer_diameter / 2, h = bearing_height * 2);
		
		// mounting hole for screw
		cylinder(r = m3_radius, h = screw_length, $fn = 16);

		// hexnut retaining hole
		translate([0, 0, -epsilon - 10])
			m3_hexnut_cutout(epsilon + 10);

		// belt path
		translate([bearing_outer_diameter / 2 - belt_width, 0, screw_length - bearing_height * 2])
			cube([belt_width, belt_length, bearing_height * 2]);
		translate([-belt_length, -bearing_outer_diameter / 2, screw_length - bearing_height * 2])
			cube([belt_length, belt_width, bearing_height * 2]);
	}

	// show idler pulleys
	%translate([0, 0, 8])
		bearing_623zz_pulley();

}


// belt path
module belt_path(length = 100)
{
	bearing_inner_height = 3;
	bearing_outer_height = 1;
	bearing_height = bearing_inner_height + bearing_outer_height;
	screw_length = 16;
	belt_width = 4;

	translate([0, -length / 2, screw_length - bearing_height * 2])
		cube([belt_width, length, bearing_height * 2]);
}