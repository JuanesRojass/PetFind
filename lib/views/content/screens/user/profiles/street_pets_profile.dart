import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:mascotas_bga/config/connect/connect_server.dart';
import 'package:mascotas_bga/views/content/screens/user/profiles/adp_pets_profile.dart';

class PetsStreetProfile extends StatefulWidget {
  const PetsStreetProfile({super.key, required this.petsStreet});

  @override
  State<PetsStreetProfile> createState() => _PetsStreetProfileState();
  final Map<String, dynamic> petsStreet;
}

class _PetsStreetProfileState extends State<PetsStreetProfile> {
  @override
  Widget build(BuildContext context) {
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
                        const Text("Subido Por: ",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        Text("${widget.petsStreet["username"]}", style: const TextStyle(fontSize: 16, color: Colors.grey),)
                        ])
                      : Row(children: [
                          const Text("Subido Por: ",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                          Text(
                              "${widget.petsStreet["nombre_refugio"]}",style: const TextStyle(fontSize: 16, color: Colors.grey),),
                          const Icon(
                            Icons.verified_user_rounded,
                            color: Colors.blue,
                          )
                        ])
                ],
              ),
              const SizedBox(height: 10,),
              widget.petsStreet["id_usuario_fk"] != null
                  ? Row(children: [
                      const Icon(Icons.phone, size: 20),
                      Text(" ${widget.petsStreet["telefono_usuario"]}", style: const TextStyle(fontSize: 16, color: Colors.grey),),
                    ])
                  : Row(children: [
                      const Icon(Icons.phone, size: 20),
                      Text(" ${widget.petsStreet["telefono_refugio"]}",style: const TextStyle(fontSize: 16, color: Colors.grey),),
                      widget.petsStreet["telefono_refugio_dos"] != null
                          ? Text(
                              "  •${widget.petsStreet["telefono_refugio_dos"]}",style: const TextStyle(fontSize: 16, color: Colors.grey),)
                          : const Text(""),
                      widget.petsStreet["telefono_refugio_tres"] != null
                          ? Text(
                              "  •${widget.petsStreet["telefono_refugio_tres"]}", style: const TextStyle(fontSize: 16, color: Colors.grey),)
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
                    Image.network(
                      // ignore: prefer_interpolation_to_compose_strings
                      "http://$ipConnect/mascotas/" +
                          widget.petsStreet["imagen_mascota"],
                      fit: BoxFit.cover,
                    ),
                  if (widget.petsStreet["imagen_mascota_dos"] != null)
                    Image.network(
                      // ignore: prefer_interpolation_to_compose_strings
                      "http://$ipConnect/mascotas/" +
                          widget.petsStreet["imagen_mascota_dos"],
                      fit: BoxFit.cover,
                    ),
                  if (widget.petsStreet["imagen_mascota_tres"] != null)
                    Image.network(
                      // ignore: prefer_interpolation_to_compose_strings
                      "http://$ipConnect/mascotas/" +
                          widget.petsStreet["imagen_mascota_tres"],
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
              const SizedBox(height: 40),
              const SizedBox(
                height: 10,
              ),
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
                                  Navigator.of(context)
                                      .pop(); 
                                },
                                child: const Text("Cerrar"),
                              ),
                              TextButton(
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(
                                      text: widget.petsStreet[
                                          'telefono_usuario']));
                                          ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Teléfono copiado al portapapeles")),
                              ); 
                                  Navigator.of(context)
                                      .pop(); 
                                },
                                child: const Text("Copiar"),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      context.push("/refugiosProfile", extra: widget.petsStreet);
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
              )
            ]),
          )),
    );
  }
}
