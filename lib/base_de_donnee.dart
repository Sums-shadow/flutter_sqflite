
import 'package:sqflite/sqflite.dart'; // package sqflite
import 'package:path_provider/path_provider.dart'; //path_provider package
import 'package:path/path.dart'; //utile pour concatner les path
import 'sums_model.dart'; //importer la class memo
import 'dart:io';
import 'dart:async';

class SumsDbProvider{
    var table="sumsTable";
    var db_name="sumsdb.db";
Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory(); // renvoi un dossier qui stock les fichiers de maniere permanente
    final path = join(directory.path,db_name); //creer le chemin ers la base de donnée

      return await openDatabase( //ouvre la base de donnée ou l'ouvre si elle n'existe pas
        path,
        version: 1,
        onCreate: (Database db,int version) async{
          await db.execute("""
          CREATE TABLE $table(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nom TEXT,
          desc TEXT)"""
      );
    });
  }

  Future<int> addItem(SumsModel item) async{ //renvoi le nombre d'item inserer 
    final db = await init(); //ouverture de la base de donée
    return db.insert(table, item.toMap(), //la fonction toMap() du model
    conflictAlgorithm: ConflictAlgorithm.ignore, // ignore certaines duplications d'entrée 
    );
 }

 Future<List<SumsModel>> fetchSums() async{ //renvoi le model comme une liste
    
    final db = await init();
    final maps = await db.query(""); // interroge la bd sur toutes les row dans la table comme un tableau de maps

    return List.generate(maps.length, (i) { //cree une liste du model
      return SumsModel(              
        id: maps[i]['id'],
        nom: maps[i]['nom'],
        desc: maps[i]['desc'],
      );
  });
  }

  Future<int> deleteSums(int id) async{ //renvoi le numero de l'element supprimer
    final db = await init();
  
    int result = await db.delete(
      table, //nom de la table
      where: "id = ?",
      whereArgs: [id] // utilise whereArgs pour echapper au sql injection
    );

    return result;
  }

  
Future<int> updateSums(int id, SumsModel item) async{ // renvoi le numero de 'lelement mise a jours
  
    final db = await init();
  
    int result = await db.update(
      table, 
      item.toMap(),
      where: "id = ?",
      whereArgs: [id]
      );
      return result;
 }
    
}