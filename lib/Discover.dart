import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Details.dart';
import 'Form.dart';
import 'Home.dart';

import 'dart:async';
import 'utils/AnimatedWaveAndButton.dart';

const timeout = const Duration(seconds: 180);
const ms = const Duration(milliseconds: 1);
Timer timer;

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

// Building the UI
// ------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          body: Stack(
            children: <Widget>[
              onTop(Container(
                margin: EdgeInsets.all(20),
                child: Image.asset(
                  'assets/natixis.png',
                  scale: 1.5,
                ),
              )),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AnimatedGradientButton(
                      title: "Rejoignez la communauté Banxy",
                      onPressed: () => _navigateForm(context),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    AnimatedGradientButton(
                      title: "Découvrez la carte VISA par Excellence",
                      onPressed: () => _navigateToDetails(context, 0),
                    ),
                    SizedBox(
                      height: 80.0,
                    ),
                  ],
                ),
              ),
              onBottom(
                  AnimatedWave(height: 180, speed: 1.0, color: Colors.grey)),
              onBottom(AnimatedWave(
                height: 120,
                speed: 0.9,
                offset: pi,
                color: Colors.grey,
              )),
              onBottom(AnimatedWave(
                height: 220,
                speed: 1.2,
                offset: pi / 2,
                color: Colors.grey,
              )),
            ],
          ),
        ),
        behavior: HitTestBehavior.translucent,
        onTapDown: (tapdown) {
          print("down");
          if (timer != null) {
            timer.cancel();
          }
          timer = startTimeout();
        });
  }

// Different functions for logic :
// ------------------------------------------------------------------------
  

// ------------------------------------------------------------------------
  startTimeout([int milliseconds]) {
    var duration = milliseconds == null ? timeout : ms * milliseconds;
    return new Timer(duration, handleTimeout);
  }

// ------------------------------------------------------------------------
  void handleTimeout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
    );
  }

  onTop(Widget child) => Positioned(
        child: Align(
          child: child,
          alignment: Alignment.topRight,
        ),
      );

// ------------------------------------------------------------------------

  onBottom(Widget child) => Positioned(
        child: Align(child: child, alignment: Alignment.bottomCenter),
      );

// ------------------------------------------------------------------------
  _navigateToDetails(BuildContext context, int index) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DetailsPage(
              index: index,
            )));
  }

//------------------------------------------------------------------------
  _navigateForm(BuildContext context) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => FormPage()));
  }
}
