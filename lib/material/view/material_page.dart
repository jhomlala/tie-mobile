import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class TieMaterialPage extends StatefulWidget {
  const TieMaterialPage({required this.material, super.key});

  final TieMaterial material;

  @override
  State<TieMaterialPage> createState() => _TieMaterialPageState();
}

class _TieMaterialPageState extends State<TieMaterialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(widget.material.toString()),
    );
  }
}
