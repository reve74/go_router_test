import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_actual/layout/default_layout.dart';
import 'package:go_router_actual/screen/3_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              context.go('/one');
            },
            child: Text('Screen One (go)'),
          ),
          ElevatedButton(
            onPressed: () {
              context.goNamed(ThreeScreen.routeName);
            },
            child: Text('Screen Three (go)'),
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/error');
            },
            child: Text('Error screen (go)'),
          ),
        ],
      ),
    );
  }
}
