// CoreBeam Laser Engraver
//
// Licence: CC BY-SA 3.0, http://creativecommons.org/licenses/by-sa/3.0/
// Author: Dominik Scholz <schlotzz@schlotzz.com>
// visit: http://www.schlotzz.com
//
// laser metal case with cooling fins


// include files
include <common.scad>;



// laser metal casing with cooling fins
module laser_metal_case(extra_space = 0)
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