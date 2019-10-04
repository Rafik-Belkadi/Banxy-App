import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';


class BubblesFadeIn extends StatelessWidget {
  final double delay;
  final Widget child;

  const BubblesFadeIn({Key key, this.delay, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tween =MultiTrackTween([
      Track("opacity")
        .add(Duration(milliseconds: 500), Tween(begin: 0.0,end: 1.0)),
      Track("translateX")
        .add(Duration(milliseconds: 500), Tween(begin: 130.0,end: 0.0), curve: Curves.easeOut),
    ]);

    return ControlledAnimation(
      delay: Duration(milliseconds: (300 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context,child,animation)=> Opacity(
        opacity: animation['opacity'],
        child: Transform.scale(
          scale: animation['opacity'],
          child: child,
        ),
      ),
    );
  }
}

class ListFadeIn extends StatelessWidget {
  final double delay;
  final Widget child;

  const ListFadeIn({Key key, this.delay, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tween =MultiTrackTween([
      Track("opacity")
        .add(Duration(milliseconds: 500), Tween(begin: 0.0,end: 1.0)),
      Track("translateX")
        .add(Duration(milliseconds: 500), Tween(begin: 130.0,end: 0.0), curve: Curves.easeOut),
    ]);

    return ControlledAnimation(
      delay: Duration(milliseconds: (300 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context,child,animation)=> Opacity(
        opacity: animation['opacity'],
        child: Transform.translate(
          offset: Offset(animation['translateX'],0),
          child: child,
        ),
      ),
    );
  }
}

class SimpleFadeIn extends StatelessWidget {
  final double delay;
  final Widget child;

  const SimpleFadeIn({Key key, this.delay, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tween =MultiTrackTween([
      Track("opacity")
        .add(Duration(milliseconds: 500), Tween(begin: 0.0,end: 1.0)),
    ]);

    return ControlledAnimation(
      delay: Duration(milliseconds: (300 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context,child,animation)=> Opacity(
        opacity: animation['opacity'],
        child: child
      ),
    );
  }
}