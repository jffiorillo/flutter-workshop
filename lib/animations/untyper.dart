import 'package:flutter/widgets.dart';

class UntyperAnimation extends StatefulWidget {
  /// List of [String] that would be displayed subsequently in the animation.
  final List<String> text;

  /// Represent the time each text is going to be displayed.
  final Duration duration;

  /// Represent the time the transitions animation takes.
  final Duration transitionDuration;

  /// Represent the time that all animations are going to take.
  /// Note: The last text is not animated, so that's why is not taken into
  /// account.
  final Duration _totalDuration;

  /// Gives [TextStyle] to the text strings.
  final TextStyle textStyle;

  /// Adds [TextAlign] property to the text in the widget.
  /// By default it is set to [TextAlign.start]
  final TextAlign textAlign;

  final int _totalAnimations;

  const UntyperAnimation({
    Key key,
    @required this.text,
    @required this.transitionDuration,
    this.duration,
    this.textStyle,
    this.textAlign = TextAlign.start,
  })  : assert(text.length > 1),
        _totalAnimations = text.length - 1,
        _totalDuration = duration * (text.length - 1) +
            transitionDuration * (text.length - 1),
        super(key: key);

  @override
  UntyperAnimationState createState() => new UntyperAnimationState();
}

class UntyperAnimationState extends State<UntyperAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  List animations = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget._totalDuration,
      vsync: this,
    );
    final double textDuration =
        widget.duration.inMicroseconds / widget._totalDuration.inMicroseconds;
    double percentTimeCount = textDuration;
    final double transitionDuration = widget.transitionDuration.inMicroseconds /
        widget._totalDuration.inMicroseconds;
    for (int i = 0; i < widget._totalAnimations; i++) {
      final text = widget.text[i];
      animations.add([
        StepTween(begin: text.length, end: 0).animate(CurvedAnimation(
          parent: _controller,
          curve: Interval(
              percentTimeCount, percentTimeCount + transitionDuration,
              curve: Curves.linear),
        )),
        Tween(begin: 1.0, end: 0.0).animate(new CurvedAnimation(
            parent: _controller,
            curve: Interval(
                percentTimeCount, percentTimeCount + transitionDuration,
                curve: Curves.easeIn))),
        text
      ]);
      percentTimeCount = percentTimeCount + textDuration + transitionDuration;
    }

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: _controller,
    builder: (BuildContext context, Widget child) {
      final int index = (_controller.value * animations.length).floor();
      return (index < animations.length)
          ? _buildElementAt(index)
          : Text(
        widget.text.last,
        style: widget.textStyle,
        textAlign: widget.textAlign,
      );
    },
  );

  Widget _buildElementAt(index) {
    final elements = animations[index];
    final Animation typingAnimation = elements[0];
    final Animation opacityAnimation = elements[1];
    final String text = elements[2];
    return Opacity(
      opacity: opacityAnimation.value,
      child: Text(
        text.substring(0, typingAnimation.value),
        style: widget.textStyle,
        textAlign: widget.textAlign,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
