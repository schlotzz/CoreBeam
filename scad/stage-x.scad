// CoreBeam Laser Engraver
//
// Licence: CC BY-SA 3.0, http://creativecommons.org/licenses/by-sa/3.0/
// Author: Dominik Scholz <schlotzz@schlotzz.com>
// visit: http://www.schlotzz.com
//
// x stage idler


// include files
include <common.scad>;
include <bearing.scad>;
include <gt2-belt.scad>;
include <switch.scad>;



// x stage
module x_stage()
{
	width = 60;
	height = 90;
	depth = 11;

	difference()
	{
		// main body
		translate([0, 0, depth / 2 + 4])
			roundedRectangle([width, height, depth], 3, $fn = 32);

		// lm8uu cutouts
		for (x = [-21, 21])
			for (y = [-30, 30])
				translate([x, y, 6])
					bearing_cutout_lm8uu_simple(1);

		// smooth rods cutout
		for (x = [-21, 21])
			translate([x, 0 , 6])
				rotate([-90, 0, 0])
					cylinder(r = 5, h = height + 2 * epsilon, center = true, $fn = 32);

		// center cutout
		translate([0, 0, depth / 2 + 4])
			roundedRectangle([30, 30, depth + 2 * epsilon], 3, $fn = 16);

		// gt2 belt retaining slots
		for (x = [-8.5, 8.5])
		{
			translate([x, -height / 2 + 16 / 2 - epsilon, 9 + epsilon])
				rotate([0, 0, 180])
					gt2_belt_cutout(length = 16, depth = 7);
			translate([x, height / 2 - 16 / 2 - epsilon, 9 + epsilon])
				rotate([0, 0, 0])
					gt2_belt_cutout(length = 16, depth = 7);
		}

		// large limit switch
		translate([0, -height / 2 + 10.6 / 2 - epsilon, 5 - epsilon])
			endstop_switch_cutout();

		// cable outlet for switch
		translate([0, -height / 2 + 15, 0])
			cylinder(r = 2, h = height, $fn = 16);

		// mounting holes for tool
		for (x = [-8, 8])
			for (y = [-20, 20])
				translate([x, y, 2])
					cylinder(r = m3_radius, h = depth * 2, $fn = 16);
	}
}