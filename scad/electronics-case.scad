// CoreBeam Laser Engraver
//
// Licence: CC BY-SA 3.0, http://creativecommons.org/licenses/by-sa/3.0/
// Author: Dominik Scholz <schlotzz@schlotzz.com>
// visit: http://www.schlotzz.com
//
// electronics case


// include files
include <common.scad>;



// electronics box
module electronics_box()
{
	width = 130;
	height = 58;
	depth = 45;
	thickness = 2;
	arduino_offset = [width / 2 - 3.75, 53.3 / 2, 0];
	arduino_uno_holes = [
		[14.0,  2.5, 0],
		[15.3, 50.7, 0],
		[66.1,  7.6, 0],
		[66.1, 35.5, 0]
	];
	arduino_nose_height = 6;
	mosfet_board_holder = [
		[width / 2 - 80,       -height / 2, 0],
		[width / 2 - 80 - 3.5, -height / 2, 0],
		[width / 2 - 80,        height / 2 - thickness - 2, 0],
		[width / 2 - 80 - 3.5,  height / 2 - thickness - 2, 0]
	];
	current_control_board = [width / 2 - 110, -height / 2, 0];
	cable_outlet_dia = 7;
	top_lid_holes = [
		[-width / 2 + 3, -height / 2 + 3, depth - 10],
		[-width / 2 + 3,  height / 2 - 3, depth - 10],
		[ width / 2 - 3, -height / 2 + 3, depth - 10],
		[ width / 2 - 3,  height / 2 - 3, depth - 10]
	];
	mounting_holes = [
		[-width / 2 + 8, -height / 2 + 8, 0],
		[-width / 2 + 8,  height / 2 - 8, 0],
		[ width / 2 - 8, -height / 2 + 8, 0],
		[ width / 2 - 8,  height / 2 - 8, 0],
	];

	difference()
	{
		union()
		{
			difference()
			{
				// main body
				translate([0, 0, depth / 2])
					roundedRectangle([width, height, depth], 3, $fn = 32);

				// main cutout
				translate([0, 0, depth / 2 + thickness])
					roundedRectangle([width - 2 * thickness, height - 2 * thickness, depth], 3, $fn = 32);
			}

			// arduino mounting noses
			translate(arduino_offset + [-thickness, 0, thickness - epsilon])
				rotate([0, 0, 180])
					for (i = arduino_uno_holes)
						translate(i)
							cylinder(r = m3_small_radius + 1, h = arduino_nose_height, $fn = 16);

			// top lid mounting enforcements
			for (i = top_lid_holes)
				translate(i)
					cylinder(r1 = 1, r2 = 3, h = 10, $fn = 32);

			// mosfet board holder
			for (i = mosfet_board_holder)
				translate(i)
					cube([2, thickness + 2, depth - 6]);

			// current control board holder
			translate(current_control_board)
				cube([2, height, depth - 6]);

			// mounting holes enforcement
			for (i = mounting_holes)
				translate(i)
					cylinder(r = 5.9, h = thickness + 1, $fn = 32);
		}

		// arduino uno mounting holes
		translate(arduino_offset + [-thickness, 0, -epsilon])
			rotate([0, 0, 180])
				for (i = arduino_uno_holes)
					translate(i)
						cylinder(r = m3_small_radius, h = thickness + arduino_nose_height * 2 + epsilon, $fn = 16);

		// top lid mounting holes
		for (i = top_lid_holes)
			translate(i + [0, 0, 5 + epsilon])
				cylinder(r = m3_small_radius, h = 5, $fn = 32);

		// usb cutout
		translate([width / 2 - thickness - epsilon, -18.4, 1 + arduino_nose_height + thickness])
			cube([thickness + 2 * epsilon, 13, 12]);

		// cable outlet
		translate([0, 0, depth])
			rotate([0, 90, 0])
				cylinder(r = cable_outlet_dia / 2, h = width + 2 * epsilon, center = true, $fn = 32);

		// mounting holes
		for (i = mounting_holes)
			translate(i - [0, 0, 2])
				woodscrew_cutout();

	}

	%translate([width / 2 - 30 - thickness, 34.9, 31.7 + arduino_nose_height + thickness])
		rotate([0, 0, 90])
			import("../stl/arduino-uno.stl");
}