import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mascotas_bga/config/connect/connect_server.dart';
import 'package:mascotas_bga/controllers/providers/general/id_tipo_mascota_provider.dart';
import 'package:mascotas_bga/controllers/providers/providers.dart';
import 'package:riverpod/riverpod.dart';

class DropdownTipo extends ConsumerStatefulWidget {
  final TextEditingController controller;
  const DropdownTipo({super.key, required this.controller});

  @override
  DropdownTipoState createState() => DropdownTipoState();
}

class DropdownTipoState extends ConsumerState<DropdownTipo> {
  String? selectedTipo;
  List<dynamic> tipos = [];

  @override
  void initState() {
    super.initState();
    _cargarTipos();
  }

  Future<void> _cargarTipos() async {
    String uri = "http://$ipConnect/mascotas/input_tipos.php";
    var response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      var tiposJson = jsonDecode(response.body);
      setState(() {
        tipos = tiposJson;
      });
    } else {
      // Manejo de errores
      print('Solicitud fallida con status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final String ciudadId = ref.watch(idCiudadProvider);
    return DropdownButton(
      value: selectedTipo,
      hint: const Text(
        'Tipo de Mascota',
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black45),
      ),
      onChanged: (String? newValue) {
        setState(() {
          selectedTipo = newValue!;
          ref.read(idTipoMascotaProvider.notifier).setId(newValue);
        });
      },
      items: tipos.map<DropdownMenuItem<String>>((tipo) {
        return DropdownMenuItem<String>(
          value: tipo['id_tipo_mascota'].toString(),
          child: Text(
            tipo['nombre_tipo_mascota'],
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black45),
          ),
        );
      }).toList(),
    );
  }
}
