import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:mascotas_bga/config/connect/connect_server.dart';
import 'package:mascotas_bga/views/content/screens/user/profiles/adp_pets_profile.dart';

class PetsLostProfile extends StatefulWidget {
  const PetsLostProfile({super.key, required this.petsLost});

  @override
  State<PetsLostProfile> createState() => _PetsLostProfileState();
  final Map<String, dynamic> petsLost;
}

class _PetsLostProfileState extends State<PetsLostProfile> {
  @override
  Widget build(BuildContext context) {
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Nombre Dueño: ${widget.petsLost["username"]}"),
                      Text("Recompensa: ${widget.petsLost["recom_mascota_lost"]}")
                    ],
                  ),
                  Text("Telefono: ${widget.petsLost["telefono_usuario"]}"),
              CarouselSlider(
                options: CarouselOptions(
                  height: 300,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: false,
                  aspectRatio: 16 / 9,
                ),
                items: [
                  if (widget.petsLost["imagen_mascota"] != null)
                    Image.network(
                      // ignore: prefer_interpolation_to_compose_strings
                      "http://$ipConnect/mascotas/" +
                          widget.petsLost["imagen_mascota"],
                      fit: BoxFit.cover,
                    ),
                  if (widget.petsLost["imagen_mascota_dos"] != null)
                    Image.network(
                      // ignore: prefer_interpolation_to_compose_strings
                      "http://$ipConnect/mascotas/" +
                          widget.petsLost["imagen_mascota_dos"],
                      fit: BoxFit.cover,
                    ),
                  if (widget.petsLost["imagen_mascota_tres"] != null)
                    Image.network(
                      // ignore: prefer_interpolation_to_compose_strings
                      "http://$ipConnect/mascotas/" +
                          widget.petsLost["imagen_mascota_tres"],
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
                    Text("Deslizar",style: TextStyle(fontWeight: FontWeight.bold),),
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
                          "Tipo", widget.petsLost["tipo_mascota_adp"])),
                  const SizedBox(width: 20),
                  Expanded(
                      child: buildSeccionInfo(
                          "Tamaño", widget.petsLost["tamano_mascota_adp"])),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: buildSeccionInfo(
                          "Sexo", widget.petsLost["sexo_mascota_adp"])),
                  const SizedBox(width: 20),
                  Expanded(
                      child: buildSeccionInfo(
                          "Raza", widget.petsLost["raza_mascota_adp"])),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: buildSeccionInfo(
                          "Edad", widget.petsLost["edad_mascota_adp"])),
                  const SizedBox(width: 20),
                  Expanded(
                      child: buildSeccionInfo(
                          "Color", widget.petsLost["color_mascota_adp"])),
                ],
              ),
              buildSeccionInfo(
                  "Descripción", widget.petsLost["desc_mascota_adp"]),
              buildSeccionInfo("Salud", widget.petsLost["salud_mascota_adp"]),
              const SizedBox(height: 40),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    context.push("/refugiosProfile", extra: widget.petsLost);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("ADOPTAR"),
                ),
              )
            ]),
          )),
    );
  }
}


