import 'dart:io';

import 'package:my_global_tools/utils/default_logger.dart';

class FileService {
  static const String tag = 'FileService';

  /// Function that writes file to the disk
  ///
  /// [path] has to be a fully qualified path
  /// [content] is the raw file contents as string
  static void writeFile(
    String path,
    String content,
  ) {
    try {
      final file = File(replaceAsExpected(path: path));
      file.createSync(recursive: true);
      file.writeAsStringSync(content);
      successLog('Created $path', tag);
    } on FileSystemException catch (err) {
      errorLog('${err.message} -> $path', tag);
    }
  }

  static final Map<String, String> _paths = {
    'feature': replaceAsExpected(path: 'lib'),
    'example': replaceAsExpected(path: 'example'),
  };

  /// Contains all the available path mappings
  static Map<String, String> get paths => _paths;

  /// Function that replaces the path string depending on the platform
  static String replaceAsExpected({required String path, String? replaceChar}) {
    if (path.contains('\\')) {
      if (Platform.isLinux || Platform.isMacOS) {
        return path.replaceAll('\\', '/');
      } else {
        return path;
      }
    } else if (path.contains('/')) {
      if (Platform.isWindows) {
        return path.replaceAll('/', '\\\\');
      } else {
        return path;
      }
    } else {
      return path;
    }
  }
}
