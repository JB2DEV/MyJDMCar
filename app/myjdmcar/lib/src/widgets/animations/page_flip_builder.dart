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

  /// This is called when a flip transition has completed (whether interactive or not).
  /// It is only called when the page actually flips, not if the user cancels the interactive transition.
  final void Function(bool) onFlipComplete;

  @override
  PageFlipBuilderState createState() => PageFlipBuilderState();
}

class PageFlipBuilderState extends State<PageFlipBuilder>
    with SingleTickerProviderStateMixin {
  // which side is currently shown
  bool _showFrontSide = true;
  // whether the front side was shown before the transition started
  bool _wasFrontSide = true;
  AnimationController _controller;

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

    // if value and velocity are 0, the gesture was a tap so we return early
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
      // controller can't fling to 0.0 because the lowerBound is -1.0
      // so we decrement the value by 1.0 and toggle the state to get the same effect
      _controller.value -= 1.0;
      setState(() => _showFrontSide = !_showFrontSide);
      _controller.fling(velocity: -velocityThreshold);
    } else if (_controller.value > -0.5 ||
        _controller.value < -0.5 && flingVelocity > velocityThreshold) {
      // controller can't fling to 0.0 because the upperBound is 1.0
      // so we increment the value by 1.0 and toggle the state to get the same effect
      _controller.value += 1.0;
      setState(() => _showFrontSide = !_showFrontSide);
      _controller.fling(velocity: velocityThreshold);
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.nonInteractiveAnimationDuration,
      // lowerBound of -1.0 is needed for the back flip
      lowerBound: -1.0,
      // upperBound of 1.0 is needed for the front flip
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

  void _updateStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed ||
        status == AnimationStatus.dismissed) {
      // The controller always completes a forward animation with value 1.0
      // and a reverse animation with a value of -1.0.
      // By resetting the value to 0.0 and toggling the state
      // we are preparing the controller for the next animation
      // while preserving the widget appearance on screen.
      _controller.value = 0.0;
      setState(() => _showFrontSide = !_showFrontSide);
      if (_wasFrontSide != _showFrontSide) {
        _wasFrontSide = _showFrontSide;
        widget.onFlipComplete?.call(_showFrontSide);
      }
    }
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
}
