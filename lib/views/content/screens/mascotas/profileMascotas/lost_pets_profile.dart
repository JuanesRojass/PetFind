import 'dart:core';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mascotas_bga/config/connect/connect_server.dart';
import 'package:mascotas_bga/controllers/delete/delete_lost_pets_profile_controller.dart';
import 'package:mascotas_bga/controllers/providers/general/rol_provider.dart';
import 'package:mascotas_bga/controllers/utils/delete_message.dart';
import 'package:mascotas_bga/views/content/screens/mascotas/profileMascotas/adp_pets_profile.dart';

class PetsLostProfile extends ConsumerStatefulWidget {
  const PetsLostProfile({super.key, required this.petsLost});

  @override
  PetsLostProfileState createState() => PetsLostProfileState();
  final Map<String, dynamic> petsLost;
}

class PetsLostProfileState extends ConsumerState<PetsLostProfile> {
  final DeleteLostPetsProfileController _controller = DeleteLostPetsProfileController();

  @override
  Widget build(BuildContext context) {
    final rolUsuario = ref.watch(rolProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.petsLost["nombre_mascota_lost"] ?? "Mascota"}'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Row(children: [
                    const Text(
                      "Nombre Dueño:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      " ${widget.petsLost["username"]}",
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ]),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(children: [
                const Icon(Icons.phone),
                Text(" ${widget.petsLost["telefono_usuario"]}",
                    style: const TextStyle(fontSize: 16, color: Colors.grey))
              ]),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text("Recompensa:",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(" ${widget.petsLost["recom_mascota_lost"]}",
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.bold)),
              ]),
              const SizedBox(
                height: 20,
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 300,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: false,
                  aspectRatio: 16 / 9,
                ),
                items: [
                  if (widget.petsLost["imagen_mascota"] != null)
                    FadeInImage.assetNetwork(
                      placeholder: 'assets/images/gifCargando.gif',
                      image: "http://$ipConnect/mascotas/${widget.petsLost["imagen_mascota"]}",
                      fit: BoxFit.cover,
                    ),
                  if (widget.petsLost["imagen_mascota_dos"] != null)
                    FadeInImage.assetNetwork(
                      placeholder: 'assets/images/gifCargando.gif',
                      image: "http://$ipConnect/mascotas/${widget.petsLost["imagen_mascota_dos"]}",
                      fit: BoxFit.cover,
                    ),
                  if (widget.petsLost["imagen_mascota_tres"] != null)
                    FadeInImage.assetNetwork(
                      placeholder: 'assets/images/gifCargando.gif',
                      image: "http://$ipConnect/mascotas/${widget.petsLost["imagen_mascota_tres"]}",
                      fit: BoxFit.cover,
                    ),
                ],
              ),
              if (widget.petsLost["imagen_mascota_dos"] != null)
                const Column(
                  children: [
                    SizedBox(height: 10),
                    Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_left_rounded),
                            Text(
                              "Deslizar",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.arrow_right_rounded),
                          ]),
                    ),
                  ],
                ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: buildSeccionInfo(
                          "Tipo", widget.petsLost["tipo_mascota_lost"])),
                  const SizedBox(width: 20),
                  Expanded(
                      child: buildSeccionInfo(
                          "Tamaño", widget.petsLost["tamano_mascota_lost"])),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: buildSeccionInfo(
                          "Sexo", widget.petsLost["sexo_mascota_lost"])),
                  const SizedBox(width: 20),
                  Expanded(
                      child: buildSeccionInfo(
                          "Raza", widget.petsLost["raza_mascota_lost"])),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: buildSeccionInfo(
                          "Color", widget.petsLost["color_mascota_lost"])),
                ],
              ),
              const Text("Última Vez Vista",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(
                "Ciudad: ${widget.petsLost["ciudad_mascota_lost"]} • Barrio: ${widget.petsLost["barrio_mascota_lost"]}",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              Text(
                "Dirección: ${widget.petsLost["direccion_mascota_lost"]}",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              buildSeccionInfo(
                "Descripción",
                widget.petsLost["desc_mascota_lost"],
              ),
              const SizedBox(height: 40),
              const SizedBox(
                height: 10,
              ),
              if(rolUsuario == "Cliente" || rolUsuario == "Refugio" || rolUsuario == "Invitado")
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Contacto"),
                          content: Text(
                              "Número de teléfono: ${widget.petsLost['telefono_usuario']}"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Cerrar"),
                            ),
                            TextButton(
                              onPressed: () async{
                                final Uri url = Uri.parse('tel:${widget.petsLost["telefono_usuario"]}');
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(url);
                                  } else {
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("No se pudo realizar la llamada")),
                                  );
                                }
                              },
                              child: const Text("Llamar"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("LO ENCONTRÉ"),
                ),
              ),
              if(rolUsuario == "Administrador")
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                     mostrarDialogoConfirmacion(
                        context: context,
                        idMascota: widget.petsLost['id_mascota_lost'].toString(),
                        onDelete: (int id) async =>
                            await _controller.deletePublicacion(id),
                        onSuccessfulDelete: (String idMascota) {
                          setState(() {});
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Mascota eliminada con éxito")),
                          );
                        },
                      );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("ELIMINAR PUBLICACIÓN"),
                ),
              ),
            ]),
          )),
    );
  }
}
