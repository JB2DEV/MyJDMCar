import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedPageFlipBuilder extends AnimatedWidget {
  const AnimatedPageFlipBuilder({
    Key key,
    @required Animation<double> animation,
    @required this.showFrontSide,
    @required this.frontBuilder,
    @required this.backBuilder,
    this.flipAxis = Axis.horizontal,
    this.maxTilt = 0.003,
    this.maxScale = 0.2,
  }) : super(key: key, listenable: animation);
  final bool showFrontSide;
  final WidgetBuilder frontBuilder;
  final WidgetBuilder backBuilder;
  final Axis flipAxis;
  final double maxTilt;
  final double maxScale;

  @override
  Widget build(BuildContext context) {
    final child = _isAnimationFirstHalf ^ showFrontSide
        ? backBuilder(context)
        : frontBuilder(context);
    final matrix = flipAxis == Axis.horizontal
        ? (Matrix4.rotationY(_rotationAngle())..setEntry(3, 0, _getTilt()))
        : (Matrix4.rotationX(_rotationAngle())..setEntry(3, 1, _getTilt()));
    final scale = _scale();
    return Transform(
      transform: matrix * Matrix4.diagonal3Values(scale, scale, 1.0),
      child: child,
      alignment: Alignment.center,
    );
  }

  Animation<double> get animation => listenable as Animation<double>;

  ///Función que retorna si la carta se ha girado + del 50% 
  bool get _isAnimationFirstHalf => animation.value.abs() < 0.5;

  ///Función que retorna la inclinación de la carta
  double _getTilt() {
    var tilt = (animation.value - 0.5).abs() - 0.5;
    if (animation.value < -0.5) {
      tilt = 1.0 + animation.value;
    }
    return tilt * (_isAnimationFirstHalf ? -maxTilt : maxTilt);
  }

  ///Función que retorna el angulo de rotación dela carta
  double _rotationAngle() {
    final rotationValue = animation.value * pi;
    if (animation.value > 0.5) {
      return pi - rotationValue;
    } else if (animation.value > -0.5) {
      return rotationValue; 
    } else {
      return -pi - rotationValue; 
    }
  }

  ///Función que retorna la amplitud de la carta
  double _scale() {
    final absValue = animation.value.abs();
    return 1.0 - (absValue < 0.5 ? absValue : 1.0 - absValue) * maxScale;
  }
}
