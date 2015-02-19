// CoreBeam Laser Engraver
//
// Licence: CC BY-SA 3.0, http://creativecommons.org/licenses/by-sa/3.0/
// Author: Dominik Scholz <schlotzz@schlotzz.com>
// visit: http://www.schlotzz.com
//
// cable mount


// include files
include <common.scad>;



// cable mount for holding stepper motor cables on wooden frame
module cable_mount()
{
	depth = 10;
	height = 5;
	radius = 7 / 2;
	thickness = 4;
	wings = 9;

	difference()
	{
		// base
		union()
		{
			intersection()
			{
				translate([0, radius, 0])
					cylinder(r = radius + thickness, h = depth, $fn = 64);
				translate([-radius - thickness, 0, 0])
					cube([2 * radius + 2 * thickness, 2 * radius + thickness, depth]);
			}
			translate([-radius - thickness - wings, 0, 0])
				cube([2 * radius + 2 * thickness + 2 * wings, height, depth]);
		}
	
		// cable cutout
		translate([0, radius, -epsilon])
			cylinder(r = radius, h = depth + 2 * epsilon, $fn = 32);
		translate([-radius, -epsilon, -epsilon])
			cube([radius * 2, radius + epsilon, depth + 2 * epsilon]);

		// mounting holes
		for (i = [-radius - thickness - wings + 5, radius + thickness + wings - 5])
		translate([i, 0, depth / 2])
			rotate([-90, 0, 0])
				woodscrew_cutout();
	}


}

cable_mount();