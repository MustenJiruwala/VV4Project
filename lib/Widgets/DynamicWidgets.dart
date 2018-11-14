import 'package:flutter/material.dart';

class DynamicWidgets
{
  void showAlertDialog (BuildContext cxt, String strAlertTitle, String strMessage)
  {
    showDialog (
        context: cxt,
        builder: (_)
        =>
        new AlertDialog(
          title: new Text(strAlertTitle),
          content: new Text(strMessage),
          actions: <Widget>[
            new FlatButton(
              child: new Text('OK'), onPressed: ()
            {
              Navigator.of (cxt).pop ();
            },
            )
          ],
        )
    );
  }

  void showAlertDialogHome (BuildContext cxt, String strAlertTitle, String strMessage)
  {
    showDialog (
        context: cxt,
        builder: (_)
        =>
        new AlertDialog(
          title: new Text(strAlertTitle),
          content: new Text(strMessage),
          actions: <Widget>[
            new FlatButton(
              child: new Text('OK'), onPressed: ()
            {
              Navigator.of (cxt).pushNamed ('Layouts/Home');
            },
            )
          ],
        )
    );
  }
  void showProgressDialog(BuildContext context)
  {
    showDialog(
      context: context,
      barrierDismissible: true,
      child: new Dialog(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            new CircularProgressIndicator(),
            new Text("Loading..."),
          ],
        ),
      ),
    );
  }
}
