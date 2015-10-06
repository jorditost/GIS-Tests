# Processing Landsat images

This unix shell scripts are used to process Landsat 7 and Landsat 8 satellite images for using them in Mapbox or TileMill.

It reprojects them to Web Mercator (EPSG:3857) and makes some image processing (color, saturation, contrast, etc.).

Source:
https://www.mapbox.com/guides/processing-satellite-imagery/#processing-for-true-color

## Usage

### Landsat 7

Paste the `process-landsat7.sh` inside the directory that contains the Landsat images.

Inside the command line, open this directory:

```
cd LANDSAT7_DIRECTORY
```

In the command line, execute the script by giving the *Landsat Scene Identifier*:

```
sh process-landsat7.sh LANDSAT_SCENE_ID
```

*Note:* The ID is normally the ID in front of each band. For band 1: `LANDSAT_SCENE_ID_B1.TIF`. For example, for `LE71600432000140SGS00_B1.TIF`, the ID is `LE71600432000140SGS00`.

For this ID, the command would be:

```
sh process-landsat7.sh LE71600432000140SGS00
```

You will find the processed images inside the directory `landsat7-projected-rgb`. The output image is the one which ends with `*-cc-out`.

### Landsat 8

Paste the `process-landsat8.sh` inside the directory that contains the Landsat images.

Inside the command line, open this directory:

```
cd LANDSAT8_DIRECTORY
```

In the command line, execute the script by giving the *Landsat Scene Identifier*:

```
sh process-landsat8.sh LANDSAT_SCENE_ID
```

For the ID `LC81600432014154LGN00`, the command would be:

```
sh process-landsat8.sh LC81600432014154LGN00
```

You will find the processed images inside the directory `landsat8-projected-rgb`. The output image is the one which ends with `*-cc-out`.
