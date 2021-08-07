import 'package:json_dio_sqflite/models/service_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ServiceDatabase {
  static final ServiceDatabase instance = ServiceDatabase._init();
  static Database _database;
  ServiceDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDB('services.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    await db.execute(
        'CREATE TABLE SERVICE ( ${UserFields.id} $idType, ${UserFields.name} $textType, ${UserFields.username} $textType,${UserFields.email} $textType,${UserFields.phno} $textType)');
  }

  Future<Service> create(Service service) async {
    final db = await instance.database;

    final id = await db.insert('SERVICE', service.toJson());
    return service.copy(id: id);
  }

  Future<Service> readSingleUser(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      'SERVICE',
      columns: UserFields.values,
      where: '${UserFields.id}=?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Service.fromJson(maps.first);
    } else {
      print('Error');
      throw Exception('ID $id is not found');
    }
  }

  Future<List<Service>> readAllUser() async {
    final db = await instance.database;
    final result = await db.query(
      'SERVICE',
    );
    return result.map((e) => Service.fromJson(e)).toList();
  }

  Future<int> update(Service service) async {
    final db = await instance.database;
    return db.update('SERVICE', service.toJson(),
        where: '${UserFields.id}=?', whereArgs: [service.id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
