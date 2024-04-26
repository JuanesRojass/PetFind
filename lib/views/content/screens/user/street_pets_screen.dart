import 'dart:core';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mascotas_bga/config/connect/connect_server.dart';
import 'package:mascotas_bga/controllers/gets/street_pets_controller.dart';
import 'package:mascotas_bga/controllers/infrastructure/inputs/inputs.dart';
import 'package:mascotas_bga/controllers/providers/providers.dart';


import 'package:mascotas_bga/helpers/shared.dart';

class StreetPetsScreen extends ConsumerStatefulWidget {
  const StreetPetsScreen({Key? key}) : super(key: key);

  @override
  StreetPetsScreenState createState() => StreetPetsScreenState();
}

class StreetPetsScreenState extends ConsumerState<StreetPetsScreen> {
  final StreetPetsController _controller = StreetPetsController();
  final TextEditingController tipo = TextEditingController();
  final TextEditingController raza = TextEditingController();
  final TextEditingController sexo = TextEditingController();
  final TextEditingController tamano = TextEditingController();
  final TextEditingController ciudad = TextEditingController();
  List<Map<String, dynamic>> mascotasstreet = [];

  @override
  void initState() {
    getMascotasStreet();
    super.initState();
  }

  Future<void> getMascotasStreet() async {
    final mascotasStreet = await _controller.getMascotasStreet();
    setState(() {
      mascotasstreet = mascotasStreet;
    });
  }

  @override
  Widget build(BuildContext context) {
    final rolActual = ref.watch(rolProvider);
    final scaffoldKey = GlobalKey<ScaffoldState>();

          Widget? drawerForRole;
  switch (rolActual) {
    case 'Cliente':
      drawerForRole = SideMenu(scaffoldKey: scaffoldKey);
      break;
    case 'Refugio':
      drawerForRole = SideMenuRefugio(scaffoldKey: scaffoldKey);
      break;
    case 'Invitado':
      drawerForRole = SideInvitadoMenu(scaffoldKey: scaffoldKey);
      break;
  }


    return Scaffold(
        appBar: AppBar(
          title: const Text('Mascotas En Calle'),
          actions: [
            IconButton(
                onPressed: () {
                  ref.read(idTipoMascotaProvider.notifier).setId("");
                  ref.read(idCiudadProvider.notifier).setId("");
                  showDialog(
                      context: context,
                      builder: ((context) => AlertDialog(
                            title: const Text("Busqueda Por Filtros"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                DropdownTipo(controller: tipo),
                                DropdownRazas(controller: raza),
                                DropDownMenuSexo(controller: sexo),
                                DropDownMenuTamano(controller: tamano),
                                DropdownCiudades(controller: ciudad)
                              ],
                            ),
                            actions: [
                              TextButton.icon(
                                  onPressed: () async {
                                    String? tipoValue =
                                        tipo.text.isNotEmpty ? tipo.text : null;
                                    String? razaValue =
                                        raza.text.isNotEmpty ? raza.text : null;
                                    String? sexoValue =
                                        sexo.text.isNotEmpty ? sexo.text : null;
                                    String? tamanoValue = tamano.text.isNotEmpty
                                        ? tamano.text
                                        : null;
                                    String? ciudadValue =
                                        ciudad.text.isNotEmpty ? ciudad.text : null;

                                    final mascotasFiltradas =
                                        await _controller.getMascotasStreet(
                                      tipo: ref.watch(nombreTipoProvider),
                                      raza: ref.watch(nombreRazaProvider),
                                      // raza: razaValue,
                                      sexo: sexoValue,
                                      tamano: tamanoValue,
                                      ciudad: ref.watch(idCiudadProvider),
                                    );

                                    setState(() {
                                      mascotasstreet = mascotasFiltradas;
                                    });
                                    raza.clear();
                                    sexo.clear();
                                    tamano.clear();
                                    ref.read(nombreTipoProvider.notifier).setName("");
                                    ref.read(nombreRazaProvider.notifier).setName("");
                                    ref.read(idTipoMascotaProvider.notifier).setId("");
                                    ref.read(idCiudadProvider.notifier).setId("");
                                    context.pop();
                                  },
                                  label: const Text("Filtrar"),
                                  icon: const Icon(Icons.search_rounded))
                            ],
                          )
                        )
                      );
                },
                icon: const Icon(Icons.search_rounded,
                    color: Colors.orange, size: 30))
          ],
        ),
        drawer: drawerForRole,
        body: mascotasstreet.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: mascotasstreet.length,
                itemBuilder: (context, index) {
                  final pet = mascotasstreet[index];
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: InkWell(
                        onTap: () {
                          if (pet['id_usuario_fk'] != null) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Contacto"),
                                  content: Text(
                                    "Número de teléfono: ${pet['telefono_usuario']}"
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Cerrar"),
                                    ),
                                    TextButton(
                                      onPressed: () async{
                                        final Uri url = Uri.parse('tel:${pet["telefono_usuario"]}');
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
                            context.push("/refugiosProfile", extra: pet);
                          }
                        },
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              child: pet["id_usuario_fk"] != null
                                ? const Icon(Icons.person_2_rounded, size: 30)
                                : const Icon(Icons.house_rounded, size: 30)
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  pet["id_usuario_fk"] != null
                                    ? Text(
                                      pet['username'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    )
                                    : Row(
                                      children: [Text(
                                        pet['nombre_refugio'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const Icon(Icons.verified_user_rounded, color: Colors.blue, size: 20,)
                                ]),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.phone,
                                              size: 10,
                                            ),
                                            Text(
                                              pet['id_usuario_fk'] != null
                                                ? ' ${pet['telefono_usuario']}'
                                                : ' ${pet['telefono_refugio']}',
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Expanded(
                                        flex: 2,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            // Aquí puedes añadir el botón de llamar
                                          ],
                                        ),
                                        
                                      ),
                                      
                                    ],
                                    
                                  ),
                                  Row(
                                    children: [
                                    const Text("Visto en: "),
                                    Flexible(
                                      child: Text(
                                        ' ${pet['ciudad_mascota_calle']} • ${pet['barrio_mascota_calle']} • ${pet['direccion_mascota_calle']}',
                                        style: const TextStyle(fontSize: 12),
                                                                        ),
                                    )])
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: InkWell(
                        onTap: () {
                          context.push("/petsStreetProfile", extra: pet);
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(9.0),
                                child: FadeInImage.assetNetwork(
                                  placeholder: 'assets/images/gifCargando.gif',
                                  image: "http://$ipConnect/mascotas/${pet["imagen_mascota"]}",
                                  width: 120,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Encontrada En Calle",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.pets,
                                          size: 25,
                                        ),
                                        Text(
                                          "${pet['tipo_mascota_calle']}",
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      'Raza: ${pet['raza_mascota_calle']}',
                                    ),
                                    Text(
                                      'Sexo: ${pet['sexo_mascota_calle']}',
                                    ),
                                    Text(
                                      'Tamaño: ${pet['tamano_mascota_calle']}',
                                    ),
                                    Text(
                                      'Color: ${pet['color_mascota_calle']}',
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        context.push("/petsStreetProfile", extra: pet);
                                      },
                                      child: const Text("Mas información >"),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
                    );
                },
              ),
        floatingActionButton: rolActual == "Cliente" || rolActual == "Refugio"
            ? FloatingActionButton(
                onPressed: () {
                  context.push("/uploadStreetPets");
                },
                child: const Icon(Icons.add),
              )
            : null,
        bottomNavigationBar: const BottomNavigationUser());
  }
}
