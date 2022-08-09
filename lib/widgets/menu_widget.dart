import 'package:flutter/material.dart';
import 'package:pinterest_flutter/models/menu_model.dart';
import 'package:pinterest_flutter/providers/show_menu_provider.dart';
import 'package:provider/provider.dart';

class MenuWidget extends StatelessWidget {
  final List<MenuButtonModel> buttons;
  final Color? activeColor;
  final Color? backgroundColor;

  const MenuWidget({
    Key? key,
    required this.buttons,
    this.activeColor,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShowMenuProvider showMenuProvider = Provider.of<ShowMenuProvider>(context);
    if (activeColor != null) {
      showMenuProvider.selectedColor = activeColor!;
    }
    if (backgroundColor != null) {
      showMenuProvider.backgroundColor = backgroundColor!;
    }
    final Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (BuildContext context) => _ItemMenuProvider(),
      child: _AnimatedOpacityMenu(
        size: size,
        buttons: buttons,
        isShow: showMenuProvider.isShowMenu,
      ),
    );
  }
}

class _AnimatedOpacityMenu extends StatelessWidget {
  const _AnimatedOpacityMenu({
    Key? key,
    required this.size,
    required this.buttons,
    required this.isShow,
  }) : super(key: key);

  final Size size;
  final List<MenuButtonModel> buttons;
  final bool isShow;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 250),
      opacity: (isShow) ? 1 : 0,
      child: _CircularContainer(
        size: size,
        buttons: buttons,
      ),
    );
  }
}

class _CircularContainer extends StatelessWidget {
  final List<MenuButtonModel> buttons;
  const _CircularContainer({
    Key? key,
    required this.size,
    required this.buttons,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 30,
      ),
      width: size.width,
      height: size.height * 0.1,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black38,
            blurRadius: 10,
            spreadRadius: -5,
          ),
        ],
      ),
      child: _ContainerItems(
        items: buttons,
      ),
    );
  }
}

class _ContainerItems extends StatelessWidget {
  final List<MenuButtonModel> items;

  const _ContainerItems({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        items.length,
        (index) => _IconMenu(
          item: items[index],
          index: index,
        ),
      ),
    );
  }
}

class _IconMenu extends StatelessWidget {
  final MenuButtonModel item;
  final int index;
  const _IconMenu({
    Key? key,
    required this.item,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ShowMenuProvider showMenuProvider =
        Provider.of<ShowMenuProvider>(context);
    final _ItemMenuProvider itemMenuProvider =
        Provider.of<_ItemMenuProvider>(context);
    final isSelected = (itemMenuProvider.itemSelected == index);
    final Color selectedItemColor = showMenuProvider.selectedColor;
    final Color backgroundItemColor = showMenuProvider.backgroundColor;
    return GestureDetector(
      onTap: () {
        itemMenuProvider.itemSelected = index;
        item.onPressed!();
      },
      behavior: HitTestBehavior.translucent,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        child: Icon(
          item.icon,
          color: (!isSelected) ? backgroundItemColor : selectedItemColor,
          size: (!isSelected) ? 30 : 40,
        ),
      ),
    );
  }
}

class _ItemMenuProvider extends ChangeNotifier {
  int _itemSelected = 0;

  int get itemSelected => _itemSelected;

  set itemSelected(int value) {
    _itemSelected = value;
    notifyListeners();
  }
}
