import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mascotas_bga/controllers/gets/refugios_controller.dart';
import 'package:mascotas_bga/helpers/shared.dart';
import 'package:mascotas_bga/controllers/providers/general/id_refugio_info.dart';

class RefugiosScreen extends ConsumerStatefulWidget {
  const RefugiosScreen({super.key});

  @override
  RefugiosScreenState createState() => RefugiosScreenState();
}

class RefugiosScreenState extends ConsumerState<RefugiosScreen> {
  final RefugiosController _controller = RefugiosController();

  List refugios = [];

  @override
  void initState() {
    getRefugios();
    super.initState();
  }

  Future<void> getRefugios() async {
    final refugiosL = await _controller.getRefugios();
    setState(() {
      refugios = refugiosL;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Refugios'),
        ),
        body: ListView.builder(
          itemCount: refugios.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Stack(children: [
                  Padding(
                    padding: const EdgeInsets.all(50),
                    child: GestureDetector(
                      onTap: () {
                        ref.read(idRefugioInfoProvider.notifier).state =
                                  refugios[index]["id_refugio"].toString();
                        context.push('/refugiosProfile',
                            extra: refugios[index]);
                      },
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(1.0, 1.0, 30, 1.0),
                            child: Icon(
                              Icons.house_sharp,
                              size: 60,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(refugios[index]["nombre_refugio"]),
                              Text(refugios[index]["email_refugio"]),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      right: 10,
                      bottom: 10,
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              ref.read(idRefugioInfoProvider.notifier).state =
                                  refugios[index]["id_refugio"].toString();
                              context.push('/refugiosProfile',
                                  extra: refugios[index]);
                            },
                            child: const Text(
                              "Información y Mascotas",
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded)
                        ],
                      ))
                ]),
              ),
            );
          },
        ),
        bottomNavigationBar: const BottomNavigationUser());
  }
}
