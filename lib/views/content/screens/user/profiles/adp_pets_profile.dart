import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:mascotas_bga/config/connect/connect_server.dart';

class PetsAdoptProfile extends StatefulWidget {
  const PetsAdoptProfile({super.key, required this.petsAdp});

  @override
  State<PetsAdoptProfile> createState() => _PetsAdoptProfileState();
  final Map<String, dynamic> petsAdp;
}

class _PetsAdoptProfileState extends State<PetsAdoptProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.petsAdp["nombre_mascota_adp"] ?? "Mascota"}'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 300,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: false,
                  aspectRatio: 16 / 9,
                ),
                items: [
                  if (widget.petsAdp["imagen_mascota"] != null)
                    Image.network(
                      // ignore: prefer_interpolation_to_compose_strings
                      "http://$ipConnect/mascotas/" +
                          widget.petsAdp["imagen_mascota"],
                      fit: BoxFit.cover,
                    ),
                  if (widget.petsAdp["imagen_mascota_dos"] != null)
                    Image.network(
                      // ignore: prefer_interpolation_to_compose_strings
                      "http://$ipConnect/mascotas/" +
                          widget.petsAdp["imagen_mascota_dos"],
                      fit: BoxFit.cover,
                    ),
                  if (widget.petsAdp["imagen_mascota_tres"] != null)
                    Image.network(
                      // ignore: prefer_interpolation_to_compose_strings
                      "http://$ipConnect/mascotas/" +
                          widget.petsAdp["imagen_mascota_tres"],
                      fit: BoxFit.cover,
                    ),
                ],
              ),
              
               if (widget.petsAdp["imagen_mascota_dos"] != null)
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
                          "Tipo", widget.petsAdp["tipo_mascota_adp"])),
                  const SizedBox(width: 20),
                  Expanded(
                      child: buildSeccionInfo(
                          "Tamaño", widget.petsAdp["tamano_mascota_adp"])),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: buildSeccionInfo(
                          "Sexo", widget.petsAdp["sexo_mascota_adp"])),
                  const SizedBox(width: 20),
                  Expanded(
                      child: buildSeccionInfo(
                          "Raza", widget.petsAdp["raza_mascota_adp"])),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: buildSeccionInfo(
                          "Edad", widget.petsAdp["edad_mascota_adp"])),
                  const SizedBox(width: 20),
                  Expanded(
                      child: buildSeccionInfo(
                          "Color", widget.petsAdp["color_mascota_adp"])),
                ],
              ),
              buildSeccionInfo(
                  "Descripción", widget.petsAdp["desc_mascota_adp"]),
              buildSeccionInfo("Salud", widget.petsAdp["salud_mascota_adp"]),
              const SizedBox(height: 40),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    context.push("/refugiosProfile", extra: widget.petsAdp);
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

Widget buildSeccionInfo(String title, String? value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      Text(
        value ?? "Información no disponible",
        style: const TextStyle(fontSize: 16, color: Colors.grey),
      ),
      const SizedBox(height: 20),
    ],
  );
}
