import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:pinterest_flutter/widgets/widgets.dart';
import 'package:pinterest_flutter/models/menu_model.dart';
import 'package:pinterest_flutter/providers/providers.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/HomeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider(
        create: (BuildContext context) => ShowMenuProvider(),
        child: Scaffold(
          body: Stack(
            children: [
              const GridLayoutWidget(),
              Align(
                alignment: Alignment.bottomCenter,
                child: MenuWidget(
                  buttons: _buttonModelList,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<MenuButtonModel> get _buttonModelList {
    return <MenuButtonModel>[
      MenuButtonModel(
        Icons.pie_chart,
        () {
          print('pie');
        },
      ),
      MenuButtonModel(
        Icons.search,
        () {
          print('search');
        },
      ),
      MenuButtonModel(
        Icons.notifications,
        () {
          print('notifications');
        },
      ),
      MenuButtonModel(
        Icons.supervised_user_circle,
        () {
          print('supervised');
        },
      ),
    ];
  }
}
