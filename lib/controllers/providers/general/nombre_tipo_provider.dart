import 'package:flutter_riverpod/flutter_riverpod.dart';

class NombreTipoNotifier extends StateNotifier<String> {
  NombreTipoNotifier() : super("");

  void setName(String newName) {
    state = newName;
  }
}

final nombreTipoProvider =
    StateNotifierProvider<NombreTipoNotifier, String>((ref) => NombreTipoNotifier());