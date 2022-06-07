import 'package:cloud_firestore/cloud_firestore.dart';

class Travel {
  String? id;
  int? No;
  String? dep;
  
  int? price;

  Travel({
    this.id,
    required this.dep,
    required this.No,
    required this.price,
  });

  Travel.fromMap(DocumentSnapshot data) {
    id = data.id;
    No = data["No"];
    dep = data["dep"];
    
    price = data["price"];
  }
}
