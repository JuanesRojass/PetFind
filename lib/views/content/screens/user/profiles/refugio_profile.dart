import 'dart:convert';
import 'package:mascotas_bga/config/connect/connect_server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mascotas_bga/controllers/providers/general/id_refugio_info.dart';
import 'package:http/http.dart' as http;

class RefugioProfile extends ConsumerStatefulWidget {
  const RefugioProfile({super.key, required this.refugio});

  @override
  RefugioProfileState createState() => RefugioProfileState();
  final Map refugio;
}

class RefugioProfileState extends ConsumerState<RefugioProfile> {
  List direcciones = [];
  List telefonos = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cargarDatosRefugio();
  }

  Future<void> cargarDatosRefugio() async {
    final idRefugio = ref.watch(idRefugioInfoProvider.notifier).state;
    final url = Uri.parse(
        'http://$ipConnect/mascotas/view_refugio_info.php?id_refugio=$idRefugio');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        direcciones = data['direcciones'];
        telefonos = data['telefonos'];
      });
    } else {
      // Manejar el error
      print("Error al obtener los datos del refugio.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${widget.refugio["nombre_refugio"] ?? "Refugio"}'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Email: ${widget.refugio["email_refugio"] ?? ""}"),
            const SizedBox(
              height: 20,
            ),
            const Text("Direcciones:"),
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: direcciones.length,
                itemBuilder: (context, index) {
                  final direccion = direcciones[index];
                  return Card(
                    child: ListTile(
                      title: Text("Ciudad: ${direccion["ciudad_refugio"]}"),
                      subtitle: Text(
                          "Barrio: ${direccion["barrio_refugio"]}\nDirección: ${direccion["direccion_refugio"]}"),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10,),
            const Text("Telefonos:"),
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: telefonos.length,
                itemBuilder: (context, index) {
                  final telefono = telefonos[index];
                  return Card(
                    child: ListTile(
                      title: Text("Teléfono: ${telefono["telefono_refugio"]}"),
                    ),
                  );
                },
              ),
            ),
            Text("Sobre Nosotros: ${widget.refugio["desc_refugio"] ?? ""}"),
            const SizedBox(
              height: 20,
            ),
            const Center(
                child: Text(
              "Mascotas",
              style: TextStyle(fontSize: 20),
            )),
          ]),
        ));
  }
}
