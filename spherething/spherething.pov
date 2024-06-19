#include "colors.inc"
#include "stones1.inc"
#include "woods.inc"

background { color Black }
 
#declare base1 =
difference
{
	box {
		<0,-1,0>
		<1,1,1>
		texture { T_Stone8 }
		translate <-0.5, -0.5, -0.5>
	}
	box {
		<0,-1.1,0>
		<1.1,1.1,1.1>
		texture { T_Stone8 }
		translate <-0.55, -0.55, -0.55>
		rotate y*45
	}
}

#declare base2=
difference
{
	object { base1 }
	sphere { <0,0.5,0> 0.75 texture { T_Stone8 } }
}

camera {
	location <2, 2, -3>
	look_at <0,0,0>
}

#declare base=
union {
	object { base2 }
	box {
		<0,0,0>
		<1.2,0.2,1.2>
		texture { T_Stone8 }
		translate <-0.6,-1.2,-0.6>
	}
	cylinder {
		<0,0,0>
		<0,0.2,0>
		0.95
		texture { T_Stone8 }
		translate <0,-1.4,0>
	}
}

 
light_source { <10,10,-10> White rotate y*-30}
light_source { <0,0.5,0> White }

object { base }
sphere {
	<0,0.5,0> 0.55
	pigment { color rgbf <0.7,0.7,1,0.8> }
	finish { reflection 0.7 phong 0.3 }
}

box {
	<0,0,0>
	<10,1,10>
	texture { T_Wood2 }
	translate <-5,-2.4,-5>
}

