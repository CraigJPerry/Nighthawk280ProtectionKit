// EMAX Nighthawk 280 Arm End Protectors
// Craig J Perry, Started on 10th Jan 2016
//
// All dimensions are in mm.
//
// Although the arms have differences, these
// gloves are universal and will fit any arm.
//

// Increase resolution of hole circumferences
$fn = 60;

// Protection plate thickness
pp_thickness = 2;

// Pieces fail to intersect their full thickness sometimes so I
// oversize them to be sure
cut_extra = 2;


module Rectangle(x, y, translation=[0,0,0], thickness=pp_thickness, z_rotation=0)
{
    translate(translation) {
        translate([0,0, -cut_extra/2]) {
            rotate([0,0,z_rotation]) {
                cube([x, y, thickness+cut_extra]);
            }
        }
    }
}


module Hole(x, y, diameter=nut_diameter, thickness=pp_thickness)
{
    translate([x,y,0-cut_extra/2]) {
        cylinder(thickness+cut_extra, d=diameter);
    }
}


module Glove()
{
    
}


Glove();
