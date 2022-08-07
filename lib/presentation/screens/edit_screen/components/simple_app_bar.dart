import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/internationalization/lang.dart';
import 'package:todo_list/navigation/controller.dart';

class SimpleAppBar extends SliverPersistentHeaderDelegate {
  final double height;

  const SimpleAppBar({
    required this.height,
  });

  static const duration = Duration(milliseconds: 100);

  Color color(double shrinkOffset) =>
      Colors.white.withOpacity((shrinkOffset / height * 2.0).clamp(0.0, 1.0));

  List<BoxShadow> boxShadow(double shrinkOffset) {
    double f(double y) => (shrinkOffset / height / 8.0).clamp(0.0, y);

    return <BoxShadow>[
      BoxShadow(
        offset: const Offset(0.0, 2.0),
        blurRadius: 4.0,
        color: Colors.black.withOpacity(f(0.14)),
      ),
      BoxShadow(
        offset: const Offset(0.0, 4.0),
        blurRadius: 5.0,
        color: Colors.black.withOpacity(f(0.12)),
      ),
      BoxShadow(
        offset: const Offset(0.0, 1.0),
        blurRadius: 10.0,
        color: Colors.black.withOpacity(f(0.2)),
      ),
    ];
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) =>
      Container(
        width: double.infinity,
        height: height,
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: color(shrinkOffset),
          boxShadow: boxShadow(shrinkOffset),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 49.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.clear),
                onPressed: () => context.read<NavigationController>().pop(),
              ),
              TextButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero)),
                child: Text(L.of(context).save.toUpperCase()),
                onPressed: () {},
              ),
            ],
          ),
        ),
      );

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
