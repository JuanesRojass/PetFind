import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mascotas_bga/config/connect/connect_server.dart';
import 'package:mascotas_bga/controllers/delete/delete_street_pets_profile_controller.dart';
import 'package:mascotas_bga/controllers/providers/general/rol_provider.dart';
import 'package:mascotas_bga/controllers/utils/delete_message.dart';
import 'package:mascotas_bga/views/content/screens/user/profiles/adp_pets_profile.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class PetsStreetProfile extends ConsumerStatefulWidget {
  const PetsStreetProfile({super.key, required this.petsStreet});

  @override
  PetsStreetProfileState createState() => PetsStreetProfileState();
  final Map<String, dynamic> petsStreet;
}

class PetsStreetProfileState extends ConsumerState<PetsStreetProfile> {
  final DeleteStreetPetsProfileController _controller = DeleteStreetPetsProfileController();
  @override
  Widget build(BuildContext context) {
    
        double? lat;
        double? lng;

    // Verificar si la ubicación está disponible
    String? ubicacion = widget.petsStreet["ubicacion_mascota_calle"];
    if (ubicacion != null) {
      List<String> coordenadas = ubicacion.split(','); // Dividir la cadena por la coma
      lat = double.tryParse(coordenadas[0].trim()); // Intentar convertir la latitud
      lng = double.tryParse(coordenadas[1].trim()); // Intentar convertir la longitud
    }// Obtener la longitud de la segunda parte
  
    final rolUsuario = ref.watch(rolProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mascota En Calle"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.petsStreet["id_usuario_fk"] != null
                      ? Row(children: [
                          const Text(
                            "Subido Por: ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${widget.petsStreet["username"]}",
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                          )
                        ])
                      : Row(children: [
                          const Text(
                            "Subido Por: ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${widget.petsStreet["nombre_refugio"]}",
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                          ),
                          const Icon(
                            Icons.verified_user_rounded,
                            color: Colors.blue,
                          )
                        ])
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              widget.petsStreet["id_usuario_fk"] != null
                  ? Row(children: [
                      const Icon(Icons.phone, size: 20),
                      Text(
                        " ${widget.petsStreet["telefono_usuario"]}",
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ])
                  : Row(children: [
                      const Icon(Icons.phone, size: 20),
                      Text(
                        " ${widget.petsStreet["telefono_refugio"]}",
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      widget.petsStreet["telefono_refugio_dos"] != null
                          ? Text(
                              "  •${widget.petsStreet["telefono_refugio_dos"]}",
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.grey),
                            )
                          : const Text(""),
                      widget.petsStreet["telefono_refugio_tres"] != null
                          ? Text(
                              "  •${widget.petsStreet["telefono_refugio_tres"]}",
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.grey),
                            )
                          : const Text("")
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
                  if (widget.petsStreet["imagen_mascota"] != null)
                    FadeInImage.assetNetwork(
                      placeholder: 'assets/images/gifCargando.gif',
                      image: "http://$ipConnect/mascotas/${widget.petsStreet["imagen_mascota"]}",
                      fit: BoxFit.cover,
                    ),
                  if (widget.petsStreet["imagen_mascota_dos"] != null)
                    FadeInImage.assetNetwork(
                      placeholder: 'assets/images/gifCargando.gif',
                      image: "http://$ipConnect/mascotas/${widget.petsStreet["imagen_mascota_dos"]}",
                      fit: BoxFit.cover,
                    ),
                  if (widget.petsStreet["imagen_mascota_tres"] != null)
                    FadeInImage.assetNetwork(
                      placeholder: 'assets/images/gifCargando.gif',
                      image: "http://$ipConnect/mascotas/${widget.petsStreet["imagen_mascota_tres"]}",
                      fit: BoxFit.cover,
                    ),
                ],
              ),
              if (widget.petsStreet["imagen_mascota_dos"] != null)
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
                          "Tipo", widget.petsStreet["tipo_mascota_calle"])),
                  const SizedBox(width: 20),
                  Expanded(
                      child: buildSeccionInfo(
                          "Tamaño", widget.petsStreet["tamano_mascota_calle"])),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: buildSeccionInfo(
                          "Sexo", widget.petsStreet["sexo_mascota_calle"])),
                  const SizedBox(width: 20),
                  Expanded(
                      child: buildSeccionInfo(
                          "Raza", widget.petsStreet["raza_mascota_calle"])),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: buildSeccionInfo(
                          "Color", widget.petsStreet["color_mascota_calle"])),
                ],
              ),
              const Text("Última Vez Vista",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(
                "Ciudad: ${widget.petsStreet["ciudad_mascota_calle"]} • Barrio: ${widget.petsStreet["barrio_mascota_calle"]}",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              Text(
                "Dirección: ${widget.petsStreet["direccion_mascota_calle"]}",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              buildSeccionInfo(
                "Descripción",
                widget.petsStreet["desc_mascota_calle"],
              ),
              const SizedBox(height: 10,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Ubicación Mascota",  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                ]),
                const SizedBox(height: 10,),
                (lat == null || lng == null) ? 
                  const Center(child: Text("Ubicación no disponible")) :
                  SizedBox(
                    height: 300,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(lat, lng),
                        zoom: 15,
                      ),
                      markers: {
                        Marker(
                          markerId: const MarkerId('mascota_calle'),
                          position: LatLng(lat, lng),
                          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
                          infoWindow: const InfoWindow(
                            title: 'Ubicación de la mascota callejera',
                            snippet: 'Aquí se vio por última vez la mascota callejera',
                          ),
                        ),
                      },
                      onMapCreated: (GoogleMapController controller) {
                        // Configuración adicional del mapa, si es necesario
                      },
                    ),
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
                    if (widget.petsStreet['id_usuario_fk'] != null) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Contacto"),
                            content: Text(
                                "Número de teléfono: ${widget.petsStreet['telefono_usuario']}"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Cerrar"),
                              ),
                              TextButton(
                                onPressed: () async{
                                  final Uri url = Uri.parse('tel:${widget.petsStreet["telefono_usuario"]}');
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
                    } else {
                      context.push("/refugiosProfile",
                          extra: widget.petsStreet);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("Es Mi Mascota!"),
                ),
              ),
              if(rolUsuario == "Administrador")
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    mostrarDialogoConfirmacion(
                        context: context,
                        idMascota: widget.petsStreet['id_mascota_calle'].toString(),
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
