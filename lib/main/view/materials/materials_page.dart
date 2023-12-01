import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tie_mobile/common/extensions/context_ext.dart';
import 'package:tie_mobile/main/bloc/materials/materials_bloc.dart';

class MaterialsPage extends StatefulWidget {
  const MaterialsPage({super.key});

  @override
  State<MaterialsPage> createState() => _MaterialsPageState();
}

class _MaterialsPageState extends State<MaterialsPage> {
  MaterialsBloc get materialsBloc => context.bloc<MaterialsBloc>();
  bool _initalised = false;

  @override
  void initState() {
    super.initState();
    if (!_initalised) {
      _initalised = true;
      Log.info("Initialise");
      materialsBloc.add(const MaterialsEvent.initialise());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MaterialsBloc, MaterialsState>(
      builder: (context, state) {
        return Text("Materials: " + state.materials.length.toString());
      },
      listener: (context, state) {},
    );
  }
}
