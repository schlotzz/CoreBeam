// CoreBeam Laser Engraver
//
// Licence: CC BY-SA 3.0, http://creativecommons.org/licenses/by-sa/3.0/
// Author: Dominik Scholz <schlotzz@schlotzz.com>
// visit: http://www.schlotzz.com
//
// bottom motor mount shim


// include files
include <common.scad>;



// motor shim
module bottom_stage_motor_shim()
{
	depth = 2;

	difference()
	{
	
		intersection()
		{
			translate([0, 0, depth / 2])
				cube([nema17_width, nema17_width, depth], center = true);
			cylinder(r = nema17_width / 2 + 7, h = depth, $fn = 64);
		}

		// nema17 holes
		translate([0, 0, -epsilon])
		union()
		{
			// mounting holes
			for (i = nema17_hole_offsets)
				translate(i)
					cylinder(r = m3_wide_radius, h = 30, $fn = 16);

			// center cutout for pulley
			cylinder(r = 11 + 0.5, h = depth + 2 * epsilon, $fn = 64);

			// cutout for belt
			//translate([-7.5, -50, 0])
			//	cube([15, 50, depth + 2 * epsilon]);
		}
	}
}