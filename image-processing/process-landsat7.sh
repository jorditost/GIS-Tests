#!/bin/sh

#establish an id variable
id="$1"
dir="landsat7-projected-rgb"

#create output directory
mkdir $dir

#use a for loop to reproject each of the bands you will be working with.
for BAND in {3,2,1}; do
gdalwarp -t_srs EPSG:3857 $id"_B"$BAND.tif $dir/$BAND-projected.tif;done

cd $dir

#merge the three reprojected band images
#into a single composite image
gdal_merge.py -v -separate -of GTiff -co PHOTOMETRIC=RGB -o $id-RGB.tif 3-projected.tif 2-projected.tif 1-projected.tif

#use ImageMagick to modulate default brightness, increased saturation.
#sigmoidal contrast increased contrast, default middle brightness
convert -channel RGB -modulate 100,150 -sigmoidal-contrast 4x50% $id-RGB.tif $id-RGB-cc.tif

#use a cubic downsampling method to add overviews
#(other interpolation methods are available)
gdaladdo -r cubic $id-RGB-cc.tif 2 4 8 10 12

#create a TIFF worldfile from the requested image
listgeo -tfw 3-projected.tif

#rename the requested TIFF worldfile to have same name
#as the file that needs to be re-georeferenced
mv 3-projected.tfw $id-RGB-cc.tfw

#apply spatial reference system to non-georeferenced file
#(GDAL knows to look for files with matching names)
gdal_edit.py -a_srs EPSG:3857 $id-RGB-cc.tif

gdalwarp -srcnodata 0 -dstalpha $id-RGB-cc.tif $id-RGB-cc-out.tif
