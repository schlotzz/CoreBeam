// CoreBeam Laser Engraver
//
// Licence: CC BY-SA 3.0, http://creativecommons.org/licenses/by-sa/3.0/
// Author: Dominik Scholz <schlotzz@schlotzz.com>
// visit: http://www.schlotzz.com
//
// y stage idler


// include files
include <common.scad>;
include <bearing.scad>;



// y stage
module y_stage()
{
	width = 70;
	height = 58;
	depth = 12;

	difference()
	{
		// main body
		translate([0, 0, depth / 2])
			roundedRectangle([width, height, depth], 3, $fn = 32);

		// lm8uu cutouts
		translate([23, 0, 0])
			bearing_cutout_lm8uu(2);

		// belt path
		translate([4, 0, 0])
			belt_path();

		// idler pulley cutouts
		for (i = [[-17, 90], [17, 0]])
			translate([-11, i[0], 0])
				rotate([0, 0, i[1]])
					bearing_cutout_623zz_pulley(epsilon);

		// smooth rods
		for (y = [-21, 21])
			translate([-width / 2 + 15, y, 6])
				rotate([0, -90, 0])
					cylinder(r = 4, h = 40, $fn = 64);

		// center cutout
		translate([-15.5, 0, depth / 2])
			roundedRectangle([30, 10, depth + 2 * epsilon], 3, $fn = 16);
	}
}