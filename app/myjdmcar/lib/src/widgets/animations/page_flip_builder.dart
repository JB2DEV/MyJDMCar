import 'package:flutter/material.dart';
import 'package:myjdmcar/src/widgets/animations/animated_flip_builder.dart';

class PageFlipBuilder extends StatefulWidget {
  const PageFlipBuilder({
    Key key,
    @required this.frontBuilder,
    @required this.backBuilder,
    this.nonInteractiveAnimationDuration = const Duration(milliseconds: 500),
    this.interactiveFlipEnabled = true,
    this.flipAxis = Axis.horizontal,
    this.maxTilt = 0.003,
    this.maxScale = 0.2,
    this.onFlipComplete,
  }) : super(key: key);
  final WidgetBuilder frontBuilder;
  final WidgetBuilder backBuilder;
  final Duration nonInteractiveAnimationDuration;
  final bool interactiveFlipEnabled;
  final Axis flipAxis;
  final double maxTilt;
  final double maxScale;

  ///Función que indica cuando la animación de darse la vuelta
  ///ha terminado
  final void Function(bool) onFlipComplete;

  @override
  PageFlipBuilderState createState() => PageFlipBuilderState();
}

class PageFlipBuilderState extends State<PageFlipBuilder>
    with SingleTickerProviderStateMixin {
  bool _showFrontSide = true;
  bool _wasFrontSide = true;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.nonInteractiveAnimationDuration,
      lowerBound: -1.0,
      upperBound: 1.0,
    );
    _controller.value = 0.0;
    _controller.addStatusListener(_updateStatus);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_updateStatus);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isHorizontal = widget.flipAxis == Axis.horizontal;
    return LayoutBuilder(builder: (_, constraints) {
      final crossAxisLength =
          isHorizontal ? constraints.maxWidth : constraints.maxHeight;
      return GestureDetector(
        onHorizontalDragStart: widget.interactiveFlipEnabled && isHorizontal
            ? (details) => _handleDragStart(details)
            : null,
        onHorizontalDragUpdate: widget.interactiveFlipEnabled && isHorizontal
            ? (details) => _handleDragUpdate(details, crossAxisLength)
            : null,
        onHorizontalDragEnd: widget.interactiveFlipEnabled && isHorizontal
            ? (details) => _handleDragEnd(details, crossAxisLength)
            : null,
        onVerticalDragStart: widget.interactiveFlipEnabled && !isHorizontal
            ? (details) => _handleDragStart(details)
            : null,
        onVerticalDragUpdate: widget.interactiveFlipEnabled && !isHorizontal
            ? (details) => _handleDragUpdate(details, crossAxisLength)
            : null,
        onVerticalDragEnd: widget.interactiveFlipEnabled && !isHorizontal
            ? (details) => _handleDragEnd(details, crossAxisLength)
            : null,
        child: AnimatedPageFlipBuilder(
            animation: _controller,
            frontBuilder: widget.frontBuilder,
            backBuilder: widget.backBuilder,
            showFrontSide: _showFrontSide,
            flipAxis: widget.flipAxis,
            maxTilt: widget.maxTilt,
            maxScale: widget.maxScale),
      );
    });
  }

  ///Función que cambia el estado de la animación
  void _updateStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed ||
        status == AnimationStatus.dismissed) {
      _controller.value = 0.0;
      setState(() => _showFrontSide = !_showFrontSide);
      if (_wasFrontSide != _showFrontSide) {
        _wasFrontSide = _showFrontSide;
        widget.onFlipComplete?.call(_showFrontSide);
      }
    }
  }

  ///Función que "da la vuelta" al widget
  void flip() {
    _wasFrontSide = _showFrontSide;
    if (_showFrontSide) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void _handleDragStart(DragStartDetails details) {
    _wasFrontSide = _showFrontSide;
  }

  void _handleDragUpdate(DragUpdateDetails details, double crossAxisLength) {
    _controller.value += details.primaryDelta / crossAxisLength;
  }

  void _handleDragEnd(DragEndDetails details, double crossAxisLength) {
    if (_controller.isAnimating ||
        _controller.status == AnimationStatus.completed ||
        _controller.status == AnimationStatus.dismissed) return;

    const velocityThreshold = 2.0;
    final velocity = widget.flipAxis == Axis.horizontal
        ? details.velocity.pixelsPerSecond.dx
        : details.velocity.pixelsPerSecond.dy;
    final flingVelocity = velocity / crossAxisLength;

    if (_controller.value == 0.0 && flingVelocity == 0.0) {
      return;
    }

    if (_controller.value > 0.5 ||
        _controller.value > 0.0 && flingVelocity > velocityThreshold) {
      _controller.fling(velocity: velocityThreshold);
    } else if (_controller.value < -0.5 ||
        _controller.value < 0.0 && flingVelocity < -velocityThreshold) {
      _controller.fling(velocity: -velocityThreshold);
    } else if (_controller.value > 0.0 ||
        _controller.value > 0.5 && flingVelocity < -velocityThreshold) {
      _controller.value -= 1.0;
      setState(() => _showFrontSide = !_showFrontSide);
      _controller.fling(velocity: -velocityThreshold);
    } else if (_controller.value > -0.5 ||
        _controller.value < -0.5 && flingVelocity > velocityThreshold) {
      _controller.value += 1.0;
      setState(() => _showFrontSide = !_showFrontSide);
      _controller.fling(velocity: velocityThreshold);
    }
  }
}
