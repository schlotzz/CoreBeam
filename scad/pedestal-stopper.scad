// CoreBeam Laser Engraver
//
// Licence: CC BY-SA 3.0, http://creativecommons.org/licenses/by-sa/3.0/
// Author: Dominik Scholz <schlotzz@schlotzz.com>
// visit: http://www.schlotzz.com
//
// footplate-stopper for pedestal


// include files
include <common.scad>;
include <pedestal.scad>;



// stopper for pedestal
module pedestal_stopper(flip = false)
{
    
    pedestal_width = 40;
    pedestal_depth = 40;
    pedestal_height = 65;
    pedestal_bottom_width = 20;
    pedestal_radius = 5;
    
    top_thickness = 13;
    side_thickness = 6;
	width = 40;
    depth = top_thickness + pedestal_radius;
	height = 10;
    
    mirror([flip ? 1 : 0, 0, 0])
    {
        difference()
        {
            
            // base with rounded corner
            union()
            {
                translate([-side_thickness + 3, 0, 0])
                    cube([width + side_thickness - 3, depth, height]);
                translate([-side_thickness, 0, 0])
                    cube([3, depth - 3, height]);
                translate([-side_thickness + 3, depth - 3, 0])
                    cylinder(r = 3, h = height, $fn = 32);
            }

            
            // pedestal cutout
            translate([0, -pedestal_bottom_width / 2 + pedestal_radius, -0.5])
                rotate([90, 0, 90])
                    roundedTrapezoid(
                        [pedestal_width, pedestal_height, pedestal_depth + epsilon],
                        pedestal_radius,
                        pedestal_bottom_width
                    );

            // mounting holes for wood screws
            for (x = [-side_thickness + 10, width - 10])
                translate([x, depth - 6, 0])
                    woodscrew_cutout();
            
        }
        

        // pedestal
        %translate([0, -pedestal_bottom_width / 2 + pedestal_radius, 0])
            rotate([90, 0, 90])
                pedestal();
    }
    
}