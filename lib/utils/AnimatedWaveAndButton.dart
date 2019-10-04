import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';
import 'package:simple_animations/simple_animations/multi_track_tween.dart';
import 'dart:convert' as convert;

import '../Discover.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class AnimatedGradientButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const AnimatedGradientButton({Key key, this.title, this.onPressed})
      : super(key: key);

  navigateToDiscover(BuildContext context) async {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => DiscoverPage()));
    var url =
        'http://banxy.appstanast.com/Admin/api/forms/interaction.php?user_id=$user_id';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
    } else {
      print('Failed Interaction');
    }
  }

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("color1").add(Duration(seconds: 3),
          ColorTween(begin: Color(0xFF67217a), end: Color(0xFF0199b0))),
      Track("color2").add(Duration(seconds: 3),
          ColorTween(begin: Color(0xFF0199b0), end: Color(0xFF67217a))),
      
    ]);

    return ControlledAnimation(
        playback: Playback.MIRROR,
        tween: tween,
        duration: tween.duration,
        builder: (context, animation) {
          return GradientButton(
              shapeRadius: BorderRadius.circular(40),
              increaseHeightBy: 100.0,
              increaseWidthBy: 800.0,
              child: Text(
                this.title,
                style: TextStyle(
                    fontSize: 40, color: Colors.white, fontFamily: 'Pluto'),
              ),
              gradient: LinearGradient(
                  begin: FractionalOffset.centerLeft,
                  end: FractionalOffset.centerRight,
                  colors: [animation["color1"], animation["color2"]]),
              callback: this.onPressed);
        });
  }
}

class AnimatedWave extends StatelessWidget {
  final double height;
  final double speed;
  final double offset;
  final Color color;

  AnimatedWave({this.color, this.height, this.speed, this.offset = 0.0});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: height,
        width: constraints.biggest.width,
        child: ControlledAnimation(
            playback: Playback.LOOP,
            duration: Duration(milliseconds: (5000 / speed).round()),
            tween: Tween(begin: 0.0, end: 2 * pi),
            builder: (context, value) {
              return CustomPaint(
                foregroundPainter: CurvePainter(color, value + offset),
              );
            }),
      );
    });
  }
}

class CurvePainter extends CustomPainter {
  final double value;
  final Color color;

  CurvePainter(this.color, this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final white = Paint()..color = color.withAlpha(70);
    final path = Path();

    final y1 = sin(value);
    final y2 = sin(value + pi / 2);
    final y3 = sin(value + pi);

    final startPointY = size.height * (0.5 + 0.4 * y1);
    final controlPointY = size.height * (0.5 + 0.4 * y2);
    final endPointY = size.height * (0.5 + 0.4 * y3);

    path.moveTo(size.width * 0, startPointY);
    path.quadraticBezierTo(
        size.width * 0.5, controlPointY, size.width, endPointY);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, white);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
