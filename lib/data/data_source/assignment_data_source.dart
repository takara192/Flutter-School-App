import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:school_app/data/model/assignment_model.dart';
import 'package:school_app/data/model/class_model.dart';

import '../../utils/helper/database_heper.dart';
import '../../utils/helper/date_time_converter.dart';

class AssignmentDataSource {
  Future deleteAssignment(int assignmentId) async {
    await DatabaseHelper.instance.database.then(
      (db) async {
        await db.delete(
          'assignments',
          where: 'assignment_id = ?',
          whereArgs: [assignmentId],
        );
      },
    );
  }

  Future toggleCompletedAssignment(int assignmentId, bool completed) async {
    await DatabaseHelper.instance.database.then(
      (db) async {
        await db.update(
          'assignments',
          {
            'completed': completed ? 1 : 0,
          },
          where: 'assignment_id = ?',
          whereArgs: [assignmentId],
        );
      },
    );
  }

  Future<int> getUncompletedAssignmentByDate(DateTime date) async {
    final String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    final List<Map<String, dynamic>> results =
        await DatabaseHelper.instance.database.then(
      (db) async {
        return await db.rawQuery('''
          SELECT schedule.date, COUNT(assignments.assignment_id) as uncompleted_count
          FROM assignments
          INNER JOIN schedule ON assignments.schedule_id = schedule.schedule_id
          WHERE assignments.completed = 0 AND schedule.date = ?
          GROUP BY schedule.date
        ''', [formattedDate]);
      },
    );

    if (results.isEmpty) {
      return 0;
    }

    return results[0]['uncompleted_count'];
  }

  Future addNewAssignment(AssignmentModel assignment, bool isPriority) async {
    await DatabaseHelper.instance.database.then(
      (db) async {
        Logger().d(assignment);

        await db.insert(
          'assignments',
          {
            'schedule_id': assignment.scheduleId,
            'title': assignment.title,
            'details': assignment.description,
            'due_date':
                DateTimeConverter.toIso8601DateOnly(assignment.dueDate!),
            'priority': isPriority ? 1 : 0,
            'completed': assignment.isCompleted ? 1 : 0,
          },
        );
      },
    );
  }

  Future<Map<ClassModel, List<AssignmentModel>>> fetchDueDateAssignment() async {
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final result = await DatabaseHelper.instance.database.then(
      (db) async {
        return await db.rawQuery('''
    SELECT 
      assignments.*,
      classes.*
    FROM 
      assignments
    JOIN 
      schedule ON assignments.schedule_id = schedule.schedule_id
    JOIN 
      classes ON schedule.class_id = classes.class_id
    WHERE 
      assignments.due_date = ?
  ''', [today]);
      },
    );

    final Map<ClassModel, List<AssignmentModel>> assignments = {};

    for (var element in result) {
      final classModel = ClassModel.fromMap(element);

      if (assignments[classModel] == null) {
        assignments[classModel] = [];
      }

      assignments[classModel]?.add(
        AssignmentModel.fromMap(element),
      );

    }

    return assignments;
  }

  Future<Map<ClassModel, List<AssignmentModel>>> fetchPriorityAssignment() async {

    final result = await DatabaseHelper.instance.database.then(
      (db) async {
        return await db.rawQuery('''
    SELECT 
      assignments.*,
      classes.*
    FROM 
      assignments
    JOIN 
      schedule ON assignments.schedule_id = schedule.schedule_id
    JOIN 
      classes ON schedule.class_id = classes.class_id
    WHERE 
      assignments.priority = 1
  ''');
      },
    );

    final Map<ClassModel, List<AssignmentModel>> assignments = {};


    for (var element in result) {
      final classModel = ClassModel.fromMap(element);

      if (assignments[classModel] == null) {
        assignments[classModel] = [];
      }

      final assignment = AssignmentModel.fromMap(element);

      assignments[classModel]?.add(
          assignment.copyWith(
            description: element['details'] as String,
          )
      );

    }


    return assignments;
  }
}
