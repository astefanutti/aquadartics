part of aquatics;

class RandomPath extends MovieClip {

  static const double _RAD = PI / 180.0;

  int _top, _bottom, _left, _right;
  double _scale, _alpha, _speed;
  double _x0, _y0, _x1, _y1, _x2, _y2, _x3, _y3, _x4, _y4;
  double _r0, _radius, _vectorRadius, _vr;
  double _a0, _angle,_vectorAngle, _va;
  double _t;
  List<DisplayObject> _elements = new List();
  Duration _period;
  Timer _timer;
  Random _random = new Random();

  RandomPath({x, y, top, left, bottom, right,
              speed: 0.01, alpha: 0.15, scale: 1,
              count: 10, period: 70,
              r0:100, radius:20, vectorRadius:50,
              a0:45, angle:40, vectorAngle:80}) {
    _x0 = x;
    _y0 = y;
    _top = top;
    _bottom = bottom;
    _left = left;
    _right = right;
    _speed = speed;
    _alpha = alpha;
    _scale = scale;
    _r0 = r0;
    _radius = radius;
    _vectorRadius = vectorRadius;
    _a0 = a0;
    _angle = angle;
    _vectorAngle = vectorAngle;
    _period = new Duration(milliseconds: period);

    _x1 = _x0;
    _y1 = _y0;
    var r = _r0 + _radius * (_random.nextDouble() - 0.5);
    var a = (_a0 + _angle * (_random.nextDouble() - 0.5)) * _RAD;
    _x4 = _x1 + r * cos(a);
    _y4 = _y1 + r * sin(a);
    _vr = _vectorRadius * (1 + _random.nextDouble() - 0.5);
    _va = a + _vectorAngle * (_random.nextDouble() - 0.5) * _RAD;
    _x2 = _x1 + _vr * cos(_va);
    _y2 = _y1 + _vr * sin(_va);
    _vr = _vectorRadius * (1 + _random.nextDouble() - 0.5);
    _va = a + PI + _vectorAngle * (_random.nextDouble() - 0.5) * _RAD;
    _x3 = _x4 + _vr * cos(_va);
    _y3 = _y4 + _vr * sin(_va);
    _t = 0.0;

    for (var i = 0; i < count; i++) {
      Aquatic mc = new Aquatic();
      mc.x = _x1;
      mc.y = _y1;
      mc.scaleX = mc.scaleY = _scale;
      mc.alpha = _alpha;
      _elements.add(mc);
      addChild(mc);
    }
  }

  void startLoop() {
    if (_timer == null) _timer = new Timer.periodic(_period, _loop);
  }

  void stopLoop() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  void _loop(Timer timer) {
    for (DisplayObject mc in _elements) {
      var omt = 1 - _t;
      var omts = omt * omt;
      var ts = _t * _t;
      var m1 = omts * omt;
      var m2 = 3 * _t * omts;
      var m3 = 3 * ts * omt;
      var m4 = ts * _t;
      mc.x = m1 * _x1 + m2 * _x2 + m3 * _x3 + m4 * _x4;
      mc.y = m1 * _y1 + m2 * _y2 + m3 * _y3 + m4 * _y4;
      m1 = -3 * omts;
      m2 = 3 * omts - 6 * _t * omt;
      m3 = 6 * _t * omt - 3 * ts;
      m4 = 3 * ts;
      var tx = m1 * _x1 + m2 * _x2 + m3 * _x3 + m4 * _x4;
      var ty = m1 * _y1 + m2 * _y2 + m3 * _y3 + m4 * _y4;
      mc.rotation = atan2(ty, tx);
      _t += _speed;
      if (_t >= 1) {
        _x1 = _x4;
        _y1 = _y4;
        var r = _r0 + _radius * (_random.nextDouble() - 0.5);
        var a = _va - PI + _angle * _random.nextDouble() * _RAD;
        _x4 = _x1 + r * cos(a);
        _y4 = _y1 + r * sin(a);
        var x4t = _x4;
        var y4t = _y4;
        var k = 0;
        while (_x4 < _left || _x4 > _right || _y4 < _top || _y4 > _bottom) {
          a += 15 * k++ * pow(-1, k) * _RAD;
          _x4 = _x1 + r * (1 + 0.01 * k) * cos(a);
          _y4 = _y1 + r * (1 + 0.01 * k) * sin(a);
        }
        _x2 = 2 * _x1 - _x3;
        _y2 = 2 * _y1 - _y3;
        _vr = _vectorRadius * (1 + _random.nextDouble() - 0.5);
        if (k != 0) {
          _va = atan2(y4t - _y4, x4t - _x4);
        } else {
          _va = a + PI + _vectorAngle * (_random.nextDouble() - 0.5) * _RAD;
        }
        _x3 = _x4 + _vr * cos(_va);
        _y3 = _y4 + _vr * sin(_va);
        _t = 0.0;
      }
    }
  }
}