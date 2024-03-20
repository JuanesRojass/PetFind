import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mascotas_bga/config/connect/connect_server.dart';
import 'package:mascotas_bga/controllers/providers/providers.dart';

class DropdownBarrios extends ConsumerStatefulWidget {
  const DropdownBarrios({Key? key}) : super(key: key);

  @override
  DropdownBarriosState createState() => DropdownBarriosState();
}

class DropdownBarriosState extends ConsumerState<DropdownBarrios> {
  String? selectedBarrios;
  List<dynamic> barrios = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final String idCiudad = ref.read(idCiudadProvider);
      if (idCiudad != "0") {
        _cargarBarrios(idCiudad);
      }
    });
  }

  @override
  void didUpdateWidget(covariant DropdownBarrios oldWidget) {
    super.didUpdateWidget(oldWidget);
    final String idCiudad = ref.read(idCiudadProvider);
    if (idCiudad != "0" && idCiudad != ref.read(idCiudadProvider)) {
      _cargarBarrios(idCiudad);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String idCiudad = ref.watch(idCiudadProvider);
    if (idCiudad != "0") {
      _cargarBarrios(idCiudad);
    }
    return DropdownButton(
      value: selectedBarrios,
      hint: const Text(
        'Barrio',
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black45),
      ),
      onChanged: (String? newValue) {
        setState(() {
          selectedBarrios = newValue!;
        });
      },
      items: barrios.map<DropdownMenuItem<String>>((barrio) {
        return DropdownMenuItem<String>(
          value: barrio['id_barrio'].toString(),
          child: Text(
            barrio['nombre_barrio'],
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black45),
          ),
        );
      }).toList(),
    );
  }

  Future<void> _cargarBarrios(String idCiudad) async {
    String uri =
        "http://$ipConnect/mascotas/input_barrios.php?idCiudad=$idCiudad";
    print("Id de ciudad actualizada $idCiudad");
    var response = await http.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      var barriosJson = jsonDecode(response.body);
      setState(() {
        barrios = barriosJson;
        if (!barrios.any(
            (barrio) => barrio['id_barrio'].toString() == selectedBarrios)) {
          selectedBarrios = null;
        }
      });
    } else {
      // Manejo de errores
      print('Solicitud fallida con status: ${response.statusCode}.');
    }
  }
}
