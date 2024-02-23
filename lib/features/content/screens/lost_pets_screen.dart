import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mascotas_bga/features/shared/shared.dart';

class LostPetsScreen extends StatefulWidget {
  const LostPetsScreen({super.key});

  @override
  State<LostPetsScreen> createState() => _LostPetsScreenState();
}

class _LostPetsScreenState extends State<LostPetsScreen> {
  TextEditingController name = TextEditingController();

  List mascotasLost = [];

  Future<void> getMascotasAdp() async {
    String uri = "http://192.168.1.7/mascotas/view_mascotas_lost.php";
    try {
      var response = await http.get(Uri.parse(uri));

      setState(() {
        mascotasLost = jsonDecode(response.body);
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
          itemCount: mascotasLost.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                title: Text(mascotasLost[index]["nombre_mascota_lost"]),
                subtitle: Text(mascotasLost[index]["raza_mascota_lost"]),
              ),
            );
          },
        ),
        bottomNavigationBar: const BottomNavigationUser()
        );
  }
}
