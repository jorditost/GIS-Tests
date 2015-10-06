#!/bin/sh

#establish an id variable
id="$1"
dir="landsat8-projected-rgb"

#create output directory
mkdir $dir

#use a for loop to reproject each of the bands you will be working with.
for BAND in {4,3,2}; do
 gdalwarp -t_srs EPSG:3857 $id"_B"$BAND.tif $dir/$BAND-projected.tif;done

cd $dir

#translate each of your bands into the 8-bit format with default settings of -ot and -scale
gdal_translate -ot Byte -scale 0 65535 0 255 4-projected{,-scaled}.tif
gdal_translate -ot Byte -scale 0 65535 0 255 3-projected{,-scaled}.tif
gdal_translate -ot Byte -scale 0 65535 0 255 2-projected{,-scaled}.tif

#merge the three reprojected band images into a single composite image
gdal_merge.py -v -ot Byte -separate -of GTiff -co PHOTOMETRIC=RGB -o $id-RGB-scaled.tif 4-projected-scaled.tif 3-projected-scaled.tif 2-projected-scaled.tif

#color corrections in blue bands to deal with haze factor,
#and across all brands for brightness, contrast and saturation
convert -channel B -gamma 1.05 -channel RGB -sigmoidal-contrast 20,20% -modulate 100,150 $id-RGB-scaled.tif $id-RGB-scaled-cc.tif

#use a cubic downsampling method to add overview
#(other interpolation methods are available)
gdaladdo -r cubic $id-RGB-scaled-cc.tif 2 4 8 10 12

#call the TIFF worldfile for the requested image,
#change name of file to match file needing georeference,
#and apply georeference
listgeo -tfw 3-projected.tif
mv 3-projected.tfw $id-RGB-scaled-cc.tfw
gdal_edit.py -a_srs EPSG:3857 $id-RGB-scaled-cc.tif

#remove black background
gdalwarp -srcnodata 0 -dstalpha $id-RGB-scaled-cc.tif $id-RGB-scaled-cc-out.tif
