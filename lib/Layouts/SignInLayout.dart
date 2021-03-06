import 'package:flutter/material.dart';
import 'package:vv4/Data/DataSource.dart';
import 'package:vv4/Utils/FormValidation.dart';
import 'package:vv4/Utils/SecurityUtils.dart';
import 'package:vv4/main.dart';

class SignIn extends StatefulWidget
{
	SignInLayout createState ()
	=> new SignInLayout();
}

class SignInLayout extends State<SignIn>
{
	bool bAutoValidate = false;
	FormValidation oFormValadation = new FormValidation();
	final GlobalKey<FormState> frmKey = GlobalKey<FormState> ();
	SecurityUtils oSecurityUtils = new SecurityUtils();
	var strUsername = new TextEditingController();
	var strPassword = new TextEditingController();

	@override
	Widget build (BuildContext context)
	{
		final labelMessage = Text (
			'Sign In',
			textAlign: TextAlign.center,
			style: TextStyle (
				color: Colors.black,
				fontSize: 30.0,
				fontWeight: FontWeight.bold,
			),
		);

		final textboxUsername = TextFormField (
			keyboardType: TextInputType.text,
			controller: strUsername,
			autofocus: true,
			decoration: InputDecoration (
				hintText: 'Mobile Number/Email ID',
				fillColor: Colors.white,
				labelText: 'Mobile Number/Email ID',
				contentPadding: EdgeInsets.fromLTRB (20.0, 20.0, 20.0, 20.0),
				border: OutlineInputBorder (borderRadius: BorderRadius.circular (5.0)),
			),
			validator: (value)
			{
				String strValidationMessage;
				if (value.isNotEmpty)
					strValidationMessage = oFormValadation.emailNotMatched (value);
				else
					strValidationMessage = "please enter username ";
				return strValidationMessage;
			},
		);

		final textboxPassword = TextFormField (
			keyboardType: TextInputType.text,
			controller: strPassword,
			obscureText: true,
			autofocus: true,
			decoration: InputDecoration (
				hintText: 'Password',
				fillColor: Colors.white,
				labelText: 'Password',
				contentPadding: EdgeInsets.fromLTRB (20.0, 20.0, 20.0, 20.0),
				border: OutlineInputBorder (borderRadius: BorderRadius.circular (5.0)),
			),
			validator: (value)
			{
				if (value.isEmpty) return "Please enter password...";
			},
		);

		final buttonSignIn = Padding (
			padding: EdgeInsets.symmetric (vertical: 0.0),
			child: Material (
				borderRadius: BorderRadius.circular (0.0),
				shadowColor: Colors.lightBlueAccent.shade100,
				elevation: 5.0,
				child: MaterialButton (
					minWidth: 200.0,
					height: 60.0,
					color: Color.fromRGBO (64, 75, 96, .9),
					child: Text ('Sign In', style: TextStyle (color: Colors.white)),
					onPressed: ()
					{
						if (frmKey.currentState.validate ())
						{
							String strEncryptedPassword =
							oSecurityUtils.passwordEncrypt (strPassword.text);
							MyApp.m_oDataSource_main.login (
									context, strUsername.text, strEncryptedPassword.toString ());
						}
					},
				),
			),
		);

		final buttonHaveAccount = Padding (
			padding: EdgeInsets.symmetric (vertical: 0.0),
			child: Material (
				borderRadius: BorderRadius.circular (0.0),
				elevation: 0.0,
				child: MaterialButton (
					minWidth: 200.0,
					height: 50.0,
					child: Text ("Don't have an Account? / Forgot Password?",
							style: TextStyle (color: Colors.red)),
					onPressed: ()
					{
						Navigator.of (context).pushNamed ('Layouts/SignUpLayout');
					},
				),
			),
		);

		return new Scaffold(
			resizeToAvoidBottomPadding: false,
			body: new Container(
				decoration: new BoxDecoration(
					image: new DecorationImage(
							alignment: Alignment.bottomCenter,
							image: new AssetImage("assets/login_bg.jpeg"),
							fit: BoxFit.scaleDown),
				),
				child: Form (
					autovalidate: bAutoValidate,
					key: frmKey,
					child: ListView (
						padding: EdgeInsets.only (left: 24.0, right: 24.0),
						children: <Widget>[
							SizedBox (height: 80.0),
							labelMessage,
							SizedBox (height: 30.0),
							textboxUsername,
							SizedBox (height: 8.0),
							textboxPassword,
							SizedBox (height: 8.0),
							buttonSignIn,
							SizedBox (height: 8.0),
							buttonHaveAccount,
							SizedBox (height: 24.0),
							//changePasswordLabel,
						],
					),
				), /* add child content content here */
			),
		);
	}
}
