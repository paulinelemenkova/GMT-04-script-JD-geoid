#!/bin/sh
# Purpose: Geoid model map with coastline and grid crosses
# Equidistant conic projection (here: Kuril-Kamchatka Trench). Small inserted World map: Eckert VI projection.
# GMT modules: gmtset, grd2cpt, grdimage, pscoast, grdcontour, psbasemap, psscale, psimage, logo, pstext, psconvert
# Step-1. Generate a file
ps=Geoid_KKT.ps
# Step-2. GMT set up
gmt set FORMAT_GEO_MAP=dddF \
    MAP_TITLE_OFFSET=1c \
    MAP_FRAME_PEN=dimgray \
    MAP_FRAME_WIDTH=0.1c \
    MAP_TICK_PEN_PRIMARY=thinner,dimgray \
    MAP_GRID_PEN_PRIMARY=thinnest \
    MAP_GRID_CROSS_SIZE_PRIMARY=0.1i \
    FONT_TITLE=14p,Palatino-Roman,black \
    FONT_ANNOT_PRIMARY=7p,Helvetica,dimgray \
    FONT_LABEL=7p,Helvetica,dimgray \
# Step-3. Generate a color palette table from grid
gmt grd2cpt geoid.egm96.grd -Crainbow > geoid.cpt
# Step-4. Generate geoid image with shading
gmt grdimage geoid.egm96.grd -I+a45+nt1 -R140/170/40/60 -JD155/50/45/55/6i -Cgeoid.cpt -P -K > $ps
# Step-5. Add basemap: grid, title, costline
gmt pscoast -R -J -P \
	-V -W0.25p \
    -Df -B+t"Geoid gravitational regional model: Kuril-Kamchatka Trench area" \
	-Bxa4g3f2 -Bya4g3f2 \
    -O -K >> $ps
# Step-6. Add geoid contour
grdcontour geoid.egm96.grd -R -J -C2 -A5 -Wthinnest,dimgray -O -K >> $ps
# Step-7. Add scale, directional rose
gmt psbasemap -R -J \
    --FONT=7p,Palatino-Roman,dimgray \
    --MAP_ANNOT_OFFSET=0.0c \
    --MAP_TITLE_OFFSET=0.3c \
    -Tdg144/57.5+w0.5c+f2+l \
    -Lx5.1i/-0.5i+c50+w800k+l"Equidistant conic projection. Scale, km"+f \
    -UBL/-15p/-40p -O -K >> $ps
# Step-8. Add scale, magnetic rose
gmt psbasemap -R -J \
    --FONT=7p,Palatino-Roman,dimgray \
    --FONT_ANNOT_PRIMARY=7p \
    --MAP_ANNOT_OFFSET_PRIMARY=0.1c \
    --MAP_ANNOT_OFFSET_SECONDARY=0.1c \
    --LABEL_OFFSET=0.1c \
    --MAP_TICK_PEN_PRIMARY=thinnest,dimgray \
    -Tmg162.5/45.2+w1.5i+d-14.5+t45/10/5+i0.25p,blue+p0.25p,red+l+jCM \
    -O -K >> $ps
# Step-9. Add legend
gmt psscale -R -J -Cgeoid.cpt \
    -Dg135/40+w4.7i/0.15i+v+o1.0/0i+ml  \
    --FONT_LABEL=8p,Helvetica,dimgray \
    --FONT_ANNOT_PRIMARY=5p,Helvetica,dimgray \
    -Baf+l"Gravitation modelling color scale" \
    -I0.2 -By+lm -O -K >> $ps
# Step-10. Insert map (global geoid)
gmt psimage -R -J Geoid_World.jpg -DjTR+w4.3c+o-5.5c/0c -O -K >> $ps
# Step-11. Add logo
gmt logo -R -J -Dx6.5/-2.2+o0.1i/0.1i+w2c -O -K >> $ps
# Step-12. Add subtitle
gmt pstext -R0/10/0/15 -JX10/10 -X0.5c -Y4.5c -N -O -K \
    -F+f10p,Palatino-Roman,black+jLB >> $ps << EOF
3.0 15.0 World Geoid Image version 9.2, 2 min resolution
EOF
# Step-13. Add text
gmt pstext -R -J -X2.5c -Y-6.4c -N -O -K \
    -F+f7p,Palatino-Roman,dimgray+jCB >> $ps << END
10.0 0.0 Standard paralles at 45\232 and 55\232 N
END
# Step-14. Add text
gmt pstext -R -J -N -O \
    -F+f7p,Palatino-Roman,dimgray+jCB >> $ps << END
9.7 4.8 Magnetic rose
END
# Step-15. Convert to image file using GhostScript
gmt psconvert Geoid_KKT.ps -A0.2c -E720 -P -Tj -Z
