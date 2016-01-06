// EMAX Nighthawk 280 Lower Protection Plate
// Craig J Perry, Started on 30th Dec 2015
//
// The board is a rectangle, 85mm wide x 141mm
// tall, with right angle triangles (a, b, d,
// e, f, h, i, j, l, m) and rectangles (c, g,
// k) cut out. There are holes drilled at o,
// p, q, r, s, t & u.
//
//          e /\f   g   h/\ i
//           /  \-------/  \
//          /  r         s  \
//          \ u           t /
//          d\             /j
//            |           |
//            |           |
//          c |           | k
//            |           |
//          b/             \l
//          /               \
//          \  q         p  /
//          a\  n       o  /m
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

// Increase resolution of hole circumferences
$fn = 60;

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

// Holes
nut_diameter = 6 + 2;
n_x = 14;
n_y = 15;
o_x = 71;
o_y = 15;
p_x = 78;
p_y = 30;
q_x = 7;
q_y = 30;
r_x = 14;
r_y = 132;
s_x = 71;
s_y = 132;
t_x = 7;
t_y = 117;
u_x = 78;
u_y = 117;

// Power distribution board
pdb_width       = e_adj + f_adj + g_w + h_adj + i_adj;
pdb_length      = a_opp + b_opp + c_len + d_opp + e_opp;

// Sometimes rotated pieces fail to intersect their full thickness
workaround_thickness = 2;
workaround_offset = 1;


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


module Hole(x, y, diameter=nut_diameter, thickness=pp_thickness)
{
    translate([x,y,0]) {
        cylinder(thickness, d=diameter);
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
        
        // c
        Rectangle(c_w, c_len, translation=[0,a_opp+b_opp,0]);
        
        // d
        RightAngleTriangle(d_opp, d_adj, translation=[0,a_opp+b_opp+c_len,0]);
        
        // e
        RightAngleTriangle(e_opp, e_adj, rotation=[180,0,0], translation=[0,pdb_length,pp_thickness]);
        
        // f
        RightAngleTriangle(f_opp, f_adj, rotation=[0,0,180], translation=[e_adj+f_adj,pdb_length,0]);
        
        // g
        Rectangle(g_w, g_len, translation=[e_adj+f_adj,pdb_length-g_len,0]);
        
        // h
        RightAngleTriangle(h_opp, h_adj, rotation=[180,0,0], translation=[e_adj+f_adj+g_w,pdb_length,pp_thickness]);
        
        // i
        RightAngleTriangle(i_opp, i_adj, rotation=[0,0,180], translation=[pdb_width,pdb_length,0]);
        
        // j
        RightAngleTriangle(j_opp, j_adj, pp_thickness+workaround_thickness, rotation=[0,180,0], translation=[pdb_width,a_opp+b_opp+c_len,pp_thickness+workaround_offset]);
        
        // k
        Rectangle(k_w, k_len, translation=[pdb_width-k_w,a_opp+b_opp,0]);
        
        // l
        RightAngleTriangle(l_opp, l_adj, rotation=[0,0,180], translation=[pdb_width,a_opp+b_opp,0]);
        
        // m
        RightAngleTriangle(32, 15, pp_thickness+workaround_thickness, rotation=[0,180,0], translation=[pdb_width,0,pp_thickness+workaround_offset]);
        
        // n
        Hole(n_x, n_y);
        
        // o
        Hole(o_x, o_y);
        
        // p
        Hole(p_x, p_y);
        
        // q
        Hole(q_x, q_y);
        
        // r
        Hole(r_x, r_y);
        
        // s
        Hole(s_x, s_y);
        
        // t
        #Hole(t_x, t_y);
        
        // u
        Hole(u_x, u_y);
    }
}

BottomPlate();

