import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:mascotas_bga/features/shared/shared.dart';

class PetsScreen extends StatefulWidget {
  const PetsScreen({super.key});

  @override
  State<PetsScreen> createState() => _PetsScreenState();
}

class _PetsScreenState extends State<PetsScreen> {
  TextEditingController name = TextEditingController();

  List mascotasadp = [];

  Future<void> getMascotasAdp() async {
    String uri = "http://192.168.1.7/mascotas/view_mascotas_adp.php";
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
          automaticallyImplyLeading: false,
          title: const Text('Mascotas En Adopción'),
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
        ),
        bottomNavigationBar: const BottomNavigationUser());
  }
}
