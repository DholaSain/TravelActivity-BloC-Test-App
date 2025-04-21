import 'package:flutter/material.dart';

class NotFoundRoute extends StatelessWidget {
  const NotFoundRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('404 Not Found')),
      body: Center(
        child: Text(
          'Page not found',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
