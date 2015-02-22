// CoreBeam Laser Engraver
//
// Licence: CC BY-SA 3.0, http://creativecommons.org/licenses/by-sa/3.0/
// Author: Dominik Scholz <schlotzz@schlotzz.com>
// visit: http://www.schlotzz.com
//
// top idler


// include files
include <common.scad>;
include <bearing.scad>;



// top stage
module top_stage()
{
	width = 70;
	height = 40;
	depth = 14;

	difference()
	{
		union()
		{
			// main body
			translate([0, 0, depth / 2])
				roundedRectangle([width, height, depth], 3, $fn = 32);

			// rod enforcement
			translate([23, height / 2 - 18, 15])
			{
				// rotate cylinder to align with sphere
				rotate([-90, 5.62, 0])
					cylinder(r = 7.5, h = 18, $fn = 32);
				sphere(r = 7.5, $fn = 32);
			}
		}

		// smooth rod mounting hole
		translate([23, height / 2 - 15, 15])
			rotate([-90, 0, 0])
				cylinder(r = 4, h = 15 + 2 * epsilon, $fn = 32);

		// idler pulley cutouts
		for (i = [0, 11])
			translate([-11 + i, 5.5 - i, 2])
				rotate([0, 0, 0])
					bearing_cutout_623zz_pulley(epsilon);

		// extra space for twisted belt
		for (y = [-0.5, -11.5])
			translate([-width / 4, y, 13.5])
				rotate([0, -90, 0])
					cylinder(r1 = 2, r2 = 4, h = width / 4 + epsilon, $fn = 32);

		// mounting holes
		translate([-width / 2 + 8, height / 2 - 8, 0])
			woodscrew_cutout();
		translate([width / 2 - 8, -height / 2 + 8, 0])
			woodscrew_cutout();
	}
}