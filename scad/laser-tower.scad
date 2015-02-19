// CoreBeam Laser Engraver
//
// Licence: CC BY-SA 3.0, http://creativecommons.org/licenses/by-sa/3.0/
// Author: Dominik Scholz <schlotzz@schlotzz.com>
// visit: http://www.schlotzz.com
//
// laser module tower


// include files
include <common.scad>;



// laser metal casing with cooling fins
module laser_metal_casing(extra_space = 0)
{
	h = 1.90;
	for (i = [1:10])
	{
		translate([0, 0, -i * 2 * h + h - epsilon - extra_space / 2])
			cylinder(r = 9, h = h + 2 * epsilon + extra_space, $fn = 32);
		translate([0, 0, -i * 2 * h])
			cylinder(r = 7.5, h = h, $fn = 32);
	}
}


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
		laser_metal_casing();
}


// laser module holder within tower
module laser_holder()
{
	width = 10;
	extra_width = -1.2 / 2;
	height = 10;
	radius = 10;
	depth = 18;
	extra_space = 0.6;

	difference()
	{
		// base
		translate([-15 + extra_space, -height / 2, 25 - depth - 2])
			cube([width, height, depth - epsilon]);

		// laser casing cutout
		translate([extra_width, 0, 25 - 2])
			laser_metal_casing(extra_space);

		// mounting holes
		for (z = [9, 19])
			translate([-15 - epsilon, 0, z])
				rotate([0, 90, 0])
					cylinder(r = m3_radius, h = 5, $fn = 16);
	}
}


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



//laser_end_cap();
//laser_tower();
rotate([90, 0, 0])
	laser_holder();