// CoreBeam Laser Engraver
//
// Licence: CC BY-SA 3.0, http://creativecommons.org/licenses/by-sa/3.0/
// Author: Dominik Scholz <schlotzz@schlotzz.com>
// visit: http://www.schlotzz.com
//
// laser module end cap


// include files
include <common.scad>;



// laser module end cap
module laser_end_cap()
{
	width = 32;
	height = 32;
	depth = 15;
	out_radius = 10;
	mounting_holes = [
		[-8, -20, 0],
		[-8,  20, 0],
		[ 8, -20, 0],
		[ 8,  20, 0]
	];

	difference()
	{
		union()
		{
			// main body
			intersection()
			{
				translate([0, 0, depth / 2])
					roundedRectangle([width, height, depth], 3, $fn = 32);
				cylinder(r1 = width * 0.75, r2 = out_radius + 2, h = depth, $fn = 64);
			}

			// mounting hole enforcements
			translate([-13, -20, 0])
				cube([26, 40, 3]);
			for (i = mounting_holes)
				translate(i)
					cylinder(r = m3_head_radius + 2, h = 3, $fn = 32);
		}

		// main cutout
		translate([0, 0, -epsilon])
			intersection()
			{
				translate([0, 0, depth / 2])
					roundedRectangle([30, 30, depth + 2 * epsilon], 3, $fn = 32);
				cylinder(r1 = width * 0.75 - 2, r2 = out_radius, h = depth, $fn = 64);
			}
		cylinder(r = out_radius, h = depth  + epsilon, $fn = 64);

		// mounting holes for tool
		for (i = mounting_holes)
		{
			translate(i - [0, 0, epsilon])
			{
				// screw cutout
				translate([0, 0, 0])
					cylinder(r = m3_wide_radius, h = depth * 2 + epsilon, $fn = 16);

				// head cutout
				translate([0, 0, 4])
					cylinder(r = m3_head_radius, h = depth * 2 + epsilon, $fn = 16);
			}
		}
	}
}