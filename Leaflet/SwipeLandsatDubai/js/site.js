L.Google.prototype.addTo =
L.Yandex.prototype.addTo =
function(map) {
    map.addLayer(this);
    console.log(this._container)
    return this;
};
L.Yandex.prototype.getContainer =
L.Google.prototype.getContainer = function() {
    return this._container;
};

(function() {
    L.mapbox.accessToken = 'pk.eyJ1IjoiaGV5aXRzZ2FycmV0dCIsImEiOiIwdWt5ZlpjIn0.73b7Y47rgFnSD7QCNeS-zA';
    // var layerids = (location.search.split('?')[1] || '')
    //     .split('/')[0]
    //     .split('&');
    var createLayer = function(layerid) {
        var split = layerid.split('.');
        switch(split[0]) {
            case 'bing':
                return new L.BingLayer('AjCTNNlzpfcDOc0G58A4Hzx1N0OGrO8IXpFj1TVqlPG7sUxc8LqXbClnVK9RLk4q');
            case 'google':
                return new L.Google(split[1] || 'ROADMAP');
            case 'yandex':
                return new L.Yandex();
            case 'osm':
                map.infoControl.addInfo('<a href="https://openstreetmap.org/copyright">&copy; OpenStreetMap contributors</a>');
                return new L.TileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png');
            default:
                return L.mapbox.tileLayer(layerid);
        }
    };
    var map = L.mapbox.map('map', null, {
        center: [0, 0],
        zoom: 3
    });
    //var hash = L.hash(map);

    //console.log("left: " + layerids[0] + ", right: " + layerids[1]);
    // var left = createLayer(layerids[0]).addTo(map);
    // var right = createLayer(layerids[1]).addTo(map);

    var left = createLayer("examples.b1grdx6r,examples.irnyu8fr").addTo(map);
    var right = createLayer("examples.b1grdx6r,examples.0a57mn29").addTo(map);

    // Remove classes Google.js adds.
    left.getContainer().className =
        left.getContainer().className.replace(/\bleaflet-top\b/,'').replace(/\bleaflet-left\b/,'');
    right.getContainer().className =
        right.getContainer().className.replace(/\bleaflet-top\b/,'').replace(/\bleaflet-left\b/,'');

    // Clip as you move map or range slider.
    var range = document.getElementById('range');
    function clip() {
        var nw = map.containerPointToLayerPoint([0, 0]),
            se = map.containerPointToLayerPoint(map.getSize()),
            clipX = nw.x + (se.x - nw.x) * range.value;
        var elem = left.getContainer();
        elem.style.clip = 'rect(' + [nw.y, clipX, se.y, nw.x].join('px,') + 'px)';
        elem.style.display='none';
        elem.offsetHeight;
        elem.style.display='';
        var elem = right.getContainer();
        elem.style.clip = 'rect(' + [nw.y, se.x, se.y, clipX].join('px,') + 'px)';
        elem.style.display='none';
        elem.offsetHeight;
        elem.style.display='';
    }

    range['oninput' in range ? 'oninput' : 'onchange'] = clip;
    map.on('move', clip);

    map.setView([24.5883,55.2310], 9);
})();
