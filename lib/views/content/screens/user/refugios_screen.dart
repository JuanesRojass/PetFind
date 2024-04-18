import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mascotas_bga/controllers/gets/refugios_controller.dart';

import 'package:mascotas_bga/controllers/providers/general/rol_provider.dart';

import 'package:mascotas_bga/helpers/shared.dart';

class RefugiosScreen extends ConsumerStatefulWidget {
  const RefugiosScreen({Key? key}) : super(key: key);

  @override
  RefugiosScreenState createState() => RefugiosScreenState();
}

class RefugiosScreenState extends ConsumerState<RefugiosScreen> {
  final RefugiosController _controller = RefugiosController();
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Refugios'),
      ),
      body: refugios.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: refugios.length,
              itemBuilder: (context, index) {
                final refugio = refugios[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: InkWell(
                    onTap: (){
                      context.push('/refugiosProfile', extra: refugio);
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.home, size: 100),
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
