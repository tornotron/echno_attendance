import 'package:flutter/material.dart';

class EchnoApp extends StatelessWidget {
  const EchnoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const EchnoHomePage(),
    );
  }
}

class EchnoHomePage extends StatelessWidget {
  const EchnoHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Echno'),
      ),
      body: const Center(
        child: Text(
          'Echno',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
