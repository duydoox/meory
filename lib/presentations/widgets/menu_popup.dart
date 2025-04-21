import 'package:flutter/material.dart';

class MenuItem {
  final String label;
  final Widget? icon;
  final VoidCallback? onPress;
  const MenuItem({required this.label, this.icon, this.onPress});
}

class MenuPopup extends StatefulWidget {
  final Widget? child;
  final List<MenuItem> items;
  final Offset? alignmentOffset;
  const MenuPopup({super.key, this.child, required this.items, this.alignmentOffset});

  @override
  State<MenuPopup> createState() => _MenuPopupState();
}

class _MenuPopupState extends State<MenuPopup> with SingleTickerProviderStateMixin {
  // late AnimationController _animationController;
  MenuController controller = MenuController();

  @override
  void initState() {
    // _animationController = AnimationController(
    //   vsync: this,
    //   duration: Durations.long2,
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      controller: controller,
      style: const MenuStyle(
        padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.all(0)),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      alignmentOffset: widget.alignmentOffset ?? const Offset(0, 0),
      menuChildren: widget.items.fold<List<Widget>>([], (rs, e) {
        if (widget.items[0] != e) {
          rs.add(Divider(height: 1, color: Colors.grey.shade300));
        }
        rs.add(InkWell(
          onTap: () {
            controller.close();
            e.onPress?.call();
          },
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              children: [
                if (e.icon != null) ...[e.icon!, const SizedBox(width: 8)],
                Text(e.label,
                    textHeightBehavior: const TextHeightBehavior(
                        applyHeightToFirstAscent: false, applyHeightToLastDescent: false))
              ],
            ),
          ),
        ));
        return rs;
      }),
      builder: (context, controller, child) {
        return InkWell(
          onTap: controller.open,
          child: child,
        );
      },
      child: widget.child ??
          const Padding(
            padding: EdgeInsets.only(left: 12),
            child: Icon(Icons.more_vert_outlined, color: Colors.grey),
          ),
    );
  }
}
