import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:meory/presentations/widgets/avatar/avatar_image.dart';
import 'package:meory/presentations/widgets/base_widget.dart';
import 'package:meory/presentations/widgets/button_widget/custom_button.dart';
import 'package:meory/presentations/widgets/dot_widget/dot.dart';

class ItemPatient extends BaseWidget {
  const ItemPatient({super.key});

  @override
  Widget build(BuildContext context, AppTheme theme, AppLocalizations tr) {
    return Container(
      width: 296,
      height: 106,
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.only(top: 16, bottom: 0, left: 16, right: 16),
      decoration: BoxDecoration(
          color: theme.colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: theme.colors.grey.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(1, 1), // Shadow position
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 42,
            child: Row(
              children: [
                const AvatarImage(
                  height: 40,
                  urlImage: '',
                ),
                const SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Emma',
                      style: AppTextStyle.s16w600,
                    ),
                    Row(
                      children: [
                        Text(
                          'PID: 126417',
                          style: AppTextStyle.s12w400.copyWith(color: theme.colors.blueText),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Dot(
                            color: theme.colors.green,
                            size: 8,
                            strokeAlign: 0,
                          ),
                        ),
                        Text(
                          'Online',
                          style: AppTextStyle.s12w400.copyWith(color: theme.colors.greyText),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 38,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 20,
                  child: CustomButton(
                    title: 'Completed',
                    borderColor: Colors.transparent,
                    borderRadius: 4,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    backgroundColor: theme.colors.green.withOpacity(0.2),
                    titleTextStyle: AppTextStyle.s10w400.copyWith(color: theme.colors.greenText),
                  ),
                ),
                Text(
                  'View Details',
                  style: AppTextStyle.s12w600.copyWith(color: theme.colors.primary),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
