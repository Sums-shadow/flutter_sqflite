import 'package:flutter/widgets.dart';
import 'base_de_donnee.dart';
import './sums_model.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SumsDbProvider memoDb = SumsDbProvider();

  final sums = SumsModel(
    id: 1,
    nom: 'Intelligence artificiel',
    desc: 'La technologie du future',
  );

  await memoDb.addItem(sums);
  var Sums = await memoDb.fetchSums();
  print(Sums[0].nom); // va afficher intelligence artificiel

  final newmemo = SumsModel(
    id: sums.id,
    nom: 'Realite virtuelle',
    desc: sums.desc,
  );

  await memoDb.updateSums(sums.id, newmemo);
  var updatedSums = await memoDb.fetchSums();
  print(updatedSums[0].nom); //Realité virtuelle

  await memoDb.deleteSums(sums.id);
  print(await memoDb.fetchSums()); //[]

}