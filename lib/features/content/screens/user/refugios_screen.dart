import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import 'package:mascotas_bga/features/shared/shared.dart';
import 'package:mascotas_bga/features/providers/connect_provider.dart';

class RefugiosScreen extends StatefulWidget {
  const RefugiosScreen({super.key});

  @override
  State<RefugiosScreen> createState() => _RefugiosScreenState();
}

class _RefugiosScreenState extends State<RefugiosScreen> {
  TextEditingController name = TextEditingController();

  List refugios = [];

  Future<void> getMascotasAdp() async {
    String uri = "http://$ipConnect/mascotas/view_refugios.php";
    try {
      var response = await http.get(Uri.parse(uri));

      setState(() {
        refugios = jsonDecode(response.body);
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
          title: const Text('Refugios'),
        ),
        body: ListView.builder(
          itemCount: refugios.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: GestureDetector(
                    onTap: () {
                      context.push('/refugiosPerfil');
                    },
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(1.0, 1.0, 30, 1.0),
                          child: Icon(Icons.house_sharp, size: 60,),
                        ),
                        Column(
                          children: [
                            Text(refugios[index]["nombre_refugio"]),
                            Text(refugios[index]["email_refugio"]),
                          ],
                        ),                  
                      ],
                    ),
                  ),
                ),
              ),
            );
            
          },
        ),
        bottomNavigationBar: const BottomNavigationUser());
  }
}
