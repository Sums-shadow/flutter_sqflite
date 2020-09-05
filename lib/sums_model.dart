class SumsModel{
  final int id;
  final String nom;
  final String desc;

  SumsModel({this.id,this.nom,this.desc});

  Map<String,dynamic> toMap(){ // utiliser quand on insert une donée dans la bd
    return <String,dynamic>{
      "id" : id,
      "nom" : nom,
      "desc" : desc,
    };
  }
}