// CoreBeam Laser Engraver
//
// Licence: CC BY-SA 3.0, http://creativecommons.org/licenses/by-sa/3.0/
// Author: Dominik Scholz <schlotzz@schlotzz.com>
// visit: http://www.schlotzz.com
//
// definitions of common values



// avoid openscad artefacts in preview
epsilon = 0.01;

// increase this if your slicer or printer make holes too tight
extra_radius = 0.1;

// major diameter of metric 3mm thread
m3_major = 2.85;
m3_radius = m3_major / 2 + extra_radius;
m3_wide_radius = m3_major / 2 + extra_radius + 0.2;
m3_small_radius = m3_radius - 0.1;

// diameter of metric 3mm hexnut screw head
m3_head_radius = 3 + extra_radius;

// nema 17 dimensions
nema17_width = 42.3;
nema17_hole_offsets = [
	[-15.5, -15.5, 0],
	[-15.5,  15.5, 0],
	[ 15.5, -15.5, 0],
	[ 15.5,  15.5, 0]
];


// hole for retaining a m3 hexnut
module m3_hexnut_cutout(additional_height = 0)
{
	cylinder(r = 3.15 + 2.5 * extra_radius, h = 2.5 + 3 * extra_radius + additional_height, $fn = 6);
}


// rounded rectangle
module roundedRectangle(size, radius)
{
	cube([size[0], size[1] - radius * 2, size[2]], true);
	cube([size[0] - radius * 2, size[1], size[2]], true);

	for (x = [-size[0] / 2 + radius, size[0] / 2 - radius])
		for (y = [-size[1] / 2 + radius, size[1] / 2 - radius])
			translate([x, y, 0])
				cylinder(size[2], radius, radius, true);
}


// rounded trapezoid
module roundedTrapezoid(size, radius, bottom)
{
	hull()
	{
		// bottom
		for (i = [[-bottom / 2 + radius, radius, 0], [bottom / 2 - radius, radius, 0]])
			translate(i)
				cylinder(r = radius, h = size[2], $fn = 32);

		// top
		for (i = [[-size[0] / 2 + radius, size[1] - radius, 0], [size[0] / 2 - radius, size[1] - radius, 0]])
			translate(i)
				cylinder(r = radius, h = size[2], $fn = 32);


	}

}


// hole for wood screw 4x15, countersunk head
module woodscrew_cutout()
{
	translate([0, 0, -epsilon])
		cylinder(r = 2.0, h = 3 + epsilon * 2, $fn = 16);

	translate([0, 0, 3])
		cylinder(r1 = 2.0, r2 = 4.2, h = 2.25, $fn = 16);

	translate([0, 0, 5.25 - epsilon])
		cylinder(r = 4.2, h = 30, $fn = 16);
}