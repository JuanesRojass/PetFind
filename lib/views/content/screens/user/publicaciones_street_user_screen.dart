import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mascotas_bga/config/connect/connect_server.dart';
import 'package:mascotas_bga/controllers/providers/providers.dart';
import 'package:mascotas_bga/controllers/userEdit/publicaciones_street_user_controller.dart';
import 'package:mascotas_bga/controllers/utils/delete_message.dart';

import '../../../../helpers/shared.dart';

class PublicacionesStreetUserScreen extends ConsumerStatefulWidget {
  const PublicacionesStreetUserScreen({Key? key}) : super(key: key);

  @override
  PublicacionesStreetUserScreenState createState() => PublicacionesStreetUserScreenState();
}

class PublicacionesStreetUserScreenState
    extends ConsumerState<PublicacionesStreetUserScreen> {
  final PublicacionesStreetUserController _controller = PublicacionesStreetUserController();
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
                  child: InkWell(
                    onTap: () {
                      context.push('/mascotasLostProfile', extra: publicaciones);
                    },
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
                                      if (publicaciones[index]["imagen_mascota"] != null)
                                        Image.network(
                                          // ignore: prefer_interpolation_to_compose_strings
                                          "http://$ipConnect/mascotas/" +
                                              publicaciones[index]["imagen_mascota"],
                                          fit: BoxFit.cover,
                                        ),
                                      if (publicaciones[index]["imagen_mascota_dos"] != null)
                                        Image.network(
                                          // ignore: prefer_interpolation_to_compose_strings
                                          "http://$ipConnect/mascotas/" +
                                              publicaciones[index]["imagen_mascota_dos"],
                                          fit: BoxFit.cover,
                                        ),
                                      if (publicaciones[index]["imagen_mascota_tres"] != null)
                                        Image.network(
                                          // ignore: prefer_interpolation_to_compose_strings
                                          "http://$ipConnect/mascotas/" +
                                              publicaciones[index]["imagen_mascota_tres"],
                                          fit: BoxFit.cover,
                                        ),
                                    ],
                                  ),
                                ),
                                if (publicaciones[index]["imagen_mascota_dos"] != null)
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                        Icon(Icons.arrow_left_rounded),
                                        Text("Deslizar",style: TextStyle(fontWeight: FontWeight.bold),),
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
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Mascota En Calle",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Icon(
                                    Icons.pets_rounded,
                                    color: Colors.orange,
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround, 
                              children: [
                              Row(
                                children: [
                                  const Text('Tipo:',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text(" ${publicacion["tipo_mascota_calle"]}",
                                style: const TextStyle(fontSize: 16, color: Colors.grey))
                              ]),
                              Row(
                                children: [
                                  const Text('Raza:',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text(" ${publicacion["raza_mascota_calle"]}",
                                style: const TextStyle(fontSize: 16, color: Colors.grey))
                            ])]),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                              Row(
                                children: [
                                  const Text('Tamaño:',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text(" ${publicacion["tamano_mascota_calle"]}",
                                style: const TextStyle(fontSize: 16, color: Colors.grey))
                                ]),
                              Row(
                                children: [
                                  const Text('Color:',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text(" ${publicacion["color_mascota_calle"]}",
                                style: const TextStyle(fontSize: 16, color: Colors.grey))
                            ])]),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                              Row(
                                children: [
                                  const Text('Sexo:',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text(" ${publicacion["sexo_mascota_calle"]}",
                                style: const TextStyle(fontSize: 16, color: Colors.grey))
                                ]),
                              ]),
                              const SizedBox(height: 10,),
                              Column(
                                children: [
                                  const Text('Descripción',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                Text(" ${publicacion["desc_mascota_calle"]}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 16, color: Colors.grey))
                            ]),
                              const SizedBox(height: 10,),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Mascota Vista En",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          )],),
                              const SizedBox(height: 10,),
                              Row(
                                children: [
                                  const Text('Ciudad:',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text(" ${publicacion["ciudad_mascota_calle"]}",
                                style: const TextStyle(fontSize: 16, color: Colors.grey))
                            ]),
                              Row(
                                children: [
                                  const Text('Barrio:',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text(" ${publicacion["barrio_mascota_calle"]}",
                                style: const TextStyle(fontSize: 16, color: Colors.grey))
                            ]),
                              Row(
                                children: [
                                  const Text( 'Dirección:',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                Text(" ${publicacion["direccion_mascota_calle"]}",
                                style: const TextStyle(fontSize: 16, color: Colors.grey))
                            ]),
                              
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
                                  idMascota: publicacion['id_mascota_calle'].toString(),
                                  onDelete: (int id) async => await _controller.deletePublicacion(id),
                                  onSuccessfulDelete: (String idMascota) {
                                    setState(() {
                                      publicaciones.removeWhere((pub) => pub['id_mascota_calle'].toString() == idMascota);
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
                                context.push("/mascotaStreetEdit", extra: publicaciones[index]);
                              },
                              child: const Text('Editar'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                );
              },
            ),
    ),
  );
}
}
