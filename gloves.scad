// EMAX Nighthawk 280 Leg Replacements (Gloves)
// Craig J Perry, Started on 31st Jan 2015
//
// All dimensions are in mm.
//
// These gloves clip onto the ends of the arms,
// or the "hands" - where the motors are mounted.
//
//         North
//       __________
//      |          |
//      | a      b |
// West |          | East
//      | d      c |
//      |          |
//      |         /
//       \       /
//    
//         South
//
//           Top
//        ___________
// Front |___________| Rear
//         ||   ||
//    
//           Back
//

$fn = 30;
function pythagoras(a,b) = sqrt(a*a + b*b);

west_to_east     =  34;
north_to_south   =  34;
top_to_bottom    =   4;
screw_cap_height =   3;
screw_cap_radius =   3;
hole_diameter    = 2.5;
west_to_a        =  10;
north_to_a       =   8;
west_to_b        =  22;
north_to_b       =   7;
west_to_c        =  21;
north_to_c       =  19;
west_to_d        =   9;
north_to_d       =  20;

glove_thickness = top_to_bottom + 2;

corner_to_centre = pythagoras(west_to_east/2, north_to_south/2);

module ScrewCapHole(west_offset, north_offset)
{
    translate([(-west_to_east/2)+west_offset+screw_cap_radius+0.5,(north_to_south/2)-north_offset-screw_cap_radius-0.5,-1])
    cylinder(h=screw_cap_height+3, r=screw_cap_radius+0.5);
}

module SphericalGlove()
{
    difference() {
        sphere(r=west_to_east/2);
        
        translate([0,0,-corner_to_centre/2])
        cube([corner_to_centre*2,corner_to_centre*2,corner_to_centre], center=true);
        
        ScrewCapHole(west_to_a, north_to_a);
        ScrewCapHole(west_to_b, north_to_b);
        ScrewCapHole(west_to_c, north_to_c);
        ScrewCapHole(west_to_d, north_to_d);
    }
}

SphericalGlove();


