import 'package:flutter_riverpod/flutter_riverpod.dart';

class NombreCiudadNotifier extends StateNotifier<String> {
  NombreCiudadNotifier() : super("");

  void setName(String newName) {
    state = newName;
  }
}

final nombreCiudadProvider =
    StateNotifierProvider<NombreCiudadNotifier, String>((ref) => NombreCiudadNotifier());