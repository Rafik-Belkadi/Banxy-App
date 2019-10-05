import 'package:banxy/utils/AnimatedWaveAndButton.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'Discover.dart';
import 'Form.dart';
import 'Home.dart';
import 'colors.dart';
import 'animations/fade_in.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

class DetailsPage extends StatefulWidget {
  final int index;
  DetailsPage({Key key, @required this.index}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final List<String> _listViewData = [
    "GESTION 100% MOBILE",
    "AVANTAGES INÉDITS",
    "DEUX FORMULES ADAPTÉES À VOS BESOINS",
    "TOUJOURS À VOTRE ÉCOUTE"
  ];
  List<List<RichText>> details = [
    [
      RichText(
          text: TextSpan(
              style: TextStyle(
                  color: Color(0xFF364c61),
                  fontSize: 25,
                  fontFamily: 'RobotoMedium'),
              children: <TextSpan>[
            TextSpan(
                text:
                    "Avec Banxy,  gérez votre carte depuis votre smartphone "),
          ])),
      RichText(
          text: TextSpan(
              style: TextStyle(
                color: Color(0xFF364c61),
                fontSize: 25,
                fontFamily: "RobotoMedium",
                fontWeight: FontWeight.w900,
              ),
              children: <TextSpan>[
            TextSpan(
              text: "Suivez instantanément et en temps réel vos transactions",
            )
          ])),
      RichText(
          text: TextSpan(
              style: TextStyle(
                  color: Color(0xFF364c61),
                  fontSize: 25,
                  fontFamily: 'RobotoMedium'),
              children: <TextSpan>[
            TextSpan(text: "Personnalisez vos plafonds."),
          ])),
      RichText(
          text: TextSpan(
              style: TextStyle(
                color: Color(0xFF364c61),
                fontSize: 25,
                fontFamily: "RobotoMedium",
                fontWeight: FontWeight.w900,
              ),
              children: <TextSpan>[
            TextSpan(
              text: "Bloquez et débloquez ",
            ),
            TextSpan(
                text: "votre carte temporairement.",
                style: TextStyle(fontWeight: FontWeight.normal)),
          ])),
      RichText(
          text: TextSpan(
              style: TextStyle(
                  color: Color(0xFF364c61),
                  fontSize: 25,
                  fontFamily: 'RobotoMedium'),
              children: <TextSpan>[
            TextSpan(
                text:
                    "Faites une opposition définitive ou demandez une réédition de votre mot de passe."),
          ])),
    ],
    [
      RichText(
          text: TextSpan(
              style: TextStyle(
                  color: Color(0xFF364c61),
                  fontSize: 25,
                  fontFamily: 'RobotoMedium'),
              children: <TextSpan>[
            TextSpan(text: "Banxy vous offre "),
            TextSpan(
                text: "d’autres services complémentaires ",
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: "pour profiter des avantages inédits"),
          ])),
      RichText(
          text: TextSpan(
              style: TextStyle(
                color: Color(0xFF364c61),
                fontSize: 25,
                fontFamily: "RobotoMedium",
              ),
              children: <TextSpan>[
            TextSpan(
              text: "Optez pour l’offre Épargne et profitez ",
            ),
            TextSpan(
                text: "d’une exonération de frais annuels ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            TextSpan(
              text: "sur votre carte, ",
            ),
          ])),
      RichText(
          text: TextSpan(
              style: TextStyle(
                  color: Color(0xFF364c61),
                  fontSize: 25,
                  fontFamily: 'RobotoMedium',
                  fontWeight: FontWeight.bold),
              children: <TextSpan>[
            TextSpan(text: "Cumulez vos plafonds de retrait et de paiement. "),
          ])),
      RichText(
          text: TextSpan(
              style: TextStyle(
                color: Color(0xFF364c61),
                fontSize: 25,
                fontFamily: "RobotoMedium",
              ),
              children: <TextSpan>[
            TextSpan(text: "Recevez votre carte "),
            TextSpan(
                text: "Gold ou Platinum en ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            TextSpan(
                text: "4 jours* \n",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            TextSpan(
                text:
                    "*délais en jours ouvrés pour les clients disposant déjà d’un compte Banxy.",
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14)),
          ])),
      RichText(
          text: TextSpan(
              style: TextStyle(
                  color: Color(0xFF364c61),
                  fontSize: 25,
                  fontFamily: 'RobotoMedium'),
              children: <TextSpan>[
            TextSpan(
                text: "Une assurance voyage vous est offerte ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
          ])),
    ],
    [
      RichText(
          text: TextSpan(
              style: TextStyle(
                  color: Color(0xFF364c61),
                  fontSize: 25,
                  fontFamily: 'RobotoMedium'),
              children: <TextSpan>[
            TextSpan(
                text:
                    "Avec Banxy,  gérez votre carte depuis votre smartphone "),
          ])),
      RichText(
          text: TextSpan(
              style: TextStyle(
                color: Color(0xFF364c61),
                fontSize: 25,
                fontFamily: "RobotoMedium",
                fontWeight: FontWeight.bold,
              ),
              children: <TextSpan>[
            TextSpan(
              text: "Suivez instantanément et en temps réel.",
            )
          ])),
      RichText(
          text: TextSpan(
              style: TextStyle(
                  color: Color(0xFF364c61),
                  fontSize: 25,
                  fontFamily: 'RobotoMedium'),
              children: <TextSpan>[
            TextSpan(text: "Personnalisez vos plafonds."),
          ])),
      RichText(
          text: TextSpan(
              style: TextStyle(
                color: Color(0xFF364c61),
                fontSize: 25,
                fontFamily: "RobotoMedium",
                fontWeight: FontWeight.bold,
              ),
              children: <TextSpan>[
            TextSpan(
              text: "Bloquez et débloquez ",
            ),
            TextSpan(
                text: "votre carte temporairement.",
                style: TextStyle(fontWeight: FontWeight.normal)),
          ])),
      RichText(
          text: TextSpan(
              style: TextStyle(
                  color: Color(0xFF364c61),
                  fontSize: 25,
                  fontFamily: 'RobotoMedium'),
              children: <TextSpan>[
            TextSpan(
                text:
                    "Faites une opposition définitive ou demandez une réédition de votre mot de passe."),
          ])),
    ],
    [
      RichText(
          text: TextSpan(
              style: TextStyle(
                  color: Color(0xFF364c61),
                  fontSize: 25,
                  fontFamily: 'RobotoMedium'),
              children: <TextSpan>[
            TextSpan(
                text:
                    "Avec Banxy,  gérez votre carte depuis votre smartphone "),
          ])),
      RichText(
          text: TextSpan(
              style: TextStyle(
                color: Color(0xFF364c61),
                fontSize: 25,
                fontFamily: "RobotoMedium",
                fontWeight: FontWeight.bold,
              ),
              children: <TextSpan>[
            TextSpan(
              text: "Suivez instantanément et en temps réel.",
            )
          ])),
      RichText(
          text: TextSpan(
              style: TextStyle(
                  color: Color(0xFF364c61),
                  fontSize: 25,
                  fontFamily: 'RobotoMedium'),
              children: <TextSpan>[
            TextSpan(text: "Personnalisez vos plafonds."),
          ])),
      RichText(
          text: TextSpan(
              style: TextStyle(
                color: Color(0xFF364c61),
                fontSize: 25,
                fontFamily: "RobotoMedium",
                fontWeight: FontWeight.bold,
              ),
              children: <TextSpan>[
            TextSpan(
              text: "Bloquez et débloquez ",
            ),
            TextSpan(
                text: "votre carte temporairement.",
                style: TextStyle(fontWeight: FontWeight.normal)),
          ])),
      RichText(
          text: TextSpan(
              style: TextStyle(
                  color: Color(0xFF364c61),
                  fontSize: 25,
                  fontFamily: 'RobotoMedium'),
              children: <TextSpan>[
            TextSpan(
                text:
                    "Faites une opposition définitive ou demandez une réédition de votre mot de passe."),
          ])),
    ],
  ];
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();

    _selectedIndex = widget.index;
  }

  _onSelected(int index) async{
    setState(() {
      _selectedIndex = index;
    });
            
      var url =
          'http://banxy.appstanast.com/Admin/api/forms/interact.php?user_id=$user_id&interaction=$index';
      var response = await http.get(url);
      if (response.statusCode == 200) {
        print('success');
      } else {
        print('Failed Interaction');
      }
    
  }

  onTop(Widget child) => Positioned(
        child: Align(
          child: child,
          alignment: Alignment.topRight,
        ),
      );

  onBottom(Widget child) => Positioned(
    bottom: 200,
    right: 170,
        child: Align(
          child: child,
        ),
      );
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () => _navigateHome(context),
              ),
              backgroundColor: secondaryColor,
            ),
            body: Stack(
              children: <Widget>[
                Positioned(
                    top: 40,
                    height: 500,
                    width: 600,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                            color: secondaryBoldTextColor,
                            height: 20,
                          ),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _listViewData.length,
                      itemBuilder: (context, index) => Container(
                            child: _selectedIndex != null &&
                                    _selectedIndex == index
                                ? buildSelectedListTile(index)
                                : buildListTile(index),
                          ),
                    )),
                buildBottomLeft(context),
                new DetailList(
                  details: details[_selectedIndex],
                  index: _selectedIndex,
                ),
                onTop(Container(
                  margin: EdgeInsets.all(20),
                  child: Image.asset(
                    'assets/natixis.png',
                    scale: 1.5,
                  ),
                )),
                _selectedIndex == 3 ? 
                onBottom(AnimatedGradientButton(
                      title: "Rejoignez la communauté Banxy",
                      onPressed: () => _navigateForm(context),
                    ),) : Container()
              ],
            )),
        behavior: HitTestBehavior.translucent,
        onTapDown: (tapdown) {
          print("down");
          if (timer != null) {
            timer.cancel();
          }
          timer = startTimeout();
        });
  }

  startTimeout([int milliseconds]) {
    var duration = milliseconds == null ? timeout : ms * milliseconds;
    return new Timer(duration, handleTimeout);
  }

  void handleTimeout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
    );
  }

  ListTile buildListTile(int index) {
    print(index);
    return ListTile(
      onTap: () => _onSelected(index),
      title: Text(
        _listViewData[index],
        style: TextStyle(
            color: Color(0xFF364c61),
            fontSize: 25,
            fontWeight: FontWeight.w700),
      ),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: secondaryColor,
      ),
    );
  }

  Widget buildSelectedListTile(int index) {
    return SimpleFadeIn(
      delay: 0.3,
      child: Container(
        padding: EdgeInsets.all(5.0),
        width: 600,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset.centerLeft,
                end: FractionalOffset.centerRight,
                stops: [0, 1.0],
                colors: [Color(0xFFdff2f5), secondaryBoldTextColor])),
        child: Container(
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: secondaryColor,
          ),
          child: ListTile(
            trailing: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.white,
            ),
            onTap: () => _onSelected(index),
            title: Text(
              _listViewData[index],
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ),
    );
  }

  
}

