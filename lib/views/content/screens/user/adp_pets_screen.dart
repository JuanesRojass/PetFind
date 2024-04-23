import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mascotas_bga/config/connect/connect_server.dart';
import 'package:mascotas_bga/controllers/infrastructure/inputs/inputs.dart';
import 'package:mascotas_bga/controllers/gets/adp_pets_controller.dart';
import 'package:mascotas_bga/controllers/providers/providers.dart';

import 'package:mascotas_bga/helpers/shared.dart';

class AdpPetsScreen extends ConsumerStatefulWidget {
  const AdpPetsScreen({Key? key}) : super(key: key);

  @override
  AdpPetsScreenState createState() => AdpPetsScreenState();
}

class AdpPetsScreenState extends ConsumerState<AdpPetsScreen> {
  final AdpPetsController _controller = AdpPetsController();
  final TextEditingController tipo = TextEditingController();
  final TextEditingController raza = TextEditingController();
  final TextEditingController sexo = TextEditingController();
  final TextEditingController tamano = TextEditingController();
  final TextEditingController edad = TextEditingController();
  final TextEditingController ciudad = TextEditingController();
  List<Map<String, dynamic>> mascotasadp = [];



  @override
  void initState() {
    getMascotasAdp();
    super.initState();
  }

  Future<void> getMascotasAdp() async {
    final mascotasAdp = await _controller.getMascotasAdp();
    setState(() {
      mascotasadp = mascotasAdp;
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
          title: const Text('Mascotas En Adopción', style: TextStyle(fontSize: 20)),
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
                                DropDownMenuEdad(controller: edad),
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
                                    String? edadValue =
                                        edad.text.isNotEmpty ? edad.text : null;
                                    String? ciudadValue = ciudad.text.isNotEmpty
                                        ? ciudad.text
                                        : null;

                                    final mascotasFiltradas =
                                        await _controller.getMascotasAdp(
                                      tipo: ref.watch(nombreTipoProvider),
                                      raza: ref.watch(nombreRazaProvider),
                                      // raza: razaValue,
                                      sexo: sexoValue,
                                      tamano: tamanoValue,
                                      edad: edadValue,
                                      ciudad: ref.watch(idCiudadProvider),
                                    );

                                    setState(() {
                                      mascotasadp = mascotasFiltradas;
                                    });
                                    raza.clear();
                                    sexo.clear();
                                    tamano.clear();
                                    edad.clear();
                                    ref
                                        .read(nombreTipoProvider.notifier)
                                        .setName("");
                                    ref
                                        .read(nombreRazaProvider.notifier)
                                        .setName("");
                                    ref
                                        .read(idTipoMascotaProvider.notifier)
                                        .setId("");
                                    ref
                                        .read(idCiudadProvider.notifier)
                                        .setId("");
                                    context.pop();
                                  },
                                  label: const Text("Filtrar"),
                                  icon: const Icon(Icons.search_rounded))
                            ],
                          )));
                },
                icon: const Icon(Icons.search_rounded,
                    color: Colors.orange, size: 30))
          ],
        ),
        drawer: drawerForRole,
        body: mascotasadp.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: mascotasadp.length,
                itemBuilder: (context, index) {
                  final pet = mascotasadp[index];
                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(7.0),
                                      child: InkWell(
                                        onTap: () {
                                          context.push("/refugiosProfile",
                                              extra: pet);
                                        },
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              child: const Icon(Icons.house,
                                                  size: 30),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(children: [
                                                    Text(
                                                      pet['nombre_refugio'],
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    ),
                                                    const Icon(
                                                      Icons
                                                          .verified_user_rounded,
                                                      color: Colors.blue,
                                                      size: 20,
                                                    )
                                                  ]),
                                                  Row(children: [
                                                    const Icon(
                                                      Icons.location_on_rounded,
                                                      size: 10,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        ' ${pet['ciudad_refugio']} • ${pet['barrio_refugio']} • ${pet['direccion_refugio']}',
                                                        style: const TextStyle(
                                                            fontSize: 12),
                                                        // overflow: TextOverflow.ellipsis,
                                                      ),
                                                    )
                                                  ]),
                                                  Row(children: [
                                                    const Icon(
                                                      Icons.phone,
                                                      size: 10,
                                                    ),
                                                    Text(
                                                      ' ${pet['telefono_refugio']}',
                                                      style: const TextStyle(
                                                          fontSize: 12),
                                                    )
                                                  ])
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: InkWell(
                                        onTap: () {
                                          context.push("/petsAdpProfile",
                                              extra: pet);
                                        },
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(9.0),
                                                child: Image.network(
                                                  // ignore: prefer_interpolation_to_compose_strings
                                                  "http://$ipConnect/mascotas/" +
                                                      pet["imagen_mascota"],
                                                  width: 120,
                                                  height: 200,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      pet['nombre_mascota_adp'],
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const Icon(
                                                            Icons.pets,
                                                            size: 15,
                                                          ),
                                                          Text(
                                                              "${pet['tipo_mascota_adp']}"),
                                                        ]),
                                                    const SizedBox(height: 15),
                                                    Text(
                                                        'Raza: ${pet['raza_mascota_adp']}'),
                                                    Text(
                                                        'Sexo: ${pet['sexo_mascota_adp']}'),
                                                    Text(
                                                        'Tamaño: ${pet['tamano_mascota_adp']}'),
                                                    Text(
                                                        'Edad: ${pet['edad_mascota_adp']}'),
                                                    Text(
                                                        'Color: ${pet['color_mascota_adp']}'),
                                                    TextButton(
                                                        onPressed: () {
                                                          context.push(
                                                              "/petsAdpProfile",
                                                              extra: pet);
                                                        },
                                                        child: const Text(
                                                            "Mas información >"))
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
                            )
                          ])));
                },
              ),
        floatingActionButton: rolActual == "Refugio"
            ? FloatingActionButton(
                onPressed: () {
                  context.push("/uploadAdpPets", extra: mascotasadp);
                },
                child: const Icon(Icons.add),
              )
            : null,
        bottomNavigationBar: const BottomNavigationUser());
  }
}
