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
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.warehouse_outlined,
                                                  color: Colors.purple,
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                    'Tipo: ${publicacion["email_refugio"]}',
                                                    style: const TextStyle(
                                                        fontSize: 14),
                                                  ),
                                                  Text(
                                                    'Raza: ${publicacion["ciudad_refugio"]}',
                                                    style: const TextStyle(
                                                        fontSize: 14),
                                                  )
                                                ]),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                    'Tamaño: ${publicacion["barrio_refugio"]}',
                                                    style: const TextStyle(
                                                        fontSize: 14),
                                                  ),
                                                  Text(
                                                    'Color: ${publicacion["direccion_refugio"]}',
                                                    style: const TextStyle(
                                                        fontSize: 14),
                                                  )
                                                ]),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                    'Sexo: ${publicacion["telefono_refugio"]}',
                                                    style: const TextStyle(
                                                        fontSize: 14),
                                                  ),
                                                ]),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Descripción: ${publicacion["desc_refugio"]}',
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Descripción: ${publicacion["mision_refugio"]}',
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
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
