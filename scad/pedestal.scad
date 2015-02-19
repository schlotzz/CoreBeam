// CoreBeam Laser Engraver
//
// Licence: CC BY-SA 3.0, http://creativecommons.org/licenses/by-sa/3.0/
// Author: Dominik Scholz <schlotzz@schlotzz.com>
// visit: http://www.schlotzz.com
//
// pedestal


// include files
include <common.scad>;



// pedestal for wooden frame
module pedestal()
{
	width = 40;
	height = 65;
	bottom_width = 20;
	depth = 40;
	radius = 5;
	thickness = 5;

	difference()
	{
		// base
		roundedTrapezoid([width, height, depth], radius, bottom_width);

		// middle cutout
		translate([0, thickness, -epsilon])
			roundedTrapezoid([width - thickness * 2, height - thickness * 2, depth + 2 * epsilon], radius / 2, bottom_width - 2 * thickness);
		
		// side cutout
		translate([0, height / 2, depth / 2])
			rotate([0, 90, 0])
				cylinder(r = (depth - thickness * 3) / 2, h = width + 2 * epsilon, center = true, $fn = 64);

		// mounting holes for wood screws
		for (i = [-10, 10])
			translate([0, height, depth / 2 + i])
			rotate([90, 0, 0])
				woodscrew_cutout();
	}

}

pedestal();