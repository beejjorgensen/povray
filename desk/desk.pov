// Beej's Desk

// povray +A0.3 -Idesk.pov +W640 +H480
// Render time: 83 seconds (Linux Pentium 133) [circa 1995]
//
// 2024 render time for 1600x1200: 0.5 seconds

#include "colors.inc"
#include "woods.inc"
#include "metals.inc"

camera {
	location <7, 35, -85>
	look_at <11, -20, 15>
}

light_source { <-10, 20, 15> White }
light_source { <40, 40, -180> White }

// declare 28" legs:
#declare leg =
union {
	box {
		<0,0,0>,
		<1,-28,1>
		pigment { P_Chrome1 }
	}
	box {
		<0,0,0>,
		<0.8, -0.3, 0.8>
		pigment { rgb <0.5,0.5,0.5> }
		translate <0.1, -28, 0.1>
	}
}


#declare table =
union {
	// The wooden top:
	box {
		<0,0,0>,
		<60,1,30>
		texture { T_Wood1 rotate 90*y scale 8}
		translate <-30,0,0>
	}

	// The white underside sans drawer:
	difference {
		box {
			<0.2,0,0.2>
			<59.8,2.5,29.8>
			pigment { White }
			finish { specular 1 }
			translate <-30,-2.5,0>
		}
		box {
			<-0.1,0,0>,
			<24.1,-2.6,29>
			pigment { White }
			finish { specular 1 }
			translate <-12,0,0>
		}
	}
			
	// The legs:
	object { leg translate <-29.9, 0, 0.1> }
	object { leg translate <28.9, 0, 0.1> }
	object { leg translate <-29.9, 0, 28.9> }
	object { leg translate <28.9, 0, 28.9> }

	// The drawer:
	union {
		// The front
		box {
			<0,0,0>,
			<24,2.5,0.4>
			pigment { White }
			finish { specular 1 }
		}
		// The main drawer inside
		difference {
			box {
				<0.1,0.1,0.4>,
				<23.9,2.1,29>
				pigment { White }
				finish { specular 1 }
			}
			box {
				<0.6,0.2,0.4>,
				<23.4,2.2,28.9>
				pigment { White }
				finish { specular 1 }
			}
		}
		// The pen rack
		difference {
			box {
				<0,0,0>,
				<22.8,2,2.75>
				pigment { White }
				finish { specular 1 }
			}
			cylinder {
				<0,2,1.2>,
				<22.8,2,1.2>,
				1.2
				pigment { White }
				finish { specular 1 }
			}
			translate <0.6,0,0.4>
		}

		//translate <-12,-2,0.2>
		translate <-12,-2,-11>
	}
} // End of table

object { table rotate 20*y scale 2 }
