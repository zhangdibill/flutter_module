
import 'package:flutter/material.dart';

class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {

  final double collapsedHeight; // 折叠时appbar的高度
  final double expandedHeight; // 展开时的高度
  final double paddingTop; // 状态栏的高度
  final Widget child; // 展开时的widget
  final String title; // 标题
  final IconData icon; // 左侧按钮

  SliverCustomHeaderDelegate({
    @required this.collapsedHeight,
    @required this.expandedHeight,
    @required this.paddingTop,
    @required this.child,
    this.title,
    this.icon = Icons.arrow_back_ios
  });

  @override
  // TODO: implement maxExtent
  double get maxExtent => this.expandedHeight;

  @override
  // TODO: implement minExtent
  double get minExtent => this.collapsedHeight + this.paddingTop;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }

  Color makeStickyHeaderBgColor(shrinkOffset) {
    final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255).clamp(0, 255).toInt();
    return Color.fromARGB(alpha, 255, 255, 255);
  }

  Color makeStickyHeaderTextColor(shrinkOffset, isIcon) {
    if(shrinkOffset <= 50) {
      return isIcon ? Colors.white : Colors.transparent;
    } else {
      final int alpha = (shrinkOffset / (this.maxExtent - this.minExtent) * 255).clamp(0, 255).toInt();
      return Color.fromARGB(alpha, 0, 0, 0);
    }
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return Container(
      height: this.maxExtent,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(child: this.child,),
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            child: Container(
              color: this.makeStickyHeaderBgColor(shrinkOffset),
              child: SafeArea(
                bottom: false,
                child: Container(
                  height: this.collapsedHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      leftIcon(this.icon, shrinkOffset),
                      Expanded(child: Text(
                        this.title,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: this.makeStickyHeaderTextColor(shrinkOffset, false)
                        ),
                      ),)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget leftIcon(icon, shrinkOffset) {
    if (icon == null) {
      return null;
    }
    return IconButton(
        icon: Icon(
          icon,
          color: this.makeStickyHeaderTextColor(shrinkOffset, true),
        ),
        onPressed: null
    );
  }

}