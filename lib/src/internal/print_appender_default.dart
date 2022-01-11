import 'package:logging_appenders/logging_appenders.dart';
import 'package:logging_appenders/src/logrecord_formatter.dart';

import '../../level.dart';

LogRecordFormatter defaultLogRecordFormatter() =>
    const DefaultLogRecordFormatter();

PrintAppender defaultCreatePrintAppender({
  LogRecordFormatter? formatter,
  Level? stderrLevel,
}) =>
    PrintAppender(formatter: formatter);
