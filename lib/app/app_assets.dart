import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const String _imagePath = 'assets/images';
const String _loadPath = 'assets/icons';

final class AppImage {
  static const BaseImage _baseImage = BaseImage(_imagePath);

  // Example
  // static Image backgroundApp({BoxFit? fit, double? width, double? height}) =>
  //     _baseImage.load('background_app.png',
  //         fit: fit, width: width, height: height);

  static Image icLetsYouIn({BoxFit? fit, double? size, Color? color}) =>
      _baseImage.load(
        'lets_you_in.jpeg',
        width: size,
        height: size,
        fit: fit,
        color: color,
      );
  static Image icHeart({BoxFit? fit, double? size, Color? color}) =>
      _baseImage.load(
        'ic_heart.jpg',
        width: size,
        height: size,
        fit: fit,
        color: color,
      );
  static Image icLine({BoxFit? fit, double? size, Color? color}) =>
      _baseImage.load(
        'ic_line.png',
        width: size,
        height: size,
        fit: fit,
        color: color,
      );
  static Image icTimeEnd({BoxFit? fit, double? size, Color? color}) =>
      _baseImage.load(
        'ic_time_end.png',
        width: size,
        height: size,
        fit: fit,
        color: color,
      );
  static Image icAvatarEmpty({BoxFit? fit, double? size, Color? color}) =>
      _baseImage.load(
        'ic_avatar_empty.png',
        width: size,
        height: size,
        fit: fit,
        color: color,
      );
}

final class AppIcon {
  static const BaseSvg _baseSvg = BaseSvg(_loadPath);

  // Example
  // static SvgPicture logo({double? size, Color? color}) => _baseSvg.load(
  //       'logo.svg',
  //       width: size,
  //       height: size,
  //       colorFilter: color,
  //     );
  static SvgPicture icFacebook({double? size, Color? color}) => _baseSvg.load(
        'ic_facebook.svg',
        width: size,
        height: size,
        colorFilter: color,
      );

  static SvgPicture icGoogle({double? size, Color? color}) => _baseSvg.load(
        'ic_google.svg',
        width: size,
        height: size,
        colorFilter: color,
      );

  static SvgPicture icApple({double? size, Color? color}) => _baseSvg.load(
        'ic_apple.svg',
        width: size,
        height: size,
        colorFilter: color,
      );
  static SvgPicture icMail({double? size, Color? color}) => _baseSvg.load(
    'ic_mail.svg',
    width: size,
    height: size,
    colorFilter: color,
  );
  static SvgPicture icLock({double? size, Color? color}) => _baseSvg.load(
    'ic_lock.svg',
    width: size,
    height: size,
    colorFilter: color,
  );
  static SvgPicture icBell({double? size, Color? color}) => _baseSvg.load(
    'ic_bell.svg',
    width: size,
    height: size,
    colorFilter: color,
  );
  static SvgPicture icCalendar({double? size, Color? color}) => _baseSvg.load(
    'ic_calendar.svg',
    width: size,
    height: size,
    colorFilter: color,
  );
  static SvgPicture icClock({double? size, Color? color}) => _baseSvg.load(
    'ic_clock.svg',
    width: size,
    height: size,
    colorFilter: color,
  );
  static SvgPicture icRecordsList({double? size, Color? color}) => _baseSvg.load(
    'ic_records_list.svg',
    width: size,
    height: size,
    colorFilter: color,
  );
  static SvgPicture icChat({double? size, Color? color}) => _baseSvg.load(
    'ic_chat.svg',
    width: size,
    height: size,
    colorFilter: color,
  );
  static SvgPicture icMore({double? size, Color? color}) => _baseSvg.load(
    'ic_more.svg',
    width: size,
    height: size,
    colorFilter: color,
  );
  static SvgPicture icFriend({double? size, Color? color}) => _baseSvg.load(
    'ic_friend.svg',
    width: size,
    height: size,
    colorFilter: color,
  );
  static SvgPicture icRecorded({double? size, Color? color}) => _baseSvg.load(
    'ic_recorded.svg',
    width: size,
    height: size,
    colorFilter: color,
  );
  static SvgPicture icSound({double? size, Color? color}) => _baseSvg.load(
    'ic_sound.svg',
    width: size,
    height: size,
    colorFilter: color,
  );
  static SvgPicture icMic({double? size, Color? color}) => _baseSvg.load(
    'ic_mic.svg',
    width: size,
    height: size,
    colorFilter: color,
  );
  static SvgPicture icPhoneCancel({double? size, Color? color}) => _baseSvg.load(
    'ic_phone_cancel.svg',
    width: size,
    height: size,
    colorFilter: color,
  );
  static SvgPicture icFavoriteChart({double? size, Color? color}) => _baseSvg.load(
    'ic_favorite_chart.svg',
    width: size,
    height: size,
    colorFilter: color,
  );
  static SvgPicture icHome({double? size, Color? color}) => _baseSvg.load(
    'ic_home.svg',
    width: size,
    height: size,
    colorFilter: color,
  );
  static SvgPicture icProfileCircle({double? size, Color? color}) => _baseSvg.load(
    'ic_profile_circle.svg',
    width: size,
    height: size,
    colorFilter: color,
  );
}
