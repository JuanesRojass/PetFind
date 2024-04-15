import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 200,
                viewportFraction: 1.0,
                enableInfiniteScroll: false,
                aspectRatio: 16 / 9,
              ),
              items: [
                if (widget.petsAdp["imagen_mascota"] != null)
                  Image.network(
                    "http://192.168.1.7/mascotas/" +
                        widget.petsAdp["imagen_mascota"],
                    fit: BoxFit.cover,
                  ),
                if (widget.petsAdp["imagen_mascota_dos"] != null)
                  Image.network(
                    "http://192.168.1.7/mascotas/" +
                        widget.petsAdp["imagen_mascota_dos"],
                    fit: BoxFit.cover,
                  ),
                if (widget.petsAdp["imagen_mascota_tres"] != null)
                  Image.network(
                    "http://192.168.1.7/mascotas/" +
                        widget.petsAdp["imagen_mascota_tres"],
                    fit: BoxFit.cover,
                  ),
              ],
            ),
        const SizedBox(height: 20),
        Text(
            "Tamaño: ${widget.petsAdp["tipo_mascota_adp"] ?? "Tamaño no definido"}"),
        const SizedBox(
          height: 20,
        ),
        Text(
            "Sexo: ${widget.petsAdp["sexo_mascota_adp"] ?? "Sexo no definido"}"),
        const SizedBox(
          height: 20,
        ),
        Text(
            "Raza: ${widget.petsAdp["raza_mascota_adp"] ?? "Raza no definida"}"),
        const SizedBox(
          height: 20,
        ),
        Text(
            "Tamaño: ${widget.petsAdp["tamano_mascota_adp"] ?? "Tamaño no definido"}"),
        const SizedBox(
          height: 20,
        ),
        Text(
            "Edad: ${widget.petsAdp["edad_mascota_adp"] ?? "Edad no definida"}"),
        const SizedBox(
          height: 20,
        ),
        Text(
            "Color: ${widget.petsAdp["color_mascota_adp"] ?? "Color no definido"}"),
        const SizedBox(
          height: 20,
        ),
        Text(
            "Descripción: ${widget.petsAdp["desc_mascota_adp"] ?? "No hay descripción"}"),
      ])),
    );
  }
}
