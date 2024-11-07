import 'dart:math';

import 'package:intl/intl.dart';
import 'package:school_app/data/model/assignment_model.dart';
import 'package:sqflite/sqflite.dart';

import '../constants.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if(_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = dbPath + Constants.dbName;

    bool dbExists = await databaseExists(path);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        if(!dbExists) {
          await db.execute('''
          CREATE TABLE classes (
            class_id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            room TEXT,
            color TEXT
          )
        ''');

          await db.execute('''
          CREATE TABLE schedule (
            schedule_id INTEGER PRIMARY KEY AUTOINCREMENT,
            class_id INTEGER,
            date TEXT NOT NULL,           -- Store as ISO 8601 string (YYYY-MM-DD)
            start_time TEXT NOT NULL,     -- Store as TEXT (HH:MM:SS)
            end_time TEXT NOT NULL,       -- Store as TEXT (HH:MM:SS)
            room TEXT,
            FOREIGN KEY (class_id) REFERENCES classes(class_id)
          )
        ''');

          await db.execute('''
          CREATE TABLE assignments (
            assignment_id INTEGER PRIMARY KEY AUTOINCREMENT,
            schedule_id INTEGER,
            title TEXT NOT NULL,
            details TEXT,
            due_date TEXT,               -- Store as ISO 8601 string (YYYY-MM-DD)
            priority INTEGER DEFAULT 0,  -- Use 1 for true, 0 for false
            completed INTEGER DEFAULT 0, -- Use 1 for true, 0 for false
            FOREIGN KEY (schedule_id) REFERENCES schedule(schedule_id)
          )
        ''');
        }
      },
    );
  }

  static Future<void> _insertFakeData() async {
    final Random random = Random();
    final DateTime today = DateTime.now();
    Database db = _database!;

    // Insert multiple records into the classes table
    List<Map<String, dynamic>> classesData = [
      {'name': 'Math 101', 'room': 'Room A', 'color': '0xff4285F4'},
      {'name': 'History 201', 'room': 'Room B', 'color': '0xffDB4437'},
      {'name': 'Science 301', 'room': 'Room C', 'color': '0xffF4B400'},
      {'name': 'Art 101', 'room': 'Room D', 'color': '0xff34A853'},
      {'name': 'Music 101', 'room': 'Room E', 'color': '0xffFBBC05'},
    ];

    // Insert fake data for classes
    for (var classData in classesData) {
      await db.insert('classes', classData);
    }

    // Generate schedules for the next 10 days with different times
    List<int> classIds = [1, 2, 3, 4, 5];
    for (int i = 0; i < 20; i++) {
      DateTime scheduleDate = today.add(Duration(days: i % 10)); // Spread across 10 days
      String formattedDate = scheduleDate.toIso8601String().split('T').first; // YYYY-MM-DD

      // Random start and end times
      int startHour = 8 + random.nextInt(8); // Random start between 8 AM and 4 PM
      int endHour = startHour + 1 + random.nextInt(2); // 1-2 hours duration
      String startTime = '${startHour.toString().padLeft(2, '0')}:00:00';
      String endTime = '${endHour.toString().padLeft(2, '0')}:30:00';

      await db.insert('schedule', {
        'class_id': classIds[random.nextInt(classIds.length)], // Random class ID
        'date': formattedDate,
        'start_time': startTime,
        'end_time': endTime,
        'room': 'Room ${String.fromCharCode(65 + random.nextInt(5))}', // Random room A-E
      });
    }

    // Generate assignments for each schedule with random completion and priority
    for (int i = 1; i <= 20; i++) {
      int numberOfAssignments = 1 + random.nextInt(3); // 1 to 3 assignments per schedule

      for (int j = 0; j < numberOfAssignments; j++) {
        DateTime dueDate = today.add(Duration(days: 1 + random.nextInt(10))); // Due within next 10 days
        String formattedDueDate = dueDate.toIso8601String().split('T').first;

        await db.insert('assignments', {
          'schedule_id': i,
          'title': 'Assignment ${j + 1} for Schedule $i',
          'details': 'Complete assignment ${j + 1} for class ${i}',
          'due_date': formattedDueDate,
          'priority': random.nextInt(2), // 0 or 1
          'completed': random.nextInt(2), // 0 or 1
        });
      }
    }

    print('Fake data inserted successfully');
  }

  static Future<void> insertFakeData() async {
    final db = await instance.database;
    final today = DateTime.now();
    final random = Random();

    // Insert fake data into `classes` table
    for (int i = 0; i < 5; i++) {
      String className = 'Class ${String.fromCharCode(65 + i)}'; // Class A, B, C, etc.
      String room = 'Room ${random.nextInt(10) + 1}';
      String color = ['Red', 'Blue', 'Green', 'Yellow', 'Purple'][random.nextInt(5)];

      int classId = await db.insert('classes', {
        'name': className,
        'room': room,
        'color': color,
      });

      // Insert related fake data into `schedule` table
      for (int j = 0; j < 3; j++) {
        final date = today.add(Duration(days: random.nextInt(7))); // Random day within the next week
        final startTime = DateFormat('HH:mm:ss').format(DateTime(0, 0, 0, 9 + random.nextInt(3))); // Random start time between 9:00-12:00
        final endTime = DateFormat('HH:mm:ss').format(DateTime(0, 0, 0, 13 + random.nextInt(3))); // Random end time between 13:00-16:00
        final room = 'Room ${random.nextInt(10) + 1}';

        int scheduleId = await db.insert('schedule', {
          'class_id': classId,
          'date': DateFormat('yyyy-MM-dd').format(date),
          'start_time': startTime,
          'end_time': endTime,
          'room': room,
        });

        // Insert related fake data into `assignments` table
        for (int k = 0; k < 2; k++) {
          final dueDate = date.add(Duration(days: k + 1)); // Due date 1-2 days after schedule date
          final title = 'Assignment ${j + 1}-${k + 1}';
          final details = 'Details for assignment ${j + 1}-${k + 1}';
          final priority = random.nextBool() ? 1 : 0;
          final completed = random.nextBool() ? 1 : 0;

          await db.insert('assignments', {
            'schedule_id': scheduleId,
            'title': title,
            'details': details,
            'due_date': DateFormat('yyyy-MM-dd').format(dueDate),
            'priority': priority,
            'completed': completed,
          });
        }
      }
    }
  }

  static Future<void> insertMoreFakeData() async {
    final db = await instance.database;
    final today = DateTime.now();
    final random = Random();

    // Insert fake data into `classes` table (10 classes)
    for (int i = 0; i < 10; i++) {
      String className = 'Class ${String.fromCharCode(65 + i)}'; // Class A, B, C, etc.
      String room = 'Room ${random.nextInt(20) + 1}'; // Random room number between 1 and 20
      String color = ['#FF5733', '#33FF57', '#3357FF', '#F0A020', '#20F0A0', '#A020F0'][random.nextInt(6)];

      int classId = await db.insert('classes', {
        'name': className,
        'room': room,
        'color': color,
      });

      // Insert related fake data into `schedule` table (5 schedules per class)
      for (int j = 0; j < 5; j++) {
        final date = today.add(Duration(days: random.nextInt(30))); // Random day within the next month
        final startTime = DateFormat('HH:mm:ss').format(DateTime(0, 0, 0, 8 + random.nextInt(4))); // Random start time between 8:00-12:00
        final endTime = DateFormat('HH:mm:ss').format(DateTime(0, 0, 0, 13 + random.nextInt(4))); // Random end time between 13:00-17:00
        final scheduleRoom = 'Room ${random.nextInt(20) + 1}';

        int scheduleId = await db.insert('schedule', {
          'class_id': classId,
          'date': DateFormat('yyyy-MM-dd').format(date),
          'start_time': startTime,
          'end_time': endTime,
          'room': scheduleRoom,
        });

        // Insert related fake data into `assignments` table (3 assignments per schedule)
        for (int k = 0; k < 3; k++) {
          final dueDate = date.add(Duration(days: random.nextInt(5) + 1)); // Due date 1-5 days after schedule date
          final title = 'Assignment ${j + 1}-${k + 1} for Class ${className}';
          final details = 'Details for assignment ${j + 1}-${k + 1} related to ${className}';
          final priority = random.nextBool() ? 1 : 0;
          final completed = random.nextBool() ? 1 : 0;

          await db.insert('assignments', {
            'schedule_id': scheduleId,
            'title': title,
            'details': details,
            'due_date': DateFormat('yyyy-MM-dd').format(dueDate),
            'priority': priority,
            'completed': completed,
          });
        }
      }
    }
  }


}