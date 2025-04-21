import 'dart:io';

import 'package:core/core.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meory/app/app_cubit.dart';
import 'package:meory/generated/assets.gen.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerCustom extends StatefulWidget {
  final String? initUrl;
  final bool enabled;
  final Function(File)? onImageSelected;
  const ImagePickerCustom({super.key, this.initUrl, this.onImageSelected, this.enabled = true});

  @override
  State<ImagePickerCustom> createState() => _ImagePickerCustomState();
}

class _ImagePickerCustomState extends State<ImagePickerCustom> {
  final _picker = ImagePicker();
  File? imageSelected;

  @override
  void initState() {
    super.initState();
    // imageSelected = widget.imagePath != null ? File(widget.imagePath!) : null;
  }

  @override
  void didUpdateWidget(covariant ImagePickerCustom oldWidget) {
    if (oldWidget.initUrl != widget.initUrl) {
      imageSelected = null;
    }
    super.didUpdateWidget(oldWidget);
  }

  Future<PermissionStatus> requestPermissionAndroid() async {
    final androidDeviceInfo = getIt.get<AndroidDeviceInfo>();
    if (androidDeviceInfo.version.sdkInt < 33) {
      return Permission.storage.request();
    }
    return Permission.photos.request();
  }

  Future<void> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        imageSelected = File(image.path);
        widget.onImageSelected?.call(imageSelected!);
        setState(() {});
      }
    } catch (e) {
      openAppSettings();
    }
  }

  onTap() async {
    if (Platform.isAndroid) {
      final status = await requestPermissionAndroid();
      if (status.isGranted) {
        pickImageFromGallery();
      } else if (status.isDenied) {
        // Nếu quyền bị từ chối, yêu cầu lại quyền
        // final result = await requestPermissionAndroid();
        // if (result.isGranted) {
        //   pickImageFromGallery();
        // }
      } else if (status.isPermanentlyDenied) {
        // Nếu quyền bị từ chối vĩnh viễn, mở cài đặt ứng dụng
        openAppSettings();
      }
    } else {
      pickImageFromGallery();
    }
  }

  void viewImage() {
    if (imageSelected != null || widget.initUrl != null) {
      // AppNavigator.push(Routes.viewImage, {'image': imageSelected?.path ?? widget.initUrl});
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.read<AppCubit>().state.theme;
    return Container(
      height: 180,
      width: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: theme.colors.greyBackground,
      ),
      child: InkWell(
        onTap: widget.enabled ? onTap : viewImage,
        child: imageSelected != null
            ? Image.file(imageSelected!)
            : widget.initUrl != null
                ? Image.network(
                    widget.initUrl!,
                    errorBuilder: (context, error, stackTrace) => const SizedBox(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Assets.icons.icImage.svg(),
                        if (widget.enabled)
                          Positioned(
                            top: -12,
                            left: -12,
                            child: Container(
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(width: 2, color: theme.colors.white),
                                color: theme.colors.hintText,
                              ),
                              child: Icon(Icons.add, color: theme.colors.white),
                            ),
                          )
                      ],
                    ),
                  ),
      ),
    );
  }
}
