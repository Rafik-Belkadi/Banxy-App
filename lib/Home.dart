import 'package:banxy/utils/SwipeButton.dart';
import 'package:shimmer/shimmer.dart';

import 'colors.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'Discover.dart';
import 'package:video_player/video_player.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    _controller = VideoPlayerController.asset(
        "assets/vid.mp4")
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        _controller.setVolume(0);
        // Ensure the first frame is shown after the video is initialized
      });
  }

 

  _navigateToDiscover(BuildContext context) async {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => DiscoverPage()));
    _controller.pause();
    var url =
        'http://banxy.appstanast.com/Admin/api/forms/interaction.php?user_id=$user_id';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
    } else {
      print('Failed Interaction');
    }
    dispose();
  }

  Widget buildBottomRight(BuildContext context) {
    var swipePosition = SwipePosition.SwipeLeft;
    return Positioned(
      top: 80,
      right: 30,
      child: Align(
        alignment: Alignment.bottomRight,
        child: SwipeButton(
            onTap: () => _navigateToDiscover(context),
            initialPosition: swipePosition,
            borderRadius: BorderRadius.circular(50.0),
            width: 500,
            height: 100,
            backgroundColor: secondaryColor.withAlpha(80),
            thumbColor: secondaryColor,
            thumb: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (var i = 0; i < 3; i++)
                          Icon(Icons.chevron_right,
                              size: 30.0, color: Colors.white),
                      ],
                    ))
              ],
            ),
            content: Center(
                child: Shimmer.fromColors(
                    baseColor: primaryColor,
                    highlightColor: Colors.white,
                    child: FlatButton(
                      onPressed: () => _navigateToDiscover(context),
                      child: Text(
                        'Passer la vidéo',
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: 35,
                            fontFamily: 'Pluto'),
                      ),
                    ))),
            onChanged: (result) {
              _navigateToDiscover(context);
              setState(() {
                swipePosition = SwipePosition.SwipeLeft;
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => _navigateToDiscover(context),
      child: Stack(
        children: <Widget>[
          Container(
            height: 1200.0,
            width: 1280.0,
            child: VideoPlayer(_controller),
          ),
          buildBottomRight(context)
        ],
      ),
    );
  }
   @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
