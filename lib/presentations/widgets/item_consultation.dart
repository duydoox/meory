import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meory/presentations/widgets/avatar/avatar_image.dart';
import 'package:meory/presentations/widgets/base_widget.dart';
import 'package:meory/presentations/widgets/button_widget/custom_button.dart';
import 'package:meory/presentations/widgets/dot_widget/dot.dart';

enum EnumStatus {
  Online(Colors.green, 'Online visit'),
  Offline(Colors.grey, 'Offline'),
  Busy(Colors.red, 'Busy');

  final Color colorDot;
  final String status;

  const EnumStatus(this.colorDot, this.status);
}

enum EnumStatusDetail {
  Completed(Colors.green, 'Completed'),
  Upcoming(Color(0xff1873AC), 'Upcoming'),
  Pending(Color(0xFF9747FF), 'Pending'),
  Canceled(Colors.red, 'Canceled');

  final Color colorText;
  final String status;

  const EnumStatusDetail(this.colorText, this.status);
}

class ItemConsultations extends BaseWidget {
  final DateTime? startTime;
  final DateTime? endTime;
  final String? urlImage;
  final String? name;
  final String? cardName;
  final EnumStatus? statusUser;
  final EnumStatusDetail? statusDetail;
  final VoidCallback? onTapPrimaryButton;
  final VoidCallback? onTapSecondButton;
  final VoidCallback? onTap;

  const ItemConsultations({
    this.startTime,
    this.endTime,
    this.urlImage,
    this.name,
    this.cardName,
    this.statusUser,
    this.statusDetail,
    this.onTap,
    this.onTapPrimaryButton,
    this.onTapSecondButton,
    super.key,
  });

  @override
  Widget build(BuildContext context, AppTheme theme, AppLocalizations tr) {
    String time = '${startTime != null ? DateFormat.jm().format(startTime!) : ''}'
        ' - ${endTime != null ? DateFormat.jm().format(endTime!) : ''}';

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RotatedBox(
          quarterTurns: -1,
          child: SizedBox(
            height: 32,
            child: Center(
              child: Text(
                time,
                style: AppTextStyle.s12w400.copyWith(
                  color: theme.colors.greyText,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Ink(
              padding: const EdgeInsets.all(16),
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
                      AvatarImage(
                        height: 60,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name ?? '',
                            style: AppTextStyle.s16w500CD,
                          ),
                          Row(
                            children: [
                              Text(
                                cardName ?? '',
                                style: AppTextStyle.s12w400.copyWith(color: theme.colors.greyText),
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
                                statusUser?.status ?? '',
                                style: AppTextStyle.s12w400.copyWith(color: theme.colors.greyText),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          SizedBox(
                            height: 20,
                            child: CustomButton(
                              title: statusDetail?.status,
                              borderColor: Colors.transparent,
                              borderRadius: 4,
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              backgroundColor:
                                  (statusDetail?.colorText ?? theme.colors.green).withOpacity(0.2),
                              titleTextStyle: AppTextStyle.s10w400.copyWith(
                                  color: statusDetail?.colorText ?? theme.colors.greenText),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 36,
                    child: CustomButton(
                      backgroundColor: theme.colors.blueBackground,
                      borderColor: Colors.transparent,
                      title: 'View Details',
                      titleTextStyle: AppTextStyle.s14w600.copyWith(
                        color: theme.colors.primary,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
