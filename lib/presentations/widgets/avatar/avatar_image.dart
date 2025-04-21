import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:meory/app/app_assets.dart';
import 'package:meory/presentations/widgets/base_widget.dart';

class AvatarImage extends BaseWidget {
  final double? height;
  final String? urlImage;

  const AvatarImage({super.key, this.height, this.urlImage});

  @override
  Widget build(BuildContext context, AppTheme theme, AppLocalizations tr) {
    return SizedBox(
      width: height ?? 60,
      height: height ?? 60,
      child: urlImage == null || urlImage?.trim() == ''
          ? ClipRRect(
              borderRadius: BorderRadius.circular(1000.0),
              child: Container(
                color: theme.colors.blueBackground,
                padding: const EdgeInsets.all(10),
                child: AppImage.icAvatarEmpty(
                  color: theme.colors.white,
                ),
              ),
            )
          : Image.network(
              urlImage ?? '',
              height: 300,
              fit: BoxFit.fitHeight,
              frameBuilder: (_, image, loadingBuilder, __) {
                if (loadingBuilder == null) {
                  return const SizedBox(
                    height: 300,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return ClipRRect(
                  borderRadius: BorderRadius.circular(1000.0),
                  child: image,
                );
              },
              loadingBuilder: (
                BuildContext context,
                Widget image,
                ImageChunkEvent? loadingProgress,
              ) {
                if (loadingProgress == null) return image;
                return SizedBox(
                  height: 300,
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              },
              errorBuilder: (_, __, ___) => ClipRRect(
                borderRadius: BorderRadius.circular(1000.0),
                child: Container(
                  color: theme.colors.blueBackground,
                  padding: const EdgeInsets.all(10),
                  child: AppImage.icAvatarEmpty(color: theme.colors.white),
                ),
              ),
            ),
    );
  }
}
