// EMAX Nighthawk 280 Lower Protection Plate
// Craig J Perry, Started on 30th Dec 2015
//
// The board is a rectangle, 85mm wide x 141mm
// tall, with right angle triangles (a, b, d,
// e, f, h, i, j, l, m) and rectangles (c, g,
// k) cut out.
//
//          e /\f   g   h/\ i
//           /  \-------/  \
//          /               \
//          \               /
//          d\             /j
//            |           |
//            |           |
//          c |           | k
//            |           |
//          b/             \l
//          /               \
//          \               /
//          a\             /m
//            \___________/
//
//
// All dimensions are in mm.
//
// Triangles have opposite, adjacent and
// hypotenuse edges. In this drawing, all
// opposite edges run along the Y axis and
// adjacent edges along the X axis.
//
// Similarly, rectangles have width along
// the X axis and length along the Y axis.
//

// Protection plate
pp_thickness = 2;

// Cutouts
a_opp = 32;
a_adj = 15;
b_opp = 17;
b_adj = 13;
c_len = 50;
c_w   = 13;
d_opp = 17;
d_adj = 13;
e_opp = 25;
e_adj = 12;
f_opp = 4;
f_adj = 17;
g_len = 4;
g_w   = 27;
h_opp = 4;
h_adj = 17;
i_opp = 25;
i_adj = 12;
j_opp = 17;
j_adj = 13;
k_len = 50;
k_w   = 13;
l_opp = 17;
l_adj = 13;
m_opp = 32;
m_adj = 15;

// Power distribution board
pdb_width       = e_adj + f_adj + g_w + h_adj + i_adj;
pdb_length      = a_opp + b_opp + c_len + d_opp + e_opp;


module RightAngleTriangle(opposite, adjacent, thickness=pp_thickness, rotation=[0,0,0], translation=[0,0,0])
{
    translate(translation) {
        rotate(rotation) {
            linear_extrude(height=thickness) {
                polygon(
                    points=[[0,0],[adjacent,0],[0,opposite]],
                    paths=[[0,1,2]]
                );
            }
        }
    }
}


module Rectangle(length, width, thickness=pp_thickness, rotation=[0,0,0], translation=[0,0,0])
{
    translate(translation) {
        rotate(rotation) {
            cube([length, width, thickness]);
        }
    }
}


module BottomPlate()
{
    difference() {
        // Uncut base plate
        Rectangle(pdb_width, pdb_length);
        
        // a
        RightAngleTriangle(a_opp, a_adj);
        
        // b
        RightAngleTriangle(b_opp, b_adj, rotation=[180,0,0], translation=[0,a_opp+b_opp,pp_thickness]);
        
        // m
        RightAngleTriangle(32, 15, rotation=[0,180,0], translation=[pdb_width,0,pp_thickness]);
    }
}

BottomPlate();

