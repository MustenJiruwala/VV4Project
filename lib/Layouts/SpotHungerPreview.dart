import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:camera/camera.dart';
import 'package:vv4/Utils/FormValidation.dart';
import 'package:vv4/Utils/Session.dart';
import 'package:vv4/main.dart';

class SpotHungerPreview extends StatefulWidget {
  final Function callback;
  String StrCapturedImageFilePath;
  String StrThumbnailImageFilePath;

  SpotHungerPreview(
            {
              this.StrCapturedImageFilePath,
              this.StrThumbnailImageFilePath,
              this.callback
            });

  @override
  SpotHungerPreviewState createState() => new SpotHungerPreviewState();
}

List<CameraDescription> cameras;

class SpotHungerPreviewState extends State<SpotHungerPreview>
    with TickerProviderStateMixin {
  int nUploadstate = 0;
  bool bAutoValidate = false;
  var varNoOfHungers = new TextEditingController();
  FormValidation oFormValadation = new FormValidation();
  final GlobalKey<FormState> frmKey = GlobalKey<FormState>();
  var strNoOFHungers = new TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  //Button animate variables
  bool bIsPressed = false, bRevealUploadingState = false;
  double _width = double.infinity;
  Animation _animation;
  GlobalKey _globalKey = GlobalKey();
  AnimationController _controller;

  //Location
  static Map<String, double> m_startLocation;
  static Map<String, double> m_currentLocation;
  StreamSubscription<Map<String, double>> m_locationSubscription;
  bool m_bPermission = false;
  String m_strError;
  bool m_bcurrentWidget = true;
  Location m_oLocation = new Location();

  @override
  void initState() {
    super.initState();
    initPlatformState();
    m_locationSubscription =
        m_oLocation.onLocationChanged().listen((Map<String, double> result) {
          setState(() {
            m_currentLocation = result;
          });
        });
  }

  initPlatformState() async {
    Map<String, double> location;
    try {
      m_bPermission = await m_oLocation.hasPermission();
      location = await m_oLocation.getLocation();
      m_strError = null;
    }  catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        m_strError = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        m_strError =
        'Permission denied - please ask the user to enable it from the app settings';
      }
      location = null;
    }
    setState(() {
      m_startLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    final noHungers = new Padding(
      padding: EdgeInsets.only(left: 24.0, right: 24.0),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: varNoOfHungers,
        maxLines: 1,
        keyboardAppearance: Brightness.dark,
        autofocus: false,
        decoration: InputDecoration(
          hintText: 'No. Of Hunger People',
          fillColor: Colors.white,
          labelText: 'No. Of Hunger People',
          contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        validator: (value) {
          String strValidationMessage;
          if (value.isNotEmpty) {
          } else
            strValidationMessage = "please enter no. of Hunger People ";
          return strValidationMessage;
        },
      ),
    );


    final buttonuploadHungerData = Padding(
      padding: EdgeInsets.only(left: 24.0, right: 24.0),
      child: Material(
        shadowColor: Colors.blueGrey.shade100,
        elevation: calculateElevation(),
        borderRadius: BorderRadius.circular(25.0),
        child: Container(
          key: _globalKey,
          height: 48.0,
          width: _width,
          child: RaisedButton(
            padding: EdgeInsets.all(0.0),
            color: Color.fromRGBO(64, 75, 96, .9),
            child: buildButtonChild(),
            onPressed: () {},
            onHighlightChanged: (isPressed) {
              setState(() {
                bIsPressed = isPressed;
                if (nUploadstate == 0)
                 {
                   if (frmKey.currentState.validate()) {
                     PerformUploading();
                   }
                  }
              });
            },
          ),
        ),
      ),
    );

    return new Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomPadding: true,
      body: new Container(
        child: Form(
          autovalidate: bAutoValidate,
          key: frmKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                child: Image.file(
                    File(widget.StrCapturedImageFilePath.toString())),
                width: 300.0,
              ),
              SizedBox(height: 8.0),
              noHungers,
              SizedBox(height: 8.0),
              buttonuploadHungerData,
              SizedBox(height: 24.0),
            ],
          ),
        ), /* add child content content here */
      ),
    );
  }

  void PerformUploading() {
    setState(() {
      nUploadstate = 1;
    });
    Timer(Duration(seconds: 1), () {
      bRevealUploadingState = true;
      PerformUploadHungerDataTasks();
      //widget.callback();
    });
  }

  Widget buildButtonChild() {
    if (nUploadstate == 0) {
      return Text('Shout for Food',style: TextStyle(color: Colors.white, fontSize: 16.0),);
    }
    else if (nUploadstate == 1) {
      return Text('Uploading Details.....',style: TextStyle(color: Colors.white, fontSize: 16.0),);
    }
  }

  double calculateElevation() {
    if (bRevealUploadingState) {
      return 0.0;
    } else {
      return bIsPressed ? 6.0 : 4.0;
    }
  }

  //PerformUploadHungerDataTasks

  void PerformUploadHungerDataTasks() {
    File strImageFile = File(widget.StrCapturedImageFilePath.toString());
    File strThumbnailFile = File(widget.StrThumbnailImageFilePath.toString());
    String strLatitude = m_currentLocation['latitude'].toString();
    String strLongitude = m_currentLocation['longitude'].toString();
    String strHungersCount = varNoOfHungers.text;
    MyApp.m_oDataSource_main.spottedHunger(context, strLatitude, strLongitude, strHungersCount, strImageFile, strThumbnailFile);
    //MyApp.m_oDataSource_main.fetchHungerList(m_currentLocation['latitude'].toString(), m_currentLocation['longitude'].toString());
  }
}

