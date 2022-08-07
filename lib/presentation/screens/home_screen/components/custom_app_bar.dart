import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todo_list/internationalization/lang.dart';

class CustomAppBar extends SliverPersistentHeaderDelegate {
  final int doneCount;
  final double foldedHeight;
  final double expandedHeight;

  const CustomAppBar({
    required this.doneCount,
    required this.foldedHeight,
    required this.expandedHeight,
  });

  static const duration = Duration(milliseconds: 100);

  double height(double shrinkOffset) =>
      max(foldedHeight, expandedHeight - shrinkOffset);

  static const foldedLeftPadding = 16.0;
  static const expandedLeftPadding = 60.0;
  static double leftPadding(double shrinkOffset) =>
      max(foldedLeftPadding, expandedLeftPadding - shrinkOffset);

  static const foldedRightPadding = 20.0;
  static const expandedRightPadding = 24.0;
  static double rightPadding(double shrinkOffset) =>
      max(foldedRightPadding, expandedRightPadding - shrinkOffset);

  static const foldedBottomPadding = 16.0;
  static const expandedBottomPadding = 18.0;
  static double bottomPadding(double shrinkOffset) =>
      max(foldedBottomPadding, expandedBottomPadding - shrinkOffset);

  static const foldedTitleFontSize = 20.0;
  static const expandedTitleFontSize = 32.0;
  static double titleFontSize(double shrinkOffset) =>
      max(foldedTitleFontSize, expandedTitleFontSize - shrinkOffset / 6.0);

  static double foldedTitleLineHeight(double shrinkOffset) =>
      32.0 / titleFontSize(shrinkOffset);
  static double expandedTitleLineHeight(double shrinkOffset) =>
      37.5 / titleFontSize(shrinkOffset);
  static double titleLineHeight(double shrinkOffset) => max(
      foldedTitleLineHeight(shrinkOffset),
      expandedTitleLineHeight(shrinkOffset) - shrinkOffset);

  static const foldedSubtitleFontSize = 0.0;
  static const expandedSubtitleFontSize = 16.0;
  static double subtitleFontSize(double shrinkOffset) => max(
      foldedSubtitleFontSize, expandedSubtitleFontSize - shrinkOffset / 2.0);

  double opacity(double shrinkOffset) => 1.0 - shrinkOffset / expandedHeight;

  Widget titleWidget(double shrinkOffset, String text) =>
      AnimatedDefaultTextStyle(
        duration: duration,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
          fontSize: titleFontSize(shrinkOffset),
          height: titleLineHeight(shrinkOffset),
          color: Colors.black,
          letterSpacing: 0.5,
        ),
        child: Text(text),
      );

  Widget subtitleWidget(double shrinkOffset, String text) => AnimatedOpacity(
        duration: duration,
        opacity: opacity(shrinkOffset),
        child: Text(
          '$text - $doneCount',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
            fontSize: subtitleFontSize(shrinkOffset),
            height: 20.0 / 16.0,
            color: Colors.black.withOpacity(0.3),
          ),
        ),
      );

  //TODO: Init colors
  //final foldedColor;
  //final expandedColor;

  Color color(double shrinkOffset) => Colors.white
      .withOpacity((shrinkOffset / expandedHeight * 2.0).clamp(0.0, 1.0));

  List<BoxShadow> boxShadow(double shrinkOffset) {
    double f(double y) => (shrinkOffset / expandedHeight / 8.0).clamp(0.0, y);

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
        height: height(shrinkOffset),
        decoration: BoxDecoration(
          color: color(shrinkOffset),
          boxShadow: boxShadow(shrinkOffset),
        ),
        child: AnimatedPadding(
          duration: duration,
          padding: EdgeInsets.only(
            left: leftPadding(shrinkOffset),
            right: rightPadding(shrinkOffset),
            bottom: bottomPadding(shrinkOffset),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  titleWidget(shrinkOffset, L.of(context).myDeals),
                  subtitleWidget(shrinkOffset, L.of(context).done),
                ],
              ),
              Icon(
                Icons.visibility,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
        ),
      );

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => foldedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
