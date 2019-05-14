#!/bin/sh
# Purpose: Geoid model map with coastline and grid crosses
# Equidistant conic projection (here: Kuril-Kamchatka Trench)
# GMT modules: grd2cpt, grdimage, pscoast, logo, pstext
# Step-1. Generate a file
ps=Geoid_KKT.ps
# Step-2. Generate a color palette table from grid
gmt grd2cpt geoid.egm96.grd -Crainbow > geoid.cpt
# Step-3. Generate geoid image with shading
gmt grdimage geoid.egm96.grd -I+a45+nt1 -R140/170/40/60 -JD155/50/45/55/6i -Cgeoid.cpt -P -K > $ps
# Step-4. Add basemap: grid, title, scale, rose, costline
gmt pscoast -R -J -P -Ba \
	-V -W0.25p \
    -Df -B+t"Geoid gravitational regional modeling: Kuril-Kamchatka Trench area" \
	-Bxa4g4f1 -Bya4g4f1 \
    --FORMAT_GEO_MAP=dddF \
    --MAP_TITLE_OFFSET=1c \
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
    -U -O -K >> $ps
gmt logo -R -J -Dx6.5/-2.2+o0.1i/0.1i+w2c -O -K >> $ps
# Step-5. Add subtitle
gmt pstext -R0/10/0/10 -Jx1i -X5.5c -Y6.0c -N -O \
-F+f10p,Palatino-Roman,black+jCB >> $ps << EOF
0.0 4.0 Data source: Global Geoid Model, 2 min resolution
EOF
