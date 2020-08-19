import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc.navigation_bloc/navigation_bloc.dart';
import 'Sidebar.dart';
import 'User.dart';

class SideBarLayout extends StatelessWidget {
  User newUser;
  bool once = true;
  
  @override
  Widget build(BuildContext context) {
    User user = ModalRoute.of(context).settings.arguments;
    
    print("user s b4 email = ${user.email}");
    User newUser = new User(user.id,user.name,user.email,user.photoUrl);
    print("Users current email = ${newUser.email}");
    once = false;
    if(once)
    {
    User user = ModalRoute.of(context).settings.arguments;
    print("user s b4 email = ${user.email}");
    User newUser = new User(user.id,user.name,user.email,user.photoUrl);
    print("Users current email = ${newUser.email}");
    once = false;
    }
    
    return Scaffold(
      body: BlocProvider<NavigationBloc>(
        create: (context) => NavigationBloc(),
        child: Stack(
          children: <Widget>[
            BlocBuilder<NavigationBloc, NavigationStates>(
              builder: (context, navigationState) {
                return navigationState as Widget;
              },
            ),
            SideBar(newUser),
          ],
        ),
      ),
    );
  }
}