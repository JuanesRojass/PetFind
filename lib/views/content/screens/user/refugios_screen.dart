import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mascotas_bga/controllers/gets/refugios_controller.dart';
import 'package:mascotas_bga/controllers/infrastructure/inputs/inputs.dart';
import 'package:mascotas_bga/controllers/providers/providers.dart';
import 'package:mascotas_bga/controllers/providers/general/rol_provider.dart';

import 'package:mascotas_bga/helpers/shared.dart';

class RefugiosScreen extends ConsumerStatefulWidget {
  const RefugiosScreen({Key? key}) : super(key: key);

  @override
  RefugiosScreenState createState() => RefugiosScreenState();
}

class RefugiosScreenState extends ConsumerState<RefugiosScreen> {
  final RefugiosController _controller = RefugiosController();
  final TextEditingController ciudad = TextEditingController();
  List<Map<String, dynamic>> refugios = [];

  @override
  void initState() {
    getRefugios();
    super.initState();
  }

  Future<void> getRefugios() async {
    final refugioss = await _controller.getRefugios();
    setState(() {
      refugios = refugioss;
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
        title: const Text('Refugios'),
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
                                DropdownCiudades(controller: ciudad)
                              ],
                            ),
                            actions: [
                              TextButton.icon(
                                  onPressed: () async {
                                    String? ciudadValue =
                                        ciudad.text.isNotEmpty ? ciudad.text : null;

                                    final mascotasFiltradas =
                                        await _controller.getRefugios(
                                      ciudad: ref.watch(idCiudadProvider),
                                    );

                                    setState(() {
                                      refugios = mascotasFiltradas;
                                    });
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
      body: refugios.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: refugios.length,
              itemBuilder: (context, index) {
                final refugio = refugios[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: (){
                      context.push('/refugiosProfile', extra: refugio);
                    },
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.home_outlined, size: 100, color: Color.fromARGB(204, 173, 55, 194)),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Text(
                                  refugio["nombre_refugio"],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const Icon(
                                  Icons.verified_user_rounded,
                                  color: Colors.blue,
                                )
                              ]),
                              Text(
                                'Ciudad: ${refugio["ciudad_refugio"]}',
                                style: const TextStyle(fontSize: 14),
                              ),
                              Text(
                                'Barrio: ${refugio["barrio_refugio"]}',
                                style: const TextStyle(fontSize: 14),
                              ),
                              Text(
                                'Dirección: ${refugio["direccion_refugio"]}',
                                style: const TextStyle(fontSize: 14),
                              ),
                              TextButton.icon(
                                  onPressed: () {
                                    context.push('/refugiosProfile', extra: refugio);
                                  },
                                  icon: const Icon(Icons.arrow_right_rounded),
                                  label: const Text("Mas información"))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: const BottomNavigationUser(),
    );
  }
}
