import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:vv4/Data/DataSource.dart';
import 'package:vv4/Utils/Routes.dart';


var myKey = '<yourkeyhere>';
void main ()
{

	runApp (new MyApp());
}

class MyApp extends StatelessWidget
{
	static DataSource       		  m_oDataSource_main = new DataSource();
	static bool             			m_b_IsLoggedIn=false;
	static int              			n_HungerDataUploadState=0;
	static String           			strUsername="";

	@override
	Widget build (BuildContext context)
	{
		return new MaterialApp(title: 'VV4',theme: new ThemeData(),	routes: routes,);
	}
}
