import 'package:bloc/bloc.dart';
import '../pages/myaccountspage.dart';
import '../pages/myorderspage.dart';
import '../pages/mycart.dart';
import '../pages/homepage.dart';
import "../pages/settingspage.dart";

enum NavigationEvents {
  HomePageClickedEvent,
  MyAccountClickedEvent,
  MyOrdersClickedEvent,
  MyCartClickedEvent,
  SettingsClickedEvent
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
  NavigationStates get initialState => HomePage();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.HomePageClickedEvent:
        yield HomePage();
        break;
      case NavigationEvents.MyAccountClickedEvent:
        yield MyAccountsPage();
        break;
      case NavigationEvents.MyOrdersClickedEvent:
        yield MyOrdersPage();
        break;
      case NavigationEvents.MyCartClickedEvent:
        yield MyCartPage();
        break;
      case NavigationEvents.SettingsClickedEvent:
        yield SettingsPage();
        break;
    }
  }
}
