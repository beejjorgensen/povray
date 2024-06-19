#declare BOARD_WIDTH_MM = 424.4;
#declare BOARD_HEIGHT_MM = 454.5;
#declare BOARD_DEPTH_MM = 60;
#declare BOARD_LINES = 19;

#declare LINE_WIDTH_MM = 1;
#declare LINE_WIDTH_SPACING_MM = 22;
#declare LINE_HEIGHT_SPACING_MM = 23.7;

#declare STAR_POINT_MM = 4;
#declare STAR_POINT_ROW = 3;

#declare STONE_DIAMETER_MM = 22.5;
#declare STONE_THICKNESS_MM = 7.5;

#declare POSITION_JITTER_MM = 0; // plus or minus, no collision avoidance

#declare BoardData = array[BOARD_LINES];

#declare  BoardData[0] = "...................";
#declare  BoardData[1] = "...................";
#declare  BoardData[2] = "...B.....WW.WWWWB..";
#declare  BoardData[3] = "...*B....*B..BBBB..";
#declare  BoardData[4] = ".BBWB......B.......";
#declare  BoardData[5] = ".BW.W.W..B.W..WWB..";
#declare  BoardData[6] = "...W.....BW...BWB..";
#declare  BoardData[7] = "..W.....B..WWW..B..";
#declare  BoardData[8] = ".......W..WB.BW.B..";
#declare  BoardData[9] = "...*...WB*...BWBWW.";
#declare BoardData[10] = ".......WB.B.BW.BW..";
#declare BoardData[11] = "..W....WWB..B.B.W..";
#declare BoardData[12] = "....B....BW....BW..";
#declare BoardData[13] = "..W...W..BW.B.BWB..";
#declare BoardData[14] = ".WBW.BBW..W...WW.B.";
#declare BoardData[15] = ".BBB.BWW.*...B.WWB.";
#declare BoardData[16] = ".....B...B.W..W..W.";
#declare BoardData[17] = ".......B...........";
#declare BoardData[18] = "...................";

/*
#declare  BoardData[0] = "...................";
#declare  BoardData[1] = "...................";
#declare  BoardData[2] = "...................";
#declare  BoardData[3] = "...*.....*.....*...";
#declare  BoardData[4] = "...................";
#declare  BoardData[5] = "...................";
#declare  BoardData[6] = "...................";
#declare  BoardData[7] = "...................";
#declare  BoardData[8] = "...................";
#declare  BoardData[9] = "...*.....*.....*...";
#declare BoardData[10] = "...................";
#declare BoardData[11] = "...................";
#declare BoardData[12] = "...................";
#declare BoardData[13] = "...................";
#declare BoardData[14] = "...................";
#declare BoardData[15] = "...*.....*.....*...";
#declare BoardData[16] = "...................";
#declare BoardData[17] = "...................";
#declare BoardData[18] = "...................";
*/

camera {
    //location <400, 400, 400>
    location <0, 350, 350>
    //location <0, 100, 100>
    look_at <0, 0, 60>
    right -1.33 * x
}

light_source {
    <0, 1000, 1000>, <1,1,1>
    area_light
    <0,0,1000>,<1000,0,0>,3,3
    circular
    jitter
}

light_source {
    <-500, 1000, -500>, <1,1,1>
    area_light
    <0,0,1000>,<1000,0,0>,3,3
    circular
    jitter
}

#macro RandomAngle()
    360 * rand(Seed)
#end

#macro BlackStoneTexture()
    texture {
        pigment {
            bozo
            color_map {
                [0.0 color rgb <0.07, 0.07, 0.07>]
                [1.0 color rgb <0.12, 0.12, 0.12>]
            }
            scale 0.1
            turbulence 1
        }
        finish {
            phong albedo 0.05 phong_size 20
        }
    }
#end

#declare Seed = seed(4);

#macro WhiteStoneTexture()
    texture {
        pigment {
            wood
            color_map {
                [0.0 color rgb <0.8,0.8,0.8>]
                [0.7 color rgb <0.8,0.8,0.8>]
                [1.0 color rgb <0.75,0.75,0.75>]
            }
            scale <2,1,0.7>
            rotate <rand(Seed)*10-5, RandomAngle(), rand(Seed)*10-5>
            translate <rand(Seed)*10,0,0>
            turbulence 0.01
        }
        finish {
            phong albedo 0.08 phong_size 10
        }
    }
#end

#macro BlackStone()
    sphere {
        <0,0,0>, STONE_DIAMETER_MM / 2
        translate <0, STONE_DIAMETER_MM / 2, 0>
        scale <1, STONE_THICKNESS_MM / STONE_DIAMETER_MM, 1>
        BlackStoneTexture()
    }
