// CoreBeam Laser Engraver
//
// Licence: CC BY-SA 3.0, http://creativecommons.org/licenses/by-sa/3.0/
// Author: Dominik Scholz <schlotzz@schlotzz.com>
// visit: http://www.schlotzz.com
//
// laser module tower


// include files
include <common.scad>;
include <laser-metal-case.scad>;



// laser tower
module laser_tower()
{
	width = 40;
	height = 40;
	depth = 25;
	fan_holes = [
		[-16, -16, 0],
		[-16,  16, 0],
		[ 16, -16, 0],
		[ 16,  16, 0]
	];
	mounting_holes = [
		[-8, -20, 0],
		[-8,  20, 0],
		[ 8, -20, 0],
		[ 8,  20, 0]
	];
	cable_cutout_width = 3;
	cable_cutout_depth = 2;

	difference()
	{
	
		union()
		{
			// main body
			translate([0, 0, depth / 2])
				roundedRectangle([width, height, depth], 3, $fn = 32);

			// mounting hole enforcements
			for (i = mounting_holes)
				translate(i)
					cylinder(r = m3_head_radius + 2, h = 3, $fn = 32);
		}

		// main cutout
		translate([0, 0, depth / 2])
			roundedRectangle([30, 30, depth + 2 * epsilon], 3, $fn = 32);

		// mounting holes for fan
		for (i = fan_holes)
			translate(i - [0, 0, -depth + 7])
				cylinder(r = m3_small_radius, h = 7 + epsilon, $fn = 16);

		// cable outlet
		translate([-cable_cutout_width / 2, 0, depth - cable_cutout_depth + epsilon])
			cube([cable_cutout_width, width, cable_cutout_depth + epsilon]);

		// mounting holes for laser casing
		for (z = [9, 19])
			translate([0, 0, z])
				rotate([0, 90, 0])
					cylinder(r = m3_radius, h = width + 2 * epsilon, center = true, $fn = 16);

		// mounting holes for tool
		for (i = mounting_holes)
		{
			translate(i - [0, 0, epsilon])
			{
				// screw cutout
				translate([0, 0, 0])
					cylinder(r = m3_wide_radius, h = depth * 2 + epsilon, $fn = 16);

				// head cutout
				translate([0, 0, 3])
					cylinder(r = m3_head_radius, h = depth * 2 + epsilon, $fn = 16);
			}
		}
	}

	// show laser casing
	%translate([0, 0, depth - 2])
		laser_metal_case();
}