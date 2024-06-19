#include "colors.inc"

// Pizza is 1 unit in diameter
#declare Pizza_Radius = 1.0/2;
#declare Crust_Radius = 0.04/2;
#declare Pepperoni_Radius = 0.09/2;
#declare Pepperoni_Thickness = 0.003;
#declare Pepperoni_Ring_Count = 5; // number of pepperoni rings
#declare Pepperoni_Spacing = 0.015; // between pepperoni in a particular ring
#declare Pepperoni_Jitter = 0.0075;  // distance
#declare Pepperoni_Rot_Jitter = 2;  // degrees
#declare Cheese_Radius = (Pizza_Radius - Crust_Radius);

#declare Final_Earth_Radius = 1.0;
#declare Final_Earth_Crop_Radius = 1.2;

#declare Render_Sky_Sphere = 1;
#declare Render_Atmosphere = 1;
#declare Render_URL_Text = 0;
#declare Render_IPS_Text = 0;

#declare PI = 3.14159265358979;

#declare Rand1 = seed(0);

/*-----------------------------------------------------------------
** Textures
*/
#declare Pizza_Crust_Texture =
texture {
#if (1)
	pigment {
		bozo
		turbulence 2.8
		color_map {
			[ 0.00 rgb <0.95,0.93,0.77> ]
			[ 0.60 rgb <0.95,0.42,0.00> ]
			[ 0.95 rgb <0.30,0.09,0.03> ]
			[ 1.00 rgb <0.30,0.09,0.03> ]
		}
	}
#else
	pigment {
		color White
	}
#end
	normal { bumps 0.08  scale 0.05 }
	scale 0.03
}

#declare Pizza_Body_Texture =
texture {
#if (1)
	pigment {
		bozo
		turbulence 2.8
		color_map {
			[ 0.00 rgb <1.00, 1.00, 1.00> ]
			[ 0.20 rgb <0.90, 0.85, 0.78> ]
			[ 0.70 rgb <0.87, 0.68, 0.17> ]
			[ 0.75 rgb <0.65, 0.15, 0.01> ]
			[ 0.76 rgb <0.67, 0.10, 0.12> ]
			[ 1.00 rgb <0.67, 0.00, 0.00> ]
		}
	}
#else
	pigment {
		color White
	}
#end
	normal { bumps 0.10  scale 0.3}
	finish { specular 0.7 roughness 0.04 }
	scale 0.05 
}

#declare Pepperoni_Texture =
texture {
#if (1)
	pigment {
		bozo
		turbulence 5.8
		color_map {
			[ 0.00 rgb <1.00, 0.60, 0.40> ]
			[ 0.20 rgb <0.72, 0.28, 0.22> ]
			[ 0.60 rgb <0.28, 0.06, 0.00> ]
			[ 1.00 rgb <0.28, 0.06, 0.00> ]
		}
	}
#else
	pigment {
		color White
	}
#end
	normal { bumps 0.18  scale 0.05 }
	finish { specular 0.2 roughness 0.04 }
	scale 0.05 
}

#declare Earth_Texture =
texture {
	pigment {
		image_map { jpeg "textures/land_ocean_ice_cloud_2048.jpg" map_type 1 }
		//image_map { jpeg "textures/earth-clear.jpg" map_type 1 }
	}
	finish {
		reflection 0.1
		phong 1
		ambient rgb <0.1, 0.1, 0.1>
	}
}

/*-----------------------------------------------------------------
** Objects
*/
#declare Pepperoni =
cylinder {
	<0, Pepperoni_Thickness, 0>
	<0, 0, 0>
	Pepperoni_Radius
	texture {
		Pepperoni_Texture
	}
}

#declare Pizza_Crust =
torus {
	Pizza_Radius, Crust_Radius
	scale <1, 0.5, 1>
	texture {
		Pizza_Crust_Texture
	}
}

#declare Pizza_Body =
union {
	// cheese layer
	cylinder {
		<0, 0, 0>
		<0, -Crust_Radius/2, 0>
		(Pizza_Radius - Crust_Radius)
		texture {
			Pizza_Body_Texture
		}
	}

	// pepperoni
	#declare Ring = 0;
	#while (Ring < Pepperoni_Ring_Count)
		#declare Cur_Ring_Radius = Ring * Pizza_Radius / Pepperoni_Ring_Count;
		#declare Cur_Ring_Circum = 2 * PI * Cur_Ring_Radius;

