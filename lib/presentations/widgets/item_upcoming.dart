import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:meory/app/app_assets.dart';
import 'package:meory/presentations/widgets/avatar/avatar_image.dart';
import 'package:meory/presentations/widgets/base_widget.dart';
import 'package:meory/presentations/widgets/dot_widget/dot.dart';

class ItemUpcoming extends BaseWidget {
  const ItemUpcoming({super.key});

  @override
  Widget build(BuildContext context, AppTheme theme, AppLocalizations tr) {
    return Container(
      height: 152,
      width: 309,
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 10),
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const AvatarImage(
                height: 40,
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dr. Strange',
                    style: AppTextStyle.s16w500CD,
                  ),
                  Row(
                    children: [
                      Text(
                        'Ophthalmology',
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
                        style: AppTextStyle.s12w400.copyWith(color: theme.colors.blackText),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),

          const SizedBox(
            height: 12,
          ),

          /// card
          Container(
            height: 34,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.colors.blueBackground,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                AppIcon.icClock(color: theme.colors.black),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  'Tuesday',
                  style: AppTextStyle.s12w600.copyWith(color: theme.colors.blackText),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'May 13, 2023',
                  style: AppTextStyle.s12w400.copyWith(color: theme.colors.blackText),
                ),
                const Spacer(),
                Text(
                  '9:00 - 9:30 am',
                  style: AppTextStyle.s12w400.copyWith(color: theme.colors.primary),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _itemHeart(theme),
              Text(
                'View Details',
                style: AppTextStyle.s12w600.copyWith(color: theme.colors.primary),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _itemHeart(AppTheme theme) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4), color: theme.colors.red.withOpacity(0.2)),
      child: Row(
        children: [
          Icon(
            Icons.favorite,
            color: theme.colors.red,
            size: 16,
          ),
          const SizedBox(
            width: 6,
          ),
          Text(
            '4.9',
            style: AppTextStyle.s12w400.copyWith(color: theme.colors.red),
          )
        ],
      ),
    );
  }
}
