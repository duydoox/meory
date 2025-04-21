part of '../core.dart';

abstract class AppFileType {
  // Image
  static const String jpg = 'jpg';
  static const String jpeg = 'jpeg';
  static const String png = 'png';

  // PDF
  static const String pdf = 'pdf';

  // Doc
  static const String doc = 'doc';
  static const String docx = 'docx';

  // Excel
  static const String xls = 'xls';
  static const String xlsx = 'xlsx';
}

class FileUtils {
  final String filePath;

  FileUtils(this.filePath);

  String get fileType {
    final type = filePath.split('.').last;
    return type;
  }

  String get fileName {
    final name = filePath.split('/').last;
    return name;
  }

  bool get isImage {
    final type = fileType;
    return type == AppFileType.jpg ||
        type == AppFileType.jpeg ||
        type == AppFileType.png;
  }

  bool get isPDF {
    final type = fileType;
    return type == AppFileType.pdf;
  }

  bool get isDoc {
    final type = fileType;
    return type == AppFileType.doc || type == AppFileType.docx;
  }

  bool get isExcel {
    final type = fileType;
    return type == AppFileType.xls || type == AppFileType.xlsx;
  }

  static Future<List<File>> getImages(ImageSource source) async {
    final picker = ImagePicker();

    if (source == ImageSource.camera) {
      final photo = await picker.pickImage(
        source: source,
        imageQuality: 50,
        maxWidth: 1920,
        maxHeight: 1080,
      );

      if (photo == null) return [];

      final file = File(photo.path);

      return [file];
    }

    final photos = await picker.pickMultiImage(
      imageQuality: 50,
      maxWidth: 1920,
      maxHeight: 1080,
    );

    if (photos.isEmpty) return [];

    final files = photos.map((e) => File(e.path)).toList().toList();

    return files;
  }

  static Future<List<File>> getFiles() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        AppFileType.jpg,
        AppFileType.jpeg,
        AppFileType.png,
        AppFileType.pdf,
        AppFileType.doc,
        AppFileType.docx,
        AppFileType.xls,
        AppFileType.xlsx,
      ],
    );

    if (result == null) return [];

    final files = result.files;

    if (files.isEmpty) return [];

    final paths =
        files.map((e) => e.path).where((element) => element != null).toList();

    final list = paths.map((e) => File(e!)).toList();

    return list;
  }

  static String getFileType(String fileName) {
    return ".${fileName.split('.').last}".toUpperCase();
  }
}

enum PickerImageType {
  camera,
  imageGallery,
  multiImageGallery,
}
