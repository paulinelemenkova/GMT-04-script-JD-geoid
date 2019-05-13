#!/bin/sh
# Purpose: map of coastline with grid crosses, Equidistant conic projection
# (here: Kuril-Kamchatka Trench)
# GMT modules: pscoast
gmt pscoast -R140/170/40/60 -JD155/50/45/55/6i -P -Ba \
	-Gdarkseagreen1 -V -W0.25p -Slightcyan \
	-Df -B+t"Coastline of the Kuril-Kamchatka area" \
	-Bxa4g4f1 -Bya4g4f1 \
    --FORMAT_GEO_MAP=dddF \
    --MAP_FRAME_PEN=dimgray \
    --MAP_FRAME_WIDTH=0.1c \
    --MAP_TICK_PEN_PRIMARY=thinner,dimgray \
    --FONT_TITLE=14p,Palatino-Roman,black \
    --FONT_ANNOT_PRIMARY=7p,Helvetica,dimgray \
    --FONT_LABEL=7p,Helvetica,dimgray \
    --MAP_GRID_PEN_PRIMARY=thinnest \
    --MAP_GRID_CROSS_SIZE_PRIMARY=0.1i \
    -Tdg144/57+w0.5c+f2+l \
    -Lx5.2i/-0.5i+c50+w800k+l"Equidistant conic projection. Scale, km"+f \
    -U -K > GMT_coast_KKT_cross.ps
gmt logo -R -J -O -Dx6.5/-2.2+o0.1i/0.1i+w2c >> GMT_coast_KKT_cross.ps
