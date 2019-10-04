import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';


class SlideInAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const SlideInAnimation({Key key, this.delay, this.child}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("translateX")
        .add(Duration(milliseconds: 500), Tween(begin: -200.0,end: 0.0), curve: Curves.easeOut)
    ]);
    return ControlledAnimation(
      delay: Duration(milliseconds: (300 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context,child,animation)=> Transform.translate(
        offset: Offset(animation['translateX'], 0.0),
        child: child,
      ),
    );
  }
}