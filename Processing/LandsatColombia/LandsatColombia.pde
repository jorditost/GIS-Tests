/**
 * Shows two independent maps side by side, with own interactions and different providers.
 */

import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.mapdisplay.MapDisplayFactory;

public static boolean FULLSCREEN = true;

UnfoldingMap map;
UnfoldingMap landsat;

public void setup() {
  if (FULLSCREEN) {
    size(displayWidth, displayHeight, P2D);
  } else {
    size(800, 600, P2D);
  }
  
  Location colombiaLocation = new Location(10.1f, -73.2f);
  int zoomLevel = 6;
  
  // Aerial map
  map = new UnfoldingMap(this, "map", new Microsoft.AerialProvider());
  map.zoomAndPanTo(colombiaLocation, zoomLevel);
  //map.setZoomRange(8, 13);
  
  // Landsat for Colombia region
  String mbTilesString = sketchPath("data/digenti-test.mbtiles");
  landsat = new UnfoldingMap(this, "landsat", new MBTilesMapProvider(mbTilesString));
  landsat.zoomAndPanTo(colombiaLocation, zoomLevel);
  //landsat.setZoomRange(8, 13);
  
  MapUtils.createDefaultEventDispatcher(this, map, landsat);
}

public void draw() {
  background(0);

  map.draw();
  //tint(255, 100);
  landsat.draw();
}

boolean sketchFullScreen() {
  return FULLSCREEN;
}
