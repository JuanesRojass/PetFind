import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import 'package:mascotas_bga/helpers/shared.dart';
import 'package:mascotas_bga/config/connect/connect_server.dart';

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
                child: Stack(
                  children: [Padding(
                    padding: const EdgeInsets.all(50),
                    child: GestureDetector(
                      onTap: () {
                        context.push('/refugiosProfile', extra: refugios[index]);
                      },
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(1.0, 1.0, 30, 1.0),
                            child: Icon(
                              Icons.house_sharp,
                              size: 60,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(refugios[index]["nombre_refugio"]),
                              Text(refugios[index]["email_refugio"]),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: Row(
                    children: [
                      TextButton(
                        onPressed: () => context.push('/refugiosProfile', extra: refugios[index]),
                        child: const Text("Información y Mascotas",),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded)
                    ],
                  ))
                ]),
              ),
            );
          },
        ),
        bottomNavigationBar: const BottomNavigationUser());
  }
}
