import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meory/app/app_cubit.dart';

class TileButton extends StatefulWidget {
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  const TileButton({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.backgroundColor,
    this.padding,
  });

  @override
  State<TileButton> createState() => _TileButtonState();
}

class _TileButtonState extends State<TileButton> {
  @override
  Widget build(BuildContext context) {
    final theme = context.read<AppCubit>().state.theme;
    return Padding(
      padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 12),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 44,
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? theme.colors.greyBackground,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              if (widget.leading != null) ...[
                widget.leading!,
                const SizedBox(width: 8),
              ],
              Expanded(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.title,
                  if (widget.subtitle != null) ...[
                    const SizedBox(width: 8),
                    widget.subtitle!,
                  ],
                ],
              )),
              if (widget.trailing != null) ...[
                const SizedBox(width: 8),
                widget.trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
