import 'package:ansicolor/ansicolor.dart';
import 'package:flutter/foundation.dart';

AnsiPen _blackLog = AnsiPen()..black(bold: true);
AnsiPen _infoLog = AnsiPen()..cyan(bold: true);
AnsiPen _successLog = AnsiPen()..green(bold: true);
AnsiPen _warningLog = AnsiPen()..yellow(bold: true);
AnsiPen _tagLog = AnsiPen()..magenta(bold: true);
AnsiPen _errorLog = AnsiPen()..red(bold: true);

blackLog(String data, [String? tag, String? extra]) =>
    logD(_blackLog(data), tag, extra);
infoLog(String data, [String? tag, String? extra]) =>
    logD(_infoLog('ℹ $data'), tag, extra);
successLog(String data, [String? tag, String? extra]) =>
    logD(_successLog('✔ $data'), tag, extra);
warningLog(String data, [String? tag, String? extra]) =>
    logD(_warningLog('⚠️ $data'), tag, extra);
errorLog(String data, [String? tag, String? extra]) =>
    logD(_errorLog('💀 $data'), tag, extra);

logD(String data, [String? tag, String? extra, bool colored = false]) {
  ansiColorDisabled = colored;
  debugPrint(
      '${_blackLog('--->')}${tag != null ? _tagLog('<$tag> ') : ''} $data ${extra != null ? ('<$extra> ') : ''} ${_blackLog('<---')}');
}
