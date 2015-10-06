import TUIO.*;
import de.fhpotsdam.unfolding.UnfoldingMap;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.events.EventDispatcher;
import de.fhpotsdam.unfolding.interactions.TuioCursorHandler;
import de.fhpotsdam.unfolding.providers.*;

/**
 * An interactive map which users can zoom, pan, and rotate with finger gestures.
 * 
 * You'll need a TUIO-capable touch device to run this example! See http://www.tuio.org/?software for more information.
 * Start as application for full-screen.
 * 
 * See {@link MultitouchMapExternalTuioApp} for how to handle multitouch input for both your app and the map.
 * 
 */

public static final boolean DISABLE_ROTATING = false;
public static boolean FULLSCREEN = true;

UnfoldingMap map;
TuioCursorHandler tuioCursorHandler;

public void setup() {
  if (FULLSCREEN) {
    size(displayWidth, displayHeight);
    //size(displayWidth, displayHeight, OPENGL);
  } else {
    size(800, 600);
    //size(800, 600, OPENGL);
  }
  
  Location colombiaLocation = new Location(10.1f, -73.2f);
  int zoomLevel = 6;

  // Init the map
  map = new UnfoldingMap(this, "map", new Microsoft.AerialProvider());
  map.zoomAndPanTo(colombiaLocation, zoomLevel);
  
  // Create multitouch input handler, and register map to listen to pan and zoom events.
  tuioCursorHandler = new TuioCursorHandler(this, map);
  
  EventDispatcher eventDispatcher = new EventDispatcher();
  eventDispatcher.addBroadcaster(tuioCursorHandler);
  
  eventDispatcher.register(map, "pan");
  eventDispatcher.register(map, "zoom");
}

public void draw() {
  background(0);

  if (DISABLE_ROTATING) {
    map.rotateTo(0);
  }
  map.draw();

  // Shows position of fingers for debugging.
  //tuioCursorHandler.drawCursors();
  
  noStroke();
  fill(200, 0, 0, 100);
  for (TuioCursor tcur : tuioCursorHandler.getTuioClient().getTuioCursors()) {
    ellipse(tcur.getScreenX(width), tcur.getScreenY(height), 20, 20);
  }
}

boolean sketchFullScreen() {
  return FULLSCREEN;
}
