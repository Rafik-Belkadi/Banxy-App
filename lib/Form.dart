import 'package:flutter/material.dart';
import 'main.dart';
import 'Home.dart';
import 'Discover.dart';
import 'colors.dart';
import 'dart:async';
import 'utils/BeautyTextField.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:validators/validators.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
// Different functions for logic :
// ------------------------------------------------------------------------
  _navigateHome(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => DiscoverPage()));
  }

  onTop(Widget child) => Positioned(
        child: Align(
          child: child,
          alignment: Alignment.topRight,
        ),
      );
//------------------------------------------------------------------------

// Building the UI
// ------------------------------------------------------------------------
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool isCheckedMme = false;
  bool isCheckedM = false;
  bool _visible = true;

  final _emailController = new TextEditingController();
  final _phoneController = new TextEditingController();
  final _nomController = new TextEditingController();
  final _prenomController = new TextEditingController();

  bool _autoValidateForm = false;

  bool _isEmailValid = false;
  bool _isMobileValid = false;
  bool _isNomValid = false;
  bool _isPrenomValid = false;
  bool _isFormValid = false;
  bool _checking = false;

  String emailErr = "";
  String phoneErr = "";

  String nom;
  String prenom;
  String civilite;
  String email;
  String mobile;
  Widget checkboxError;

  String nomError() {
    _nomController.clear();
    return 'Nom Invalide';
  }

  String prenomError() {
    _prenomController.clear();
    return 'Prenom Invalide';
  }

  void validateNom(String string) {
    if (isAlpha(string) && string.length > 2) {
      nom = string;
    } else {
      _isNomValid = true;
    }
    _visible = true;
  }

  void validatePrenom(String string) {
    if (isAlpha(string) && string.length > 2) {
      prenom = string;
    } else {
      _isPrenomValid = true;
    }
    _visible = true;
  }

  Future<bool> validateEmail(String string) async {
    
    setState(() {
      _visible = true;

      if (string.isEmpty) {
        _isEmailValid = true;
        emailErr = "Email Can't be empty";
      } else if (!EmailValidator.validate(string)) {
        _isEmailValid = true;
        emailErr = "Email is Invalid, please try again.";
        _emailController.clear();
      } else {
        email = string;
        _isEmailValid = false;
      }
    });
    return _isEmailValid;
  }

  void validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      setState(() {
        _isMobileValid = true;
        
        phoneErr = 'Please enter mobile number';
      });
    } else if (!regExp.hasMatch(value)) {
      setState(() {
        _isMobileValid = true;
        _phoneController.clear();
        phoneErr = 'Please enter valid mobile number';
      });
    } else {
      if (value.substring(0, 1) == '0') {
        mobile = '+213' + value.substring(1);
      }
    }
  }

  bool validateCheckBox() {
    if (!isCheckedM && !isCheckedMme) {
      _showSnackBar('Veuillez entrer votre civilité');
      return true;
    } else {
      setState(() => checkboxError = null);
      if (isCheckedM) {
        civilite = "Homme";
      } else {
        civilite = "Femme";
      }
      return false;
    }
  }

  validateForm() async {
    setState(() {
      _checking = true;
    });
    validateCheckBox();
    validateNom(_nomController.text);
    validatePrenom(_prenomController.text);
    await validateEmail(_emailController.text);
    validateMobile(_phoneController.text);
    if (_isEmailValid ||
        _isMobileValid ||
        _isNomValid ||
        _isPrenomValid ||
        validateCheckBox()) {
      print("Formulaire incorrect");

      _isNomValid ? _nomController.clear() : null;
      _isPrenomValid ? _prenomController.clear() : null;
      _isEmailValid ? _emailController.clear() : null;
      _isMobileValid ? _phoneController.clear() : null;
      validateCheckBox() ? isCheckedM = false : null;
      validateCheckBox() ? isCheckedMme = false : null;
      _isFormValid = true;
      _checking = false;
      return true;
    }
    _isFormValid = false;
    return false;
  }

  void sendToServer() async {
    validateCheckBox();
    validateNom(_nomController.text);
    validatePrenom(_prenomController.text);
    validateEmail(_emailController.text);
    validateMobile(_phoneController.text);

    if (_formKey.currentState.validate()) {
      if (_isEmailValid ||
          _isMobileValid ||
          _isNomValid ||
          _isPrenomValid ||
          validateCheckBox()) {
        print("Formulaire incorrect");
        _nomController.clear();
        _prenomController.clear();
        _emailController.clear();
        _phoneController.clear();
        isCheckedM = false;
        isCheckedMme = false;
      } else {
        _formKey.currentState.save();
        print("civ : $civilite");
        print("Name $nom");
        print("prenom $prenom");
        print("Mobile $mobile");
        print("Email $email");

        var url = 'http://banxy.appstanast.com/Admin/api/forms/create.php';
        var response = await http.post(url, body: """ 
          {
            "user_id": $user_id,
            "first_name": "$prenom",
            "last_name": "$nom",
            "email":"$email",
            "civilite":"$civilite",
            "mobile":"$mobile"
          }
          """, headers: {"Content-type": "application/json"});

        if (response.statusCode == 200) {
          var jsonResponse = convert.jsonDecode(response.body);
          print(jsonResponse);
        } else {
          print(response.statusCode);
        }
        timer = startTimeout(5000);

        setState(() {
          _nomController.clear();
          _prenomController.clear();
          _emailController.clear();
          _phoneController.clear();
          isCheckedM = false;
          isCheckedMme = false;
        });
      }
    } else {
      // validation error
      setState(() => _autoValidateForm = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
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
        key: _scaffoldKey,
        backgroundColor: Color(0xFFf3f3f3),
        body: Stack(
          children: <Widget>[
            Positioned(
              left: 50,
              top: 20,
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  child: AnimatedOpacity(
                    opacity: _visible ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 300),
                    child: Text(
                        'REJOIGNEZ LA COMMUNAUTÉ \nBANXY ET RESTEZ INFORMÉS',
                        style: TextStyle(
                            color: secondaryBoldTextColor,
                            fontSize: 40,
                            fontWeight: FontWeight.w800)),
                  ),
                ),
              ),
            ),
            Container(margin: EdgeInsets.only(top: 40), child: myForm()),
            AnimatedOpacity(
              duration: Duration(milliseconds: 300),
              opacity: _visible ? 1.0 : 0.0,
              child: buildBottomLeft(context),
            ),
            onTop(Container(
              margin: EdgeInsets.all(20),
              child: Image.asset(
                'assets/natixis.png',
                scale: 1.5,
              ),
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
      },
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        setState(() {
          _visible = true;
        });
      },
    );
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

  // ------------------------------------------------------------------------

  //  UI Functions :
  // ------------------------------------------------------------------------

  Stack buildBottomRight(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
            child: Container(
          margin: EdgeInsets.only(top: 20),
          height: 60,
          width: 280,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset.centerLeft,
                end: FractionalOffset.centerRight,
                stops: [
                  0,
                  0.5,
                  1
                ],
                colors: [
                  Color(0xFF48c6d4),
                  Color(0xFF02a3b5),
                  Color(0xFF48c6d4),
                ]),
            border: Border.all(color: Color(0xFF82e1f5), width: 5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: FlatButton(
            onPressed: ()async {
              await validateForm();
              setState(() => _checking =true);
              if (_isFormValid) {
                setState(() {
                  _checking=false;
                });
                return null;
              } else {
                showPopup();
              }
            },
            child: Text(
              'VALIDER MES INFORMATIONS',
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
        ))
      ],
    );
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
                BoxDecoration(color: Color(0xFFffffff), shape: BoxShape.circle),
          ),
        ),
        Positioned(
            bottom: 0,
            child: Container(
                child: FlatButton(
                    splashColor: primaryColor,
                    onPressed: () => _navigateHome(context),
                    child: Image.asset(
                      'assets/logo.png',
                      width: 200,
                      height: 200,
                    ))))
      ],
    );
  }

  Widget myForm() {
    return ModalProgressHUD(
          inAsyncCall: _checking,
          child: Form(
        key: _formKey,
        autovalidate: _autoValidateForm,
        child: new ListView(
          padding: const EdgeInsets.only(top: 100.0, left: 300),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Civilité',
                        style: TextStyle(
                            color: Color(0xFF2f455a),
                            fontSize: 25,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'Nom   ',
                        style: TextStyle(
                            color: Color(0xFF2f455a),
                            fontSize: 25,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      Text(
                        'Prénom',
                        style: TextStyle(
                            color: Color(0xFF2f455a),
                            fontSize: 25,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      Text(
                        'E-mail',
                        style: TextStyle(
                            color: Color(0xFF2f455a),
                            fontSize: 25,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      Text(
                        'Mobile',
                        style: TextStyle(
                            color: Color(0xFF2f455a),
                            fontSize: 25,
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 60,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(width: 30,),
                          Flexible(
                            child: Transform.scale(
                              alignment: Alignment.centerRight,
                              scale: 2.0,
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  unselectedWidgetColor: Colors.grey,
                                ),
                                child: new Checkbox(
                                  value: isCheckedM,
                                  onChanged: (bool value) {
                                    setState(() {
                                      isCheckedM = value;
                                      isCheckedMme = !value;
                                    });
                                  },
                                  activeColor: secondaryColor,
                                ),
                              ),
                            ),
                          ),
                       
                          Text(
                            'M.',
                            style: TextStyle(
                                color: Color(0xFF2f455a),
                                fontSize: 25,
                                fontWeight: FontWeight.w800),
                          ),
                       SizedBox(width: 60,),
                          Flexible(
                            child: Transform.scale(
                              alignment: Alignment.centerRight,
                              scale: 2.0,
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  unselectedWidgetColor: Colors.grey,
                                ),
                                child: new Checkbox(
                                  value: isCheckedMme,
                                  onChanged: (bool value) {
                                    setState(() {
                                      isCheckedMme = value;
                                      isCheckedM = !value;
                                    });
                                  },
                                  activeColor: secondaryColor,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            'MME.',
                            style: TextStyle(
                                color: Color(0xFF2f455a),
                                fontSize: 25,
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          width: 500,
                          child: BeautyTextfield(
                            controller: _nomController,
                            textColor: Colors.black,
                            width: 500,
                            inputType: TextInputType.text,
                            prefixIcon: Icon(Icons.person),
                            height: 60,
                            backgroundColor: Color(0xFFe9e9e9),
                            cornerRadius: BorderRadius.circular(15),
                            placeholder: '',
                            errorText: _isNomValid ? nomError() : null,
                            onTap: () {
                              setState(() {
                                _visible = false;
                                _isNomValid = false;
                              });
                            },
                            onSubmitted: (string) =>
                                validateNom(_nomController.text),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          width: 500,
                          child: new BeautyTextfield(
                              controller: _prenomController,
                              textColor: Colors.black,
                              width: 500,
                              inputType: TextInputType.text,
                              prefixIcon: Icon(Icons.person),
                              height: 60,
                              backgroundColor: Color(0xFFe9e9e9),
                              cornerRadius: BorderRadius.circular(15),
                              placeholder: '',
                              errorText: _isPrenomValid ? prenomError() : null,
                              onTap: () {
                                setState(() {
                                  _visible = false;
                                  _isPrenomValid = false;
                                });
                              },
                              onSubmitted: (string) =>
                                  validatePrenom(_prenomController.text))),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          width: 500,
                          child: BeautyTextfield(
                            controller: _emailController,
                            textColor: Colors.black,
                            width: 500,
                            inputType: TextInputType.emailAddress,
                            prefixIcon: Icon(Icons.email),
                            height: 60,
                            backgroundColor: Color(0xFFe9e9e9),
                            cornerRadius: BorderRadius.circular(15),
                            placeholder: '',
                            errorText: _isEmailValid ? emailErr : null,
                            onTap: () {
                              setState(() {
                                _isEmailValid = false;
                                _visible = false;
                                _emailController.clear();
                              });
                            },
                            onSubmitted: (string) =>
                                validateEmail(_emailController.text),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          width: 500,
                          child: BeautyTextfield(
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly,
                              ],
                              controller: _phoneController,
                              textColor: Colors.black,
                              width: 500,
                              inputType: TextInputType.number,
                              prefixIcon: Icon(Icons.phone),
                              height: 60,
                              backgroundColor: Color(0xFFe9e9e9),
                              cornerRadius: BorderRadius.circular(15),
                              placeholder: '',
                              errorText: _isMobileValid ? phoneErr : null,
                              onTap: () {
                                setState(() {
                                  _isMobileValid = false;
                                  _visible = false;
                                  _phoneController.clear();
                                });
                              },
                              onSubmitted: (string) {
                                setState(() {
                                  _visible = true;
                                  validateMobile(_phoneController.text);

                                });
                              })),
                      buildBottomRight(context)
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(message) {
    final snackBar = new SnackBar(
      content: new Text(message),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  showPopup() {
    final alert = Alert(
        context: context,
        type: AlertType.info,
        title: "Disclaimer",
        desc:
            "En poursuivant l’opération, vous acceptez l'utilisation de vos données pour recevoir les informations et actualités Banxy ",
        buttons: [
          // usually buttons at the bottom of the dialog
          new DialogButton(
            color: secondaryColor,
            child: new Text(
              "Poursuivre",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              sendToServer();

              return Alert(
                context: context,
                type: AlertType.success,
                title: "Formulaire complété",
                desc:
                    "Merci d'avoir complété le formulaire Banxy, vous allez être redirigé vers l'accueil",
                buttons: [
                  DialogButton(
                    child: Text(
                      "Términer",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () => _navigateHome(context),
                    width: 120,
                  )
                ],
              ).show();
            },
          ),
          new DialogButton(
            color: Colors.white,
            child: new Text(
              "Annuler",
              style: TextStyle(color: secondaryColor),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ]);
    return alert.show();
  }
}
// ------------------------------------------------------------------------

// ------------------------------------------------------------------------
