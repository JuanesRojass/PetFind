import 'package:flutter_riverpod/flutter_riverpod.dart';

// final idCiudadProvider= StateProvider<String>((ref) => "0");

class TipoMascotaNotifier extends StateNotifier<String> {
  TipoMascotaNotifier() : super("0");

  void setId(String newId) {
  state = newId;
}
}

final idTipoMascotaProvider = StateNotifierProvider<TipoMascotaNotifier, String>((ref) {
  return TipoMascotaNotifier();
});


class RazaIdNotifier extends StateNotifier<String> {
  RazaIdNotifier() : super("0");

  void setId(String newId) {
  state = newId;
}
}

final idRazaProvider = StateNotifierProvider<RazaIdNotifier, String>((ref) {
  return RazaIdNotifier();
});