// ------------------------------------------------------------------------
Stack buildBottomLeft(BuildContext context) {
  return Stack(
    children: <Widget>[
      Positioned(
        left: -120,
        bottom: -120,
        child: Container(
          width: 400,
          height: 350,
          decoration:
              BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        ),
      ),
      Positioned(
          bottom: 0,
          child: Container(
              child: FlatButton(
                  onPressed: () => _navigateHome(context),
                  child: Image.asset(
                    'assets/logo.png',
                    width: 200,
                    height: 200,
                  ))))
    ],
  );
}

// Navitation to homePage
_navigateHome(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => DiscoverPage()));
}

_navigateForm(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => FormPage()));
}

class MyBullet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 15.0,
      width: 15.0,
      decoration: new BoxDecoration(
        color: secondaryColor,
        shape: BoxShape.circle,
      ),
    );
  }
}

class DetailList extends StatefulWidget {
  final List<RichText> details;
  final int index;

  DetailList({Key key, this.details, this.index});

  @override
  _DetailListState createState() => _DetailListState();
}

class _DetailListState extends State<DetailList> {
  GlobalKey<FlipCardState> cardKeyOne = new GlobalKey<FlipCardState>();
  GlobalKey<FlipCardState> cardKeyTwo = new GlobalKey<FlipCardState>();

  Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        cardKeyOne.currentState.toggleCard();
        cardKeyTwo.currentState.toggleCard();
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<ListTile> myList = [];

