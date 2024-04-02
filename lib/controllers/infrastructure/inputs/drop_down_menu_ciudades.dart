import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mascotas_bga/config/connect/connect_server.dart';
import 'package:mascotas_bga/controllers/providers/providers.dart';
import 'package:riverpod/riverpod.dart';

class DropdownCiudades extends ConsumerStatefulWidget {
  final TextEditingController controller;
  const DropdownCiudades({super.key, required this.controller});

  @override
  DropdownCiudadesState createState() => DropdownCiudadesState();
}

class DropdownCiudadesState extends ConsumerState<DropdownCiudades> {
  String? selectedCiudad;
  List<dynamic> ciudades = [];

  @override
  void initState() {
    super.initState();
    _cargarCiudades();
  }

  Future<void> _cargarCiudades() async {
    String uri = "http://$ipConnect/mascotas/input_ciudades.php";
    var response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      var ciudadesJson = jsonDecode(response.body);
      setState(() {
        ciudades = ciudadesJson;
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
      value: selectedCiudad,
      hint: const Text(
        'Ciudad del Refugio',
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black45),
      ),
      onChanged: (String? newValue) {
        setState(() {
          selectedCiudad = newValue!;
          ref.read(idCiudadProvider.notifier).setId(newValue);
        });
      },
      items: ciudades.map<DropdownMenuItem<String>>((ciudad) {
        return DropdownMenuItem<String>(
          value: ciudad['id_ciudad'].toString(),
          child: Text(
            ciudad['nombre_ciudad'],
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
