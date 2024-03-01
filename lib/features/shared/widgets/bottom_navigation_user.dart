import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationUser extends StatelessWidget {
  const BottomNavigationUser({super.key});

  int getCurrentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();

    switch (location) {
      case '/pets':
        return 0;

      case '/lost':
        return 1;

      case '/street':
        return 2;

      case '/refugios':
        return 3;

      default:
        return 0;
    }
  }

  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/pets');
        break;
      case 1:
        context.go('/lost');
        break;
      case 2:
        context.go('/street');
        break;
      case 3:
        context.go('/refugios');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(206, 247, 151, 8),
        currentIndex: getCurrentIndex(context),
        onTap: (index) => onItemTapped(context, index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.pets_outlined,
              color: Colors.white,
            ),
            activeIcon: Icon(Icons.pets_rounded),
            label: 'Adopta',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.question_mark_outlined, color: Colors.white),
              activeIcon: Icon(Icons.question_mark_rounded),
              label: 'Perdidos'),
          BottomNavigationBarItem(
              icon: Icon(Icons.book_sharp, color: Colors.white),
              activeIcon: Icon(Icons.book_rounded),
              label: 'Encontrados'),
          BottomNavigationBarItem(
              icon: Icon(Icons.house_sharp, color: Colors.white),
              activeIcon: Icon(Icons.house_rounded),
              label: 'Refugios'),
        ]);
  }
}
