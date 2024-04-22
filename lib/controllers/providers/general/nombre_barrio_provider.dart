import 'package:flutter_riverpod/flutter_riverpod.dart';

class NombreBarrioNotifier extends StateNotifier<String> {
  NombreBarrioNotifier() : super("");

  void setName(String newName) {
    state = newName;
  }
}

final nombreBarrioProvider =
    StateNotifierProvider<NombreBarrioNotifier, String>((ref) => NombreBarrioNotifier());