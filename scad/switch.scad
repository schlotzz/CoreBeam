// CoreBeam Laser Engraver
//
// Licence: CC BY-SA 3.0, http://creativecommons.org/licenses/by-sa/3.0/
// Author: Dominik Scholz <schlotzz@schlotzz.com>
// visit: http://www.schlotzz.com
//
// endstop switch


// include files
include <common.scad>;



// endstop switch cutout including holes for screws
module endstop_switch_cutout(cable_space = 0)
{
	width = 19.8;
	height = 10.6;
	depth = 6.4;

	// cut body
	translate([0, cable_space / 2, -depth / 2])
		cube([width, height + cable_space, depth], center = true);

	// mounting holes
	for (x = [-9.5 / 2, 9.5 / 2])
		translate([x, height / 2 - 2.9, -epsilon])
			cylinder(r = 2.35 / 2, h = 3, $fn = 8);

	// show body
	%translate([0, 0, -depth / 2])
		cube([width, height, depth], center = true);
}