		#if (Cur_Ring_Circum = 0)
			// middle pepperoni
			object { Pepperoni }
		#else
//#debug concat("== ring: ",str(Ring,0,1), "\n")
			// ring of pepperoni
			#declare Pepp_Count = int(Cur_Ring_Circum / (Pepperoni_Radius * 2 + Pepperoni_Spacing));
			#declare Angle_Delta = 2 * PI / Pepp_Count;
//#debug concat("==   ring cir : ",str(Cur_Ring_Circum,0,2), "\n")
//#debug concat("==   pep count: ",str(Pepp_Count,0,1), "\n")
//#debug concat("==   delta a  : ",str(Angle_Delta,0,2), "\n")

			#declare Angle = 2 * PI * rand(Rand1);
			#declare J = 0;
			#while (J < Pepp_Count)
				object {
					Pepperoni

					#declare xrot = (rand(Rand1) * 2 - 1) * Pepperoni_Rot_Jitter;
					#declare yrot = (rand(Rand1) * 360);
					#declare zrot = (rand(Rand1) * 2 - 1) * Pepperoni_Rot_Jitter;
					rotate < xrot, yrot, zrot>

					#declare xoff = (rand(Rand1) * 2 - 1) * Pepperoni_Jitter;
					#declare zoff = (rand(Rand1) * 2 - 1) * Pepperoni_Jitter;
					translate < cos(Angle)*Cur_Ring_Radius + xoff, 0, sin(Angle)*Cur_Ring_Radius + zoff >
				}
				#declare Angle = Angle + Angle_Delta;
				#declare J = J + 1;
			#end // pepperoni while
		#end // if-else
		#declare Ring = Ring + 1;
	#end // ring while
}

#declare Pizza = 
union {
	object { Pizza_Crust }
	object { Pizza_Body }
}

#declare Earth =
union {
	sphere { // surface
		<0,0,0>, 1.0
		texture {
			Earth_Texture
		}
	}
	#if (Render_Atmosphere)
	sphere { // atmosphere
		<0,0,0>, 1.035
		hollow
		pigment {
			rgbt <1,1,1,1>
		}
		finish {ambient 0 diffuse 0}
		interior {
			media  {
				intervals 1         
				//samples 1,1          
				//emission <1,0,0>
				//absorption <1,0,0>
				scattering {
					5, <0,0.15,0.5>
					eccentricity 0.25
				}
			}
		}
	}
	#end
}

#declare IPSText =
text {
	//ttf "fonts/deftone_stylus.ttf" "internet pizza server" 1, 0
	ttf "fonts/cmtt10.ttf" "Internet Pizza Server" 0.1, 0
	pigment {
		Gray70
		/*
		gradient y
		color_map {
			[ 0.00 Blue ]
			[ 0.01 Blue ]
			[ 0.40 Gray80 ]
			[ 1.00 Gray70 ]
		}
		scale 1
		translate -0.02*y
		*/
	}
	finish { ambient Gray25 }
	scale <-1,1,1>
	scale 3
}

#declare URLText =
text {
	ttf "fonts/cmtt10.ttf" "http://beej.us/pizza/" 0.1, 0
	pigment {
		Gray70
	}
	finish { ambient Gray25 }
	scale <-1,1,1>
	scale 2
}

#declare TextObjects =
union {
	#if (Render_IPS_Text)
	object {
		IPSText
		translate <(max_extent(IPSText).x - min_extent(IPSText).x)/2,12.5,-50>
	}
	#end
	#if (Render_URL_Text)
	object {
		URLText
		translate <(max_extent(URLText).x - min_extent(URLText).x)/2,-14,-50>
	}
	#end
}

/*-----------------------------------------------------------------
** Scene
*/
light_source {
    <20, 0, 20>
    color rgb <1,1,0.91>*2.5
}

camera {
	location <0, 0, 5>
#if (1)
	// full
	look_at <0, 0, 0>
	//up  0.75 * y * 0.85
	//right x * 0.85
	right image_width/image_height*x
	angle 65
#else
	// closeup zoom
	look_at <1, -0.8, 0>
	up  0.75 * y * 0.25
	right x * 0.25
#end
}

#declare PizzaEarth = 
union {
	object {
		difference {
			object { Pizza scale 4.5 }
			sphere { <0,0,0>, Final_Earth_Crop_Radius }
		}
		rotate -y*clock*360
	}
	object {
		Earth
		rotate -y*clock*360*2
		scale Final_Earth_Radius
	}
}

object {
	PizzaEarth
	rotate <10, 0, -15>
}

object {
	TextObjects
}

#if (Render_Sky_Sphere)
sky_sphere {
	pigment {
	bozo
	color_map {
		[0.0 White]
		[0.2 Black]
		[1.0 Black]
	}
	scale .003
	}
}
#end
