import 'package:notes/mynote.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'dart:async';

// tahapan 3

class DBHelper{
  static final DBHelper _instance = new DBHelper.internal();
  // constructor si DBHelper
  DBHelper.internal();
  // helper database
  factory DBHelper() => _instance;
  // yang pertama kali digunakan , dia ngecek database
  static Database _db;
  // jika databasenya ada dia ambil, jika tidak ada dia akan membuatnya
  Future<Database> get db async{
    if(_db!=null)return _db; // jika ada database dia akan ambil
    else _db = await setDB(); // jika tidak ada dia akan membuat
    return _db; // kembalikan nilai ke _db
  }
  setDB()async{
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,"SimpleNoteDB"); // nama database yang kita akan gunakan
    var dB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return dB; // kita kembalikan nilai ke database
  }

  void _onCreate(Database db, int version) async{
    await db.execute("CREATE TABLE mynote(id INTEGER PRIMARY KEY, title TEXT, note TEXT, createDate TEXT, "
        "updateDate TEXT, sortDate TEXT)");
    print("DB Created");
  }
  // bagian ke 5 ,
  // proses penyimpanan data1
Future<int> saveNote(Mynote mynote) async{
    var dbClient = await db;
    int res= await dbClient.insert("mynote", mynote.toMap(), nullColumnHack: "id");
    print("data inserted");
    return res;
}
}