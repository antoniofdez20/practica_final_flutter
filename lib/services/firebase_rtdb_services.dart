import 'package:firebase_database/firebase_database.dart';

class FirebaseRealtimeService {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  // Método para leer datos
  Future<DataSnapshot> readData(String path) async {
    DataSnapshot snapshot = await _dbRef.child(path).get();
    return snapshot;
  }

  // Método para escribir o actualizar datos
  Future<void> writeData(String path, Map<String, dynamic> data) async {
    await _dbRef.child(path).set(data);
  }

  // Método para actualizar datos específicos sin sobrescribir todo el objeto
  Future<void> updateData(String path, Map<String, dynamic> data) async {
    await _dbRef.child(path).update(data);
  }

  // Método para eliminar datos
  Future<void> deleteData(String path) async {
    await _dbRef.child(path).remove();
  }
}
