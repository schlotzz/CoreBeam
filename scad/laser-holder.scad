// CoreBeam Laser Engraver
//
// Licence: CC BY-SA 3.0, http://creativecommons.org/licenses/by-sa/3.0/
// Author: Dominik Scholz <schlotzz@schlotzz.com>
// visit: http://www.schlotzz.com
//
// laser metal case holder


// include files
include <common.scad>;
include <laser-metal-case.scad>;



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
			laser_metal_case(extra_space);

		// mounting holes
		for (z = [9, 19])
			translate([-15 - epsilon, 0, z])
				rotate([0, 90, 0])
					cylinder(r = m3_radius, h = 5, $fn = 16);
	}
}