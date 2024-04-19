import 'package:flutter_riverpod/flutter_riverpod.dart';

class NombreRazaNotifier extends StateNotifier<String> {
  NombreRazaNotifier() : super("");

  void setName(String newName) {
    state = newName;
  }
}

final nombreRazaProvider =
    StateNotifierProvider<NombreRazaNotifier, String>((ref) => NombreRazaNotifier());