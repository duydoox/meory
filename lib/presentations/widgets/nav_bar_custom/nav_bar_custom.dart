import 'package:flutter/material.dart';
import 'package:meory/presentations/widgets/dot_widget/dot.dart';

class NavBarCustom extends StatelessWidget {
  final List<NavModel> items;
  final int pageIndex;
  final Function(int) onTap;

  const NavBarCustom({
    super.key,
    required this.items,
    required this.pageIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60 + MediaQuery.of(context).padding.bottom,
      child: BottomAppBar(
        elevation: 0.0,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: items
              .map(
                (e) => navItem(
                  e.icon ?? const SizedBox.shrink(),
                  pageIndex == items.indexOf(e),
                  onTap: () => onTap(
                    items.indexOf(e),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget navItem(Widget icon, bool selected, {Function()? onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            const SizedBox(
              height: 4,
            ),
            Visibility(
              visible: selected,
              child: const Dot(
                size: 5,
                color: Color(0xFF005EA2),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NavModel {
  final Widget? page;
  final Widget? icon;

  NavModel({
    this.page,
    this.icon,
  });
}
