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

  var padding = 150;
  var speed = 0.009;
  var scale = 0.05;
  var random = new Random();
  for (int i = 0; i < 22; i++) {
    var x0 = padding + random.nextDouble() * (stage.stageWidth - padding);
    var y0 = padding + random.nextDouble() * (stage.stageHeight - padding);
    scale += 0.025;
    speed += 0.0013;
    var path = new RandomPath(x: x0, y: y0,
        top:50, bottom:stage.stageHeight - 50, left:50, right:stage.stageWidth - 50,
        scale: scale, speed: speed);
    stage.addChild(path);
    path.startLoop();
  }
}