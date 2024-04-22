import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mascotas_bga/config/connect/connect_server.dart';
import 'package:mascotas_bga/controllers/providers/providers.dart';
import 'package:mascotas_bga/controllers/utils/delete_message.dart';
import 'package:mascotas_bga/models/userEdit/publicaciones_lost_user_model.dart';

import '../../../../helpers/shared.dart';

class PublicacionesLostUserScreen extends ConsumerStatefulWidget {
  const PublicacionesLostUserScreen({Key? key}) : super(key: key);

  @override
  PublicacionesLostUserScreenState createState() =>
      PublicacionesLostUserScreenState();
}

class PublicacionesLostUserScreenState
    extends ConsumerState<PublicacionesLostUserScreen> {
  final PublicacionesLostUserModel _controller = PublicacionesLostUserModel();
  List<Map<String, dynamic>> publicaciones = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final idCliente = ref.watch(idClienteProvider);
    final idClienteInt = int.parse(idCliente);
    cargarPublicaciones(idClienteInt);
  }

  Future<void> cargarPublicaciones(int idCliente) async {
    final publicacionesData = await _controller.getPublicaciones(idCliente);
    setState(() {
      publicaciones = publicacionesData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Publicaciones'),
      ),
      body: Expanded(
        child: publicaciones.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: publicaciones.length,
                itemBuilder: (context, index) {
                  final publicacion = publicaciones[index];
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
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(9.0),
                                  child: CarouselSlider(
                                    options: CarouselOptions(
                                      height: 300,
                                      viewportFraction: 1.0,
                                      enableInfiniteScroll: false,
                                      aspectRatio: 16 / 9,
                                    ),
                                    items: [
                                      if (publicaciones[index]
                                              ["imagen_mascota"] !=
                                          null)
                                        Image.network(
                                          // ignore: prefer_interpolation_to_compose_strings
                                          "http://$ipConnect/mascotas/" +
                                              publicaciones[index]
                                                  ["imagen_mascota"],
                                          fit: BoxFit.cover,
                                        ),
                                      if (publicaciones[index]
                                              ["imagen_mascota_dos"] !=
                                          null)
                                        Image.network(
                                          // ignore: prefer_interpolation_to_compose_strings
                                          "http://$ipConnect/mascotas/" +
                                              publicaciones[index]
                                                  ["imagen_mascota_dos"],
                                          fit: BoxFit.cover,
                                        ),
                                      if (publicaciones[index]
                                              ["imagen_mascota_tres"] !=
                                          null)
                                        Image.network(
                                          // ignore: prefer_interpolation_to_compose_strings
                                          "http://$ipConnect/mascotas/" +
                                              publicaciones[index]
                                                  ["imagen_mascota_tres"],
                                          fit: BoxFit.cover,
                                        ),
                                    ],
                                  ),
                                ),
                                if (publicaciones[index]
                                        ["imagen_mascota_dos"] !=
                                    null)
                                  const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.arrow_left_rounded),
                                        Text(
                                          "Deslizar",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Icon(Icons.arrow_right_rounded),
                                      ]),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    publicacion["nombre_mascota_lost"],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.pets_rounded,
                                    color: Colors.orange,
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Tipo: ${publicacion["tipo_mascota_lost"]}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                      'Raza: ${publicacion["raza_mascota_lost"]}',
                                      style: const TextStyle(fontSize: 14),
                                    )
                                  ]),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Tamaño: ${publicacion["tamano_mascota_lost"]}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                      'Color: ${publicacion["color_mascota_lost"]}',
                                      style: const TextStyle(fontSize: 14),
                                    )
                                  ]),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Sexo: ${publicacion["sexo_mascota_lost"]}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                      'Recompensa: ${publicacion["recom_mascota_lost"]}',
                                      style: const TextStyle(fontSize: 14),
                                    )
                                  ]),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Descripción: ${publicacion["desc_mascota_lost"]}',
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Text("Ultima Vez Visto")],
                              ),
                              Text(
                                'Ciudad: ${publicacion["ciudad_mascota_lost"]}',
                                style: const TextStyle(fontSize: 14),
                              ),
                              Text(
                                'Barrio: ${publicacion["barrio_mascota_lost"]}',
                                style: const TextStyle(fontSize: 14),
                              ),
                              Text(
                                'Dirección: ${publicacion["direccion_mascota_lost"]}',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                mostrarDialogoConfirmacion(
                                  context: context,
                                  idMascota: publicacion['id_mascota_lost'].toString(),
                                  onDelete: (int id) async => await _controller.deletePublicacion(id),
                                  onSuccessfulDelete: (String idMascota) {
                                    setState(() {
                                      publicaciones.removeWhere((pub) => pub['id_mascota_lost'].toString() == idMascota);
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Mascota eliminada con éxito")),
                                    );
                                  },
                                );
                              },
                              child: const Text('Borrar'),
                            ),
                            const SizedBox(width: 20),
                            ElevatedButton(
                              onPressed: () {
                                context.push("/mascotaLostEdit",
                                    extra: publicaciones[index]);
                              },
                              child: const Text('Editar'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
