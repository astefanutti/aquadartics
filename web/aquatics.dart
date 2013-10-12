library aquatics;

import 'dart:html' as html;
import 'dart:math';
import 'dart:async';
import 'package:stagexl/stagexl.dart';

part 'RandomPath.dart';
part 'Aquatic.dart';

void main() {
  var canvas = html.query('#stage');
  var stage = new Stage('myStage', canvas);
  var renderLoop = new RenderLoop();
  renderLoop.addStage(stage);
  var padding = 200;
  var speed = 0.008;
  var scale = 0.05;
  var random = new Random();
  for (int i = 0; i < 25; i++) {
    var a0 = 360 * random.nextDouble();
    var x0 = padding + random.nextDouble() * (stage.stageWidth - 2 * padding);
    var y0 = padding + random.nextDouble() * (stage.stageHeight - 2 * padding);
    scale += 0.022;
    speed += 0.0013;
    var path = new RandomPath(x0: x0, y0: y0, a0: a0,
        top: 50, bottom: stage.stageHeight - 50, left: 50, right: stage.stageWidth - 50,
        scale: scale, speed: speed);
    stage.addChild(path);
    path.startLoop();
  }
}