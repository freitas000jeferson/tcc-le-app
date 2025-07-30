import 'package:tcc_le_app/core/database/tables/message.dart';

class Migration01 {
  static const script = [
    '''
      CREATE TABLE messages(
        ${MessageVarNames.id}  INTEGER PRIMARY KEY AUTOINCREMENT,
        ${MessageVarNames.objectId} TEXT,
        ${MessageVarNames.userId} TEXT,
        ${MessageVarNames.from} TEXT,
        ${MessageVarNames.to} TEXT,
        ${MessageVarNames.textBody} TEXT,
        ${MessageVarNames.imageBody} TEXT,
        ${MessageVarNames.metadata} TEXT,
        ${MessageVarNames.buttonsBody} TEXT,
        ${MessageVarNames.date} TEXT,
        ${MessageVarNames.userDate} INTEGER,
        ${MessageVarNames.isViewer} INTEGER
      )
    ''',
  ];
}
