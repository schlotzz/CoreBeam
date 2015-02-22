// CoreBeam Laser Engraver
//
// Licence: CC BY-SA 3.0, http://creativecommons.org/licenses/by-sa/3.0/
// Author: Dominik Scholz <schlotzz@schlotzz.com>
// visit: http://www.schlotzz.com
//
// corebeam label for electronics box


// include files
include <common.scad>;



// corebeam label
module corebeam_label()
{
	union()
	{
		color("yellow")
			linear_extrude(file = "../logo/corebeam-simplified-background.dxf", height = 1, center = false);
		color("black")
			linear_extrude(file = "../logo/corebeam-simplified-foreground.dxf", height = 2.25, center = false);
	}
}