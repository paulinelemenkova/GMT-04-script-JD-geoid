#!/bin/sh
# Purpose: Geoid model map with coastline and grid crosses
# Pseudocylindrical Eckert VI projection. Area: World.
# GMT modules: grd2cpt, grdimage, pscoast, psbasemap, psconvert
# Step-1. Generate a file
ps=Geoid_World.ps
# Step-2. Generate a color palette table from grid
gmt grd2cpt geoid.egm96.grd -Crainbow > geoid.cpt
# Step-3. Generate geoid image with shading
gmt grdimage geoid.egm96.grd -I+a45+nt1 -Rg -JKs180/9i -Cgeoid.cpt -K > $ps
# Step-4. Add basemap: grid, title, costline
gmt pscoast -R -J \
	-V -W0.25p \
    -Di -B+t"Global Geoid Model Image" \
	-Bxa30g30 -Bya30g30 \
    --FORMAT_GEO_MAP=dddF \
    --MAP_TITLE_OFFSET=0.5c \
    --MAP_FRAME_PEN=dimgray \
    --MAP_FRAME_WIDTH=0.1c \
    --MAP_TICK_PEN_PRIMARY=thinner,dimgray \
    --MAP_GRID_PEN_PRIMARY=thinnest \
    --MAP_GRID_CROSS_SIZE_PRIMARY=0.1i \
    --FONT_TITLE=36p,Palatino-Roman,black \
    --FONT_ANNOT_PRIMARY=7p,Helvetica,dimgray \
    --FONT_LABEL=7p,Helvetica,dimgray \
    -O -K >> $ps
# Step-5. Add scale
gmt psbasemap -R -J \
    --FONT=18p,Palatino-Roman,dimgray \
    --MAP_ANNOT_OFFSET=0.5c \
    -Lx4.5i/-0.6i+c50+w10000k+l"Pseudocylindrical Eckert VI projection. Scale, km"+f \
    -O >> $ps
# Step-6. Convert to image file using GhostScript
gmt psconvert Geoid_World.ps -A0.2c -E720 -P -Tj -Z
