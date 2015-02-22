// CoreBeam Laser Engraver
//
// Licence: CC BY-SA 3.0, http://creativecommons.org/licenses/by-sa/3.0/
// Author: Dominik Scholz <schlotzz@schlotzz.com>
// visit: http://www.schlotzz.com
//
// electronics case lid


// include files
include <common.scad>;



// lid for electronics box
module electronics_box_lid()
{
	width = 130;
	height = 58;
	depth = 7;
	lid_depth = 1;
	lid_thickness = 3;
	thickness = 2;
	distance = .25;
	top_lid_holes = [
		[-width / 2 + 3, -height / 2 + 3, 0],
		[-width / 2 + 3,  height / 2 - 3, 0],
		[ width / 2 - 3, -height / 2 + 3, 0],
		[ width / 2 - 3,  height / 2 - 3, 0]
	];
	cable_outlet_dia = 7;

	difference()
	{
		union()
		{
			difference()
			{
				union()
				{
					// main body
					translate([0, 0, depth / 2])
						roundedRectangle([width, height, depth], 3, $fn = 32);
	
					// border
					translate([0, 0, depth + lid_depth / 2])
						roundedRectangle(
							[width - 2 * (thickness + distance), height - 2 * (thickness + distance), lid_depth],
							3,
							$fn = 32
						);
				}
	
				// main cutout
				translate([0, 0, lid_thickness + depth / 2 + epsilon])
					roundedRectangle([width - 4 * thickness, height - 4 * thickness, depth + lid_depth], 3, $fn = 32);
			}

			// enforcement for lid holes
			intersection()
			{
				union()
				{
					for (i = top_lid_holes)
						translate(i + [0, 0, -epsilon])
							cylinder(r1 = m3_head_radius + 2, r2 = 2.9, h = 8, $fn = 32);
				}

				translate([0, 0, depth / 2])
					roundedRectangle([width, height, depth], 3, $fn = 32);
			}

		}

		// top lid mounting holes
		for (i = top_lid_holes)
		{
			translate(i + [0, 0, -epsilon])
				cylinder(r = m3_radius, h = depth + lid_depth + 2 * epsilon, $fn = 32);
			translate(i + [0, 0, depth])
				cylinder(r = 5, h = 1 + epsilon, $fn = 32);
			//translate(i + [0, 0, -epsilon])
			//	cylinder(r = m3_head_radius, h = 5, $fn = 32);
		}


		// cable outlet
		translate([0, 0, depth + lid_depth / 2 + epsilon])
			cube([width + 2 * epsilon, cable_outlet_dia, lid_depth + epsilon], center = true);
	}
}