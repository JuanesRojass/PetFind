import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:mascotas_bga/features/providers/connect_provider.dart';

class PetsRefugioScreen extends StatefulWidget {
  const PetsRefugioScreen({super.key});

  @override
  State<PetsRefugioScreen> createState() => _PetsRefugioScreenState();
}

class _PetsRefugioScreenState extends State<PetsRefugioScreen> {
  TextEditingController name = TextEditingController();

  List mascotasadp = [];

  Future<void> getMascotasAdp() async {
    String uri = "http://$ipConnect/mascotas/view_mascotas_adp.php";
    try {
      var response = await http.get(Uri.parse(uri));

      setState(() {
        mascotasadp = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getMascotasAdp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mascotas Adopción'),
        ),
        body: ListView.builder(
          itemCount: mascotasadp.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                title: Text(mascotasadp[index]["nombre_mascota_adp"]),
                subtitle: Text(mascotasadp[index]["raza_mascota_adp"]),
              ),
            );
          },
        ));
  }
}