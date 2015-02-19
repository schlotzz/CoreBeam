// CoreBeam Laser Engraver
//
// Licence: CC BY-SA 3.0, http://creativecommons.org/licenses/by-sa/3.0/
// Author: Dominik Scholz <schlotzz@schlotzz.com>
// visit: http://www.schlotzz.com
//
// bottom idler


// include files
include <common.scad>;
include <switch.scad>;
include <stage-y.scad>;



// y stage
module bottom_stage(has_switch = false)
{
	width = 70;
	height = 58;
	depth = 14;
	motor_offset = 0.5;

	difference()
	{
	
		union()
		{
			// main body
			translate([0, 0, depth / 2])
				roundedRectangle([width, height, depth], 3, $fn = 32);

			// rod enforcement
			translate([23, -height / 2 + 18, 15])
			{
				// rotate cylinder to align with sphere
				rotate([90, 5.62, 0])
					cylinder(r = 7.5, h = 18, $fn = 32);
				sphere(r = 7.5, $fn = 32);
			}

			// nema17 mount
			translate([motor_offset, 7.85, 28 / 2])
				intersection()
				{
					cube([nema17_width, nema17_width, 17], center = true);
					cylinder(r = nema17_width / 2 + 7, 17, $fn = 64);
				}
		}

		// smooth rod mounting hole
		translate([23, -height / 2 + 15, 15])
			rotate([90, 0, 0])
				cylinder(r = 4, h = 15 + 2 * epsilon, $fn = 32);

		// nema17 holes
		translate([motor_offset, 7.85, -epsilon])
		union()
		{
			// mounting holes
			for (i = nema17_hole_offsets)
				translate(i)
				{
					cylinder(r = m3_wide_radius, h = 30, $fn = 16);
					cylinder(r = m3_head_radius, h = 7, $fn = 16);
				}

			// center cutout for pulley
			translate([0, 0, 4])
				%cylinder(r = 9 + 0.5, h = 16, $fn = 64);
			cylinder(r = 11 + 0.5, h = depth + 30, $fn = 64);

			// cutout for belt
			translate([-7.5, -50, 10])
				cube([15, 50, depth + 30]);
		}

		// mounting holes
		translate([width / 2 - 8, height / 2 - 8, 0])
			woodscrew_cutout();
		translate([-width / 2 + 8, height / 2 - 8, 0])
			woodscrew_cutout();
		translate([-width / 2 + 8, -4, 0])
			woodscrew_cutout();
	
		// limit switch
		if (has_switch)
		{
			translate([-width / 2 + 14, -(height - 19.8 / 2) / 2, depth - 6.4 + epsilon])
				rotate([0, 180, 0])
					endstop_switch_cutout(5);
		}

	}

}



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

bottom_stage_motor_shim();