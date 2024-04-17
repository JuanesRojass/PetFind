import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
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
                    children: [
                      Row(children: [
                        const Text("Nombre Dueño:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        Text(" ${widget.petsLost["username"]}", style: const TextStyle(fontSize: 16, color: Colors.grey),),
                        ]),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(children: [
                    const Icon(Icons.phone),
                    Text(" ${widget.petsLost["telefono_usuario"]}", style: const TextStyle(fontSize: 16, color: Colors.grey))
                    ]),
                    const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        const Text("Recompensa:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text(" ${widget.petsLost["recom_mascota_lost"]}", style: const TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold)),
                      ]),
                  const SizedBox(height: 20,),
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
               const Text("Última Vez Vista", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
               Text("Ciudad: ${widget.petsLost["ciudad_mascota_lost"]} • Barrio: ${widget.petsLost["barrio_mascota_lost"]}",
               style: const TextStyle(fontSize: 16, color: Colors.grey),),
               Text("Dirección: ${widget.petsLost["direccion_mascota_lost"]}",
               style: const TextStyle(fontSize: 16, color: Colors.grey),),
               const SizedBox(height: 20),
              buildSeccionInfo(
                  "Descripción", widget.petsLost["desc_mascota_lost"],),
              const SizedBox(height: 40),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                   showDialog(
                    context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Contacto"),
                          content: Text("Número de teléfono: ${widget.petsLost['telefono_usuario']}"),
                          actions: [
                            TextButton(
                              onPressed: () {
                              Navigator.of(context).pop(); 
                                },
                                child: const Text("Cerrar"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(text: widget.petsLost['telefono_usuario'])); // Copiar el texto al portapapeles
                                    Navigator.of(context).pop(); 
                                    ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Teléfono copiado al portapapeles")),
                              );
                                  },
                                  child: const Text("Copiar"),
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
              )
            ]),
          )),
    );
  }
}


