import 'package:flutter/material.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest_flutter/providers/show_menu_provider.dart';
import 'package:provider/provider.dart';

class GridLayoutWidget extends StatefulWidget {
  const GridLayoutWidget({Key? key}) : super(key: key);

  @override
  State<GridLayoutWidget> createState() => _GridLayoutWidgetState();
}

class _GridLayoutWidgetState extends State<GridLayoutWidget> {
  late ScrollController scrollController;
  double compareOffset = 0.0;
  @override
  void initState() {
    final ShowMenuProvider showMenuProvider =
        Provider.of<ShowMenuProvider>(context, listen: false);
    scrollController = ScrollController();

    scrollController.addListener(() {
      if ((scrollController.offset > compareOffset)) {
        print('hide Menu');
        showMenuProvider.isShowMenu = false;
      } else if (scrollController.offset <= 0) {
        showMenuProvider.isShowMenu = true;
      } else {
        print('show menu');
        showMenuProvider.isShowMenu = true;
      }
      compareOffset = scrollController.offset;
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: const _StaggeredGrid(),
    );
  }
}

class _StaggeredGrid extends StatelessWidget {
  const _StaggeredGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: StaggeredGrid.count(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: List.generate(
          19,
          (index) => StaggeredGridTile.count(
            crossAxisCellCount: (index.isEven) ? 1 : 2,
            mainAxisCellCount: 2,
            child: Tile(
              index: index,
            ),
          ),
        ),
      ),
    );
  }
}

class Tile extends StatelessWidget {
  final int index;

  const Tile({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text('$index'),
      ),
    );
  }
}
