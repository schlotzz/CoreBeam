// CoreBeam Laser Engraver
//
// Licence: CC BY-SA 3.0, http://creativecommons.org/licenses/by-sa/3.0/
// Author: Dominik Scholz <schlotzz@schlotzz.com>
// visit: http://www.schlotzz.com
//
// GT2 belt cutout


// include files
include <common.scad>;



// belt clamps for GT2
module gt2_belt_cutout(length = 16, depth = 8)
{
	clearance = 0.125;

	union()
	{
	
		// belt cutout
		for (x = [-3 + clearance, 3 - clearance])
		{
			translate([x, 0, depth / 2])
				cube([1 - clearance, length, depth], center = true);
			translate([x, 0, depth - 1 + epsilon])
				rotate([0, 45, 0])
					cube([2 + clearance / 2, length, 2 + clearance / 2], center = true);
		}
	
		// tooth cutout
		for (x = [-3 + 0.30 + clearance, 3 - 0.30 - clearance])
		{
			for (y = [-length / 4 : length / 4])
				translate([x, y * 2, 0 - 0.001])
					cylinder(r = 0.7, h = depth, $fn = 8);
		}

		// turn cutout
		translate([0, -length / 2 + epsilon, 0])
		{
			difference()
			{
				union()
				{
					cylinder(r = 3.2 + clearance, h = depth, $fn = 16);
					translate([0, 0, depth - 2])
						cylinder(r1 = 3.2 + clearance, r2 = 4.2 + clearance, h = 1, $fn = 16);
				}
				translate([-4.2 - clearance, 0, 0])
					cube([8.4 + clearance * 2, 4.2 + clearance, depth]);
			}
		}

	}
}