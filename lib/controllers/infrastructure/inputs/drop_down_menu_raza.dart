import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mascotas_bga/config/connect/connect_server.dart';
import 'package:mascotas_bga/controllers/providers/general/id_tipo_mascota_provider.dart';
import 'package:mascotas_bga/controllers/providers/providers.dart';

class DropdownRazas extends ConsumerStatefulWidget {
  final TextEditingController controller;
  const DropdownRazas({super.key, required this.controller});

  @override
  DropdownRazasState createState() => DropdownRazasState();
}

class DropdownRazasState extends ConsumerState<DropdownRazas> {
  String? selectedRazas;
  List<dynamic> razas = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final String idTipo = ref.read(idTipoMascotaProvider);
      if (idTipo != "0") {
        _cargarRazas(idTipo);
      }
    });
  }

  @override
  void didUpdateWidget(covariant DropdownRazas oldWidget) {
    super.didUpdateWidget(oldWidget);
    final String idTipo = ref.read(idTipoMascotaProvider);
    if (idTipo != "0" && idTipo != ref.read(idTipoMascotaProvider)) {
      _cargarRazas(idTipo);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String idTipo = ref.watch(idTipoMascotaProvider);
    if (idTipo != "0") {
      _cargarRazas(idTipo);
    }
    return DropdownButton(
      value: selectedRazas,
      hint: const Text(
        'Razas',
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black45),
      ),
      onChanged: (String? newValue) {
        setState(() {
          selectedRazas = newValue!;
          ref.read(idRazaProvider.notifier).setId(newValue);
        });
      },
      items: razas.map<DropdownMenuItem<String>>((raza) {
        return DropdownMenuItem<String>(
          value: raza['id_raza'].toString(),
          child: SizedBox(
            width: 200,
            child: Text(
              raza['nombre_raza'],
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black45),
          ),
            )
            
        );
      }).toList(),
    );
  }

  Future<void> _cargarRazas(String idTipo) async {
    String uri =
        "http://$ipConnect/mascotas/input_razas.php?idTipo=$idTipo";
    // print("Id de Tipo actualizado $idTipo");
    var response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200 && mounted) {
      var razasJson = jsonDecode(response.body);
      setState(() {
        razas = razasJson;
        if (!razas.any(
            (raza) => raza['id_raza'].toString() == selectedRazas)) {
          selectedRazas = null;
        }
      });
    } else {
      // Manejo de errores
      print('Solicitud fallida con status: ${response.statusCode}.');
    }
  }
}