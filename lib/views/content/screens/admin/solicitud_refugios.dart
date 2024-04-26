import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mascotas_bga/controllers/auth/admin/solicitud_refugios_controller.dart';

import '../../../../helpers/shared.dart';

class SolicitudRefugiosScreen extends ConsumerStatefulWidget {
  const SolicitudRefugiosScreen({Key? key}) : super(key: key);

  @override
  SolicitudRefugiosScreenState createState() => SolicitudRefugiosScreenState();
}

class SolicitudRefugiosScreenState
    extends ConsumerState<SolicitudRefugiosScreen> {
  final SolicitudRefugiosController _controller = SolicitudRefugiosController();
  List<Map<String, dynamic>> refugios = [];

  @override
  void initState() {
    cargarRefugios();
    super.initState();
  }


  Future<void> cargarRefugios() async {
    final refugiosData = await _controller.getRefugios();
    setState(() {
      refugios = refugiosData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitudes Refugios'),
      ),
      body: Expanded(
        child: refugios.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: refugios.length,
                itemBuilder: (context, index) {
                  final publicacion = refugios[index];
                  return Card(
                      margin: const EdgeInsets.all(10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  publicacion["nombre_refugio"],
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.house_rounded,
                                                  color: Colors.purple,
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 20),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Text('Email:',
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.bold),),
                                                    Text(" ${publicacion["email_refugio"]}",
                                                    style: const TextStyle(fontWeight: FontWeight.w400),)  
                                                ]),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                      'Ciudad:', style: TextStyle(
                                                        fontSize: 14, fontWeight: FontWeight.bold),
                                                    ),
                                                    Text(" ${publicacion["ciudad_refugio"]}",
                                                    style: const TextStyle(fontWeight: FontWeight.w400),)
                                                ])
                                                ]),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Text('Barrio:',
                                                      style: TextStyle(
                                                        fontSize: 14, fontWeight: FontWeight.bold),
                                                    ),
                                                    Text(" ${publicacion["barrio_refugio"]}",
                                                    style: const TextStyle(fontWeight: FontWeight.w400),)
                                                ]),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                      'Dirección:', style: TextStyle(
                                                        fontSize: 14, fontWeight: FontWeight.bold),
                                                    ),
                                                    Text(" ${publicacion["direccion_refugio"]}",
                                                    style: const TextStyle(fontWeight: FontWeight.w400),)
                                                ])
                                                ]),
                                                const SizedBox(height: 10,),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Column(
                                                    children: [
                                                      const Text('Telefono:', style: TextStyle(
                                                        fontSize: 14, fontWeight: FontWeight.bold),
                                                    ),
                                                    Text(" ${publicacion["telefono_refugio"]}")
                                                ]),
                                                ]),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                              const Text('Descripción:',
                                                style:
                                                TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                                const SizedBox(height: 5),
                                              Text(" ${publicacion["desc_refugio"]}",
                                              style: const TextStyle(fontWeight: FontWeight.w400),
                                              textAlign: TextAlign.center,)
                                          ]),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                const Text('Misión:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                              ),
                                              const SizedBox(height: 5,),
                                              Text("${publicacion["mision_refugio"]}",
                                              style: const TextStyle(fontWeight: FontWeight.w400,),
                                              textAlign: TextAlign.center,)
                                          ]),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 15,),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text("Confirmación"),
                                                    content: const Text("¿Estás seguro de aceptar al refugio?"),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: const Text("Cancelar"),
                                                      ),
                                                      TextButton(
                                                        onPressed: () async {
                                                          await _controller.updateEstado(publicacion["id_refugio"], 1);
                                                          // ignore: use_build_context_synchronously
                                                          Navigator.of(context).pop();
                                                          cargarRefugios();
                                                        },
                                                        child: const Text("Aceptar"),
                                                        
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: const Text('Aceptar'),
                                          ),
                                          const SizedBox(width: 20),
                                          ElevatedButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text("Confirmación"),
                                                    content: const Text("¿Estás seguro de rechazar a este refugio?"),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: const Text("Cancelar"),
                                                      ),
                                                      TextButton(
                                                        onPressed: () async {
                                                          await _controller.updateEstado(publicacion["id_refugio"], 3);
                                                          // ignore: use_build_context_synchronously
                                                          Navigator.of(context).pop();
                                                          cargarRefugios();
                                                        },
                                                        child: const Text("Aceptar"),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: const Text('Rechazar'),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                ))
                          ]));
                },
              ),
      ),
    );
  }
}
