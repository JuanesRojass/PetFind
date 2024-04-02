import 'package:flutter_riverpod/flutter_riverpod.dart';

// final idCiudadProvider= StateProvider<String>((ref) => "0");

class CiudadIdNotifier extends StateNotifier<String> {
  CiudadIdNotifier() : super("0");

  void setId(String newId) {
  state = newId;
}
}

final idCiudadProvider = StateNotifierProvider<CiudadIdNotifier, String>((ref) {
  return CiudadIdNotifier();
});


class BarrioIdNotifier extends StateNotifier<String> {
  BarrioIdNotifier() : super("0");

  void setId(String newId) {
  state = newId;
}
}

final idBarrioProvider = StateNotifierProvider<BarrioIdNotifier, String>((ref) {
  return BarrioIdNotifier();
});
