import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math' as math;

import 'package:velocity_x/velocity_x.dart';

import 'custom_icon.dart';

class CustomSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  CustomSliverHeaderDelegate({
    @required this.title,
    @required this.actions,
    this.leading,
    this.height = 260,
    this.showSearch = false,
  });

  final Widget leading;
  final String title;
  final List<Widget> actions;
  final double height;
  final bool showSearch;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double currentExtent() => math.max(minExtent, maxExtent - shrinkOffset);
    return Container(
      color: Colors.grey[50],
      child: Stack(
        alignment: AlignmentDirectional(0, 1),
        children: <Widget>[
          title.text
              .textStyle(Theme.of(context).textTheme.headline4.copyWith(
              fontSize:
              map(currentExtent(), minExtent, maxExtent, 20.0, 34)))
              .makeCentered(),
          Material(
            color: Colors.transparent,
            child: Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (leading != null)
                    leading
                  else if (Navigator.canPop(context))
                    _CustomBackButton(),
                  Spacer(),
                  ...actions
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  double map(
      double n, double start1, double stop1, double start2, double stop2) =>
      ((n - start1) / (stop1 - start1)) * (stop2 - start2) + start2;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;

  @override
  double get maxExtent => height;

  @override
  double get minExtent => 60;
}
class _CustomBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomIcon(
      FontAwesomeIcons.arrowLeft,
      isOutLine: true,
      onTap: () => Navigator.pop(context),
    ).pSymmetric(h: 20, v: 8);
  }
}
