import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tie_mobile/app/router.dart';
import 'package:tie_mobile/common/extensions/context_ext.dart';
import 'package:tie_mobile/common/theme/tie_theme.dart';
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
      materialsBloc.add(const MaterialsEvent.initialise());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MaterialsBloc, MaterialsState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: _MaterialsGridView(
                materials: state.materials,
                onItemPressed: (item) {

                  context.pushNamed(
                    Routes.material.path,
                    extra: item,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _MaterialsGridView extends StatelessWidget {
  const _MaterialsGridView({
    required this.materials,
    required this.onItemPressed,
  });

  final List<TieMaterial> materials;
  final void Function(TieMaterial) onItemPressed;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: materials.length,
      itemBuilder: (context, index) {
        return _MaterialsGridItem(
          material: materials[index],
          onPressed: onItemPressed,
        );
      },
    );
  }
}

class _MaterialsGridItem extends StatelessWidget {
  const _MaterialsGridItem({required this.material, required this.onPressed});

  final TieMaterial material;
  final void Function(TieMaterial) onPressed;

  @override
  Widget build(BuildContext context) {
    final size = context.deviceSize();
    final iconSize = size.width / 4;
    return InkWell(
      onTap: () {
        onPressed(material);
      },
      child: Column(
        children: [
          Image.network(
            material.image,
            width: iconSize,
            height: iconSize,
          ),
          Text(material.name, style: TieTheme.title),
        ],
      ),
    );
  }
}
