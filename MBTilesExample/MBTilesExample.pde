
/**
 * YOU NEED TO download the sqlitejdbc driver from https://bitbucket.org/xerial/sqlite-jdbc/
 * and put the jar file into the 'code' directory of this sketch.
 *
 *
 * This example uses a local MBTiles file. Thus, it does not need an Internet connection to load tiles.
 * 
 * For testing purposes and to keep the file size small, this example supports only three zoom levels.
 */
 
import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.providers.*;

UnfoldingMap map;

void setup() {
  size(800, 600, P2D);
  
  String mbTilesString = sketchPath("data/MUSICAL_CITIES_BRIGHT.mbtiles");
  
  Location berlinLocation = new Location(52.439046f, 13.447266f);
  map = new UnfoldingMap(this, new MBTilesMapProvider(mbTilesString));

  MapUtils.createDefaultEventDispatcher(this, map);
  map.setZoomRange(11, 15);
  map.zoomAndPanTo(berlinLocation, 11);
}

void draw() {
  background(240);
  map.draw();
}