#end

#macro WhiteStone()
    sphere {
        <0,0,0>, STONE_DIAMETER_MM / 2
        translate <0, STONE_DIAMETER_MM / 2, 0>
        scale <1, STONE_THICKNESS_MM / STONE_DIAMETER_MM, 1>
        WhiteStoneTexture()
    }
#end

#macro Line(len)
    cylinder {
        <0,0,0>,
        <0,0,len>,
        LINE_WIDTH_MM / 2
        
        texture {
            pigment {
                color rgb <0,0,0>
            }
        }

        scale <1,0.01,1>
    }
#end

#declare StarPoint = cylinder {
    <0,0,0>, <0,0.01,0>, STAR_POINT_MM / 2
    texture {
        pigment {
            color rgb <0,0,0>
        }
    }
}

#macro StarPoints()
    #local RowsOut = (BOARD_LINES - 1) / 2 - STAR_POINT_ROW;
    #local StarPointX = LINE_WIDTH_SPACING_MM * RowsOut;
    #local StarPointZ = LINE_HEIGHT_SPACING_MM * RowsOut;

    #for (i, -1, 1)
        #for (j, -1, 1)
            object {
                StarPoint
                translate <j * StarPointX,0,i * StarPointZ>
            }
        #end
    #end
#end

#declare Wood = box {
    <0,0,0>, <BOARD_WIDTH_MM, -BOARD_DEPTH_MM, BOARD_HEIGHT_MM>
    texture {
        pigment {
            bozo
            color_map {
                [0.0 color rgb <0.7, 0.5, 0.3>] // Medium wood
                [1.0 color rgb <0.6, 0.4, 0.2>] // Darker wood
            }
            scale <5,5,200>
            turbulence 1
        }
    }
    translate <-BOARD_WIDTH_MM/2, 0, -BOARD_HEIGHT_MM/2>
}

#macro Lines(n)
    #local LongLen = LINE_HEIGHT_SPACING_MM * (BOARD_LINES - 1);
    #local ShortLen = LINE_WIDTH_SPACING_MM * (BOARD_LINES - 1);
    #local LongOff = -LongLen / 2;
    #local ShortOff = -ShortLen / 2;

    #if (n >= 0)
        object {
            Line(LongLen)
            translate <ShortOff + n*LINE_WIDTH_SPACING_MM, 0, LongOff>
        }
        object {
            Line(ShortLen)
            translate <LongOff + n*LINE_HEIGHT_SPACING_MM, 0, ShortOff>
            rotate <0, 90, 0>
        }
        Lines(n-1)
    #end
#end

#macro PosJitter()
    rand(Seed) * POSITION_JITTER_MM * 2 - POSITION_JITTER_MM
#end

#macro Stones()
    #for (yindex, 0, BOARD_LINES - 1)
        #for (xindex, 0, BOARD_LINES - 1)
            #local s = substr(BoardData[yindex], xindex+1, 1)
            #local xpos = xindex - (BOARD_LINES - 1) / 2;
            #local ypos = yindex - (BOARD_LINES - 1) / 2;
            #local xpos2 = xpos * LINE_WIDTH_SPACING_MM + PosJitter();
            #local ypos2 = ypos * LINE_HEIGHT_SPACING_MM + PosJitter();
            #if (s = "w" | s = "W")
                object {
                    WhiteStone()
                    translate <xpos2, 0, ypos2>
                }
            #elseif (s = "b" | s = "B")
                object {
                    BlackStone()
                    translate <xpos2, 0, ypos2>
                }
            #end
        #end
    #end
#end

#declare GoBan = union {
    object { Wood }
    Lines(BOARD_LINES - 1)
    StarPoints()
    Stones()
}

#declare GravelFloor = plane {
    y, -150
    texture {
        pigment {
            bozo
            color_map {
                [0.0 color rgb <0,0,0>]
                [1.0 color rgb <1,1,1>]
            }
            scale <4,4,4>
            turbulence 1
        }
    }
}

#declare MatFloor = plane {
    y, -150
    texture {
        pigment {
            bozo
            color_map {
                [0.0 color rgb <0.55, 0.44, 0.20>]
                [0.33 color rgb <0.50, 0.39, 0.15>]
                [0.66 color rgb <0.45, 0.34, 0.10>]
                [1.0 color rgb <0.40, 0.29, 0.05>]
            }
            scale <1,1,20>
            turbulence 1
        }
    }
    normal {
        gradient y
        normal_map {
            [0.0 bumps scale <100,1,1>]
            [0.1 bumps scale 1]
            [0.2 bumps scale 1]
            [1.0 bumps scale <100,1,1>]
        }
    }
}

object { GoBan }
object { MatFloor }