    if (widget.index == 2) {
      return Positioned(
          top: 80,
          left: 700,
          height: 500,
          width: 550,
          child: Center(
            child: SimpleFadeIn(
                delay: 0.5,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: Container(
                            height: 40,
                            
                            child: FlipCard(
                              key: cardKeyOne,
                              flipOnTouch: false,
                              front: Icon(
                                Icons.repeat,
                                color: Colors.black26,
                              ),
                              back: Icon(
                                Icons.repeat,
                                color: Colors.black26,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            height: 40,
                            child: FlipCard(
                              key: cardKeyTwo,
                              flipOnTouch: false,
                              front: Icon(
                                Icons.repeat,
                                color: Colors.black26,
                              ),
                              back: Icon(
                                Icons.repeat,
                                color: Colors.black26,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 420,
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: FlipCard(
                              direction: FlipDirection.HORIZONTAL, // default
                              front: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/Cards/Gold-Libre.png'),
                                      fit: BoxFit.fill,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0)),
                              
                              ),

                              back: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/Cards/Gold-epargne.png'),
                                      fit: BoxFit.fill,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0)),
                              
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: FlipCard(
                              direction: FlipDirection.HORIZONTAL, // default
                              front: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/Cards/Platinum-Libre.png'),
                                    fit: BoxFit.fill,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                               
                              ),

                              back: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/Cards/Platinum-epargne.png'),
                                      fit: BoxFit.fill,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0)),
                             
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                        "(*)sous réserve du maintien du niveau d’épargne exigé",
                        style: TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 14)),
                  ],
                )),
          ));
    }
    if (widget.index == 3) {
      return Positioned(
          top: -20,
          left: 700,
          height: 500,
          width: 550,
          child: Center(
              child: Row(
            children: <Widget>[
              Container(
                width: 350,
                child: RichText(
                  text: TextSpan(
                      style: TextStyle(color: Color(0xFF364c61), fontSize: 27),
                      children: [
                        TextSpan(
                            text:
                                "Notre Centre de Relation Client est disponible "),
                        TextSpan(
                            text: '24h/24 & 7j/7 ',
                            style: TextStyle(
                                color: primaryBoldTextColor,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                "pour vous assister partout, où que vous soyez.")
                      ]),
                ),
              ),
              Container(
                width: 200,
                child: Image.asset(
                  "assets/Picto.png",
                  scale: 1.9,
                ),
              )
            ],
          )));
    } else {
      for (var i = 0; i < widget.details.length; i++) {
        if (i == 0) {
          myList.add(
            ListTile(
                contentPadding: EdgeInsets.only(bottom: 5),
                title: widget.details[0]),
          );
        } else if (i == 1) {
          myList.add(
            ListTile(
                contentPadding: EdgeInsets.only(top: 10, left: 15),
                leading: MyBullet(),
                title: widget.details[1]),
          );
        } else {
          myList.add(ListTile(
            leading: MyBullet(),
            title: widget.details[i],
          ));
        }
      }
      return Positioned(
        top: 130,
        left: 700,
        height: 500,
        width: 550,
        child: ListView.builder(
          itemCount: myList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListFadeIn(delay: index * 0.7, child: myList[index]);
          },
        ),
      );
    }
  }
}
