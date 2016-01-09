// EMAX Nighthawk 280 Lower Protection Plate
// Craig J Perry, Started on 30th Dec 2015
//
// All dimensions are in mm.
//
// The board is a rectangle, 85 wide x 141
// tall, with right angle triangles (a, b, d,
// e, f, h, i, j, l, m), rectangles (c, g,
// k) and holes (o, p, q, r, s, t, u) cut out.
//
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

// Increase resolution of hole circumferences
$fn = 60;

// Protection plate thickness
pp_thickness = 2;

// Pieces fail to intersect their full thickness sometimes so I
// oversize them to be sure
cut_extra = 2;

// Side plate height
sp_height = 15;

// Fillets
f_height = 2;
f_width  = 3;

// Cutouts
a_x = 15;
a_y = 32;
b_x = 14;
b_y = 17;
c_x = 14;
c_y = 50;
d_x = 14;
d_y = 17;
e_x = 12;
e_y = 25;
f_x = 17;
f_y = 4;
g_x = 27;
g_y = 4;
h_x = 17;
h_y = 4;
i_x = 12;
i_y = 25;
j_x = 14;
j_y = 17;
k_x = 14;
k_y = 50;
l_x = 14;
l_y = 17;
m_x = 15;
m_y = 32;

// Holes
nut_diameter = 6 + 2;
n_x = 14;
n_y = 16;
o_x = 71;
o_y = 16;
p_x = 77;
p_y = 30;
q_x = 8;
q_y = 30;
r_x = 14.5;
r_y = 133;
s_x = 70.5;
s_y = 133;
t_x = 7;
t_y = 119;
u_x = 78;
u_y = 119;

// Power distribution board
pdb_width       = e_x + f_x + g_x + h_x + i_x;
pdb_length      = a_y + b_y + c_y + d_y + e_y;


module RightAngleTriangle(x_len, y_len, translation=[0,0,0], thickness=pp_thickness)
{
    x_offset = sign(x_len);
    y_offset = sign(y_len);
    translate(translation) {
        translate([-x_offset, -y_offset, -cut_extra/2]) {    
            linear_extrude(height=thickness+cut_extra) {
                polygon(
                    points=[[0,0],[x_len+x_offset,0],[0,y_len+y_offset]],
                    paths=[[0,1,2]]
                );
            }
        }
    }
}


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


module NotchedWall(x, y, height=pp_thickness, translation=[0,0,0], z_rotation=0)
{
    translate(translation) {
        rotate([0,0,z_rotation]) {
            union() {
                cube([x, y, height]);
                translate([-f_width,0,pp_thickness])
                cube([f_width, y, f_height]);
                rotate([270,180,0])
                #RightAngleTriangle(1, 1, [0,pp_thickness+f_height+3,5], y/2);
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


module BottomPlate()
{
    difference() {
        // Uncut base plate
        cube([pdb_width, pdb_length, pp_thickness]);
        
        // a
        RightAngleTriangle(a_x, a_y);
        
        // b
        RightAngleTriangle(b_x, -b_y, [0,a_y+b_y,0]);
        
        // c
        Rectangle(c_x, c_y, [0,a_y+b_y,0]);
        
        // d
        RightAngleTriangle(d_x, d_y, [0,a_y+b_y+c_y,0]);
        
        // e
        RightAngleTriangle(e_x, -e_y, [0,pdb_length,0]);
        
        // f
        RightAngleTriangle(-f_x, -f_y, [e_x+f_x,pdb_length,0]);
        
        // g
        Rectangle(g_x, g_y, [e_x+f_x,pdb_length-g_y,0]);
        
        // h
        RightAngleTriangle(h_x, -h_y, [e_x+f_x+g_x,pdb_length,0]);
        
        // i
        RightAngleTriangle(-i_x, -i_y, [pdb_width,pdb_length,0]);
        
        // j
        RightAngleTriangle(-j_x, j_y, [pdb_width,m_y+l_y+k_y,0]);
        
        // k
        Rectangle(k_x, k_y, [pdb_width-k_x,m_y+l_y,0]);
        
        // l
        RightAngleTriangle(-l_x, -l_y, [pdb_width,m_y+l_y,0]);
        
        // m
        RightAngleTriangle(-m_x, m_y, [pdb_width,0,0]);
        
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
        Hole(t_x, t_y);
        
        // u
        Hole(u_x, u_y);
    }
}


// Side plate components are denoted by upper case, but correspond
// with the diagram above. "B" is the side plate part sitting on
// the edge that "b" creates with its hypotenuse.

B_len = sqrt((b_x * b_x) + (b_y * b_y));  // Pythagoras
B_rot = 90+(atan(b_y/b_x));               // sohcahTOA
D_len = sqrt((d_x * d_x) + (d_y * d_y));
D_rot = 270-(atan(d_y/d_x));
J_len = sqrt((l_x * l_x) + (l_y * l_y));
J_rot = 270+(atan(l_y/l_x));
L_len = sqrt((j_x * j_x) + (j_y * j_y));
L_rot = 90-(atan(j_y/j_x));


module SidePlate()
{
    // B
    NotchedWall(pp_thickness, B_len, sp_height, [b_x,a_y+b_y,0], B_rot);
    
    // C
    translate([c_x-pp_thickness,a_y+b_y,0])
    cube([pp_thickness,c_y,sp_height]);
    
    // D
    NotchedWall(pp_thickness, D_len, sp_height, [0,a_y+b_y+c_y+d_y,0], D_rot);
    
    // J
    NotchedWall(pp_thickness, J_len, sp_height, [pdb_width-l_x,m_y+l_y+k_y,0], J_rot);
    
    difference() {
        // K
        translate([pdb_width-k_x,m_y+l_y,0])
        cube([pp_thickness,k_y,sp_height]);
        
        // USB hole
        translate([pdb_width-k_x-pp_thickness/2,m_y+l_y+4,3])
        cube([pp_thickness*2,12,10]);
    }
    
    // L
    NotchedWall(pp_thickness, L_len, sp_height, [pdb_width,m_y,0], L_rot);
}


union() {
    BottomPlate();
    SidePlate();
}
