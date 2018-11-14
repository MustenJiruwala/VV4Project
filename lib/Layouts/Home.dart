import 'package:flutter/material.dart';
import 'package:vv4/Layouts/DashBoard.dart';
import 'package:vv4/Layouts/SpotHunger.dart';
import 'package:vv4/Layouts/ViewHunger.dart';
import 'package:vv4/main.dart';

class Home extends StatefulWidget
{
	HomeLayout createState ()
	=> new HomeLayout();
}

class HomeLayout extends State<Home>
{
	int _selectedIndex = 0;

	_widgetOptions (int pos)
	{
		switch (pos)
		{
			case 0:
				return new DashBoard();
			case 1:
				return new ViewHunger();
			case 2:
				return new SpotHunger();
			default:
				return new Text("Error");
		}
	}

	void _onItemTapped (int index)
	{
		setState (()
		{
			_selectedIndex = index;
		});
	}

	@override
	Widget build (BuildContext context)
	{
		final topAppBar = AppBar (
			elevation: 0.1,
			backgroundColor: Color.fromRGBO (64, 75, 96, .9),
			title: Text ('VV4'),
			actions: <Widget>[
				IconButton (
					icon: Icon (Icons.power_settings_new),
					tooltip: 'Sign Out',
					onPressed: ()
					{
					},
				),
				IconButton (
					icon: Icon (Icons.more_vert),
					tooltip: 'More',
					onPressed: ()
					{
					},
				)
			],
		);

		final bottomNavigationBar = BottomNavigationBar (
			iconSize: 30.0,
			items: <BottomNavigationBarItem>[
				BottomNavigationBarItem (
						icon: Icon (Icons.dashboard), title: Text ('Dashboard')),
				BottomNavigationBarItem (
						icon: Icon (Icons.map), title: Text ('See Hunger')),
				BottomNavigationBarItem (
						icon: Icon (Icons.camera), title: Text ('Spot Hunger')),
			],
			currentIndex: _selectedIndex,
			fixedColor: Colors.white,
			onTap: _onItemTapped,
		);

		return new Scaffold(
			resizeToAvoidBottomPadding: false,
			appBar: topAppBar,
			drawer: new Drawer(),
			body: _widgetOptions (_selectedIndex),
			bottomNavigationBar: new Theme(
				data: Theme.of (context).copyWith (
						canvasColor: Color.fromRGBO (64, 75, 96, .9),
						primaryColor: Colors.red,
						textTheme: Theme
								.of (context)
								.textTheme
								.copyWith (caption: new TextStyle(color: Colors.white))),
				child: bottomNavigationBar,
			),
		);
	}
}
