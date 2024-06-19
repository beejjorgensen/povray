#macro Sierpinski(d, p0, p1, p2, p3)
    #if (d = 0)
        object {
            object {
                mesh {
                    triangle { p0, p1, p2 }
                    triangle { p0, p1, p3 }
                    triangle { p0, p2, p3 }
                    triangle { p1, p2, p3 }

                    texture {
                        pigment { color rgb <1,1,0> }
                        finish { ambient 0.1 diffuse 0.9 }
                    }

                    rotate <0,0,45>
                }
                rotate <-35,0,0>
            }
            rotate <0,120*clock,0>
        }
    #else
        #local p01 = (p0 + p1) / 2;
        #local p02 = (p0 + p2) / 2;
        #local p03 = (p0 + p3) / 2;
        #local p12 = (p1 + p2) / 2;
        #local p13 = (p1 + p3) / 2;
        #local p23 = (p2 + p3) / 2;

        Sierpinski(d-1, p0, p01, p02, p03)
        Sierpinski(d-1, p1, p01, p12, p13)
        Sierpinski(d-1, p2, p02, p12, p23)
        Sierpinski(d-1, p3, p03, p13, p23)
    #end
#end

light_source {
    <2, 4, -3>
    color rgb <1,1,1>
}

camera {
    location <0,0, -4>
    look_at <0,0,0>
}

background {
    color rgb <0,0,0>
}

Sierpinski(2, <1,1,1>, <1,-1,-1>, <-1, 1, -1>, <-1, -1, 1>)
