import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:school_app/data/model/schedule_model.dart';
import 'package:school_app/utils/helper/database_heper.dart';

class ScheduleDataSource {
  Future<List<ScheduleModel>> getScheduleByDate(DateTime date) async {
    final String formattedDate = DateFormat('yyyy-MM-dd').format(date);

    final List<Map<String, dynamic>> results =
        await DatabaseHelper.instance.database.then((db) async {
      return await db.rawQuery('''
      
        SELECT schedule.*,
        classes.color as color,
        classes.class_id as class_id,
        classes.name AS title,
        assignments.title AS assignment_title,
        assignments.details AS assignment_details,
        assignments.due_date AS assignment_due_date,
        assignments.completed AS assignment_completed,
        assignments.assignment_id as assignment_id
        FROM schedule
        JOIN classes ON schedule.class_id = classes.class_id
        LEFT JOIN assignments ON schedule.schedule_id = assignments.schedule_id
        WHERE schedule.date = ?
        ORDER BY schedule.date ASC, schedule.start_time ASC
           
      ''', [formattedDate]);
    });

    List<Map<String, dynamic>> maps = [];

    for (var element in results) {
      bool found = false;
      for (var map in maps) {
        if (map['schedule_id'] == element['schedule_id']) {
          found = true;

          if (map['assignments'] == null) {
            map['assignments'] = [];
          }

          map['assignments'].add({
            'assignment_id': element['assignment_id'],
            'schedule_id': map['schedule_id'],
            'title': element['assignment_title'],
            'description': element['assignment_details'],
            'due_date': element['assignment_due_date'],
            'completed': element['assignment_completed'] == 1 ? 1 : 0,
          });
        }
      }

      if (!found) {
        maps.add({
          'class_id': element['class_id'],
          'title': element['title'],
          'room': element['room'],
          'color': element['color'].toString(),
          // Convert Color to an integer string
          'date': element['date'],
          // Store as 'YYYY-MM-DD'
          'start_time': element['start_time'],
          // Store as 'HH:MM:SS'
          'end_time': element['end_time'],
          // Store as 'HH:MM:SS'
          'schedule_id': element['schedule_id'],
          'assignments': [
            {
              'assignment_id': element['assignment_id'],
              'schedule_id': element['schedule_id'],
              'title': element['assignment_title'],
              'description': element['assignment_details'],
              'due_date': element['assignment_due_date'],
              'completed': element['assignment_completed'] == 1 ? 1 : 0,
            }
          ],
        });
      }
    }

    return maps.map((map) => ScheduleModel.fromMap(map)).toList();
  }

  Future<List<ScheduleModel>> getSchedules() async {
    final List<Map<String, dynamic>> results =
        await DatabaseHelper.instance.database.then((db) async {
      return await db.rawQuery('''
        SELECT 
        schedule.schedule_id AS schedule_id,
        schedule.class_id AS class_id,
        classes.name AS title,
        schedule.date as date,
        schedule.start_time AS start_time,
        schedule.end_time AS end_time,
        schedule.room AS room,
        classes.color as color
        FROM 
          schedule
        INNER JOIN 
          classes ON schedule.class_id = classes.class_id
        ORDER BY 
          schedule.date, schedule.start_time
          ''');
    });

    return results.map((map) => ScheduleModel.fromMap(map)).toList();
  }

  Future addNewSchedule({
    required int classId,
    required DateTime date,
    required DateTime startTime,
    required DateTime endTime,
    required String room,
  }) async {
    final String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    final String formattedStartTime = DateFormat('HH:mm:ss').format(startTime);
    final String formattedEndTime = DateFormat('HH:mm:ss').format(endTime);

    await DatabaseHelper.instance.database.then((db) async {
      await db.rawInsert('''
        INSERT INTO schedule (class_id, date, start_time, end_time, room)
        VALUES (?, ?, ?, ?, ?)
      ''',
          [classId, formattedDate, formattedStartTime, formattedEndTime, room]);
    });
  }
}
