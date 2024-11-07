import 'package:school_app/data/model/class_model.dart';

import '../../utils/helper/database_heper.dart';

class ClassDataSource {
  Future<List<ClassModel>> getAllClasses() async {
    return await DatabaseHelper.instance.database.then(
      (db) async {
        final List<Map<String, dynamic>> results = await db.query('classes');

        return results.map((e) => ClassModel.fromMap(e)).toList();
      },
    );
  }

  Future<void> insertClass(ClassModel classModel) async {
    return await DatabaseHelper.instance.database.then(
      (db) async {
        await db.insert('classes', classModel.toMap());
      },
    );
  }

  Future<void> updateClass(ClassModel classModel) async {
    return await DatabaseHelper.instance.database.then(
      (db) async {
        await db.update(
          'classes',
          classModel.toMap(),
          where: 'class_id = ?',
          whereArgs: [classModel.id],
        );
      },
    );
  }
}
