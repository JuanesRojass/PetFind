import 'package:go_router/go_router.dart';
import 'package:mascotas_bga/controllers/gets/refugios_controller.dart';
import 'package:mascotas_bga/helpers/shared.dart';


class RefugiosScreen extends StatefulWidget {
  const RefugiosScreen({super.key});

  @override
  State<RefugiosScreen> createState() => _RefugiosScreenState();
}

class _RefugiosScreenState extends State<RefugiosScreen> {
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
                            onPressed: () => context.push('/refugiosProfile',
                                extra: refugios[index]),
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
