import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension ContextExtension on BuildContext {
  // ignore: strict_raw_type
  T bloc<T extends Bloc>() {
    return BlocProvider.of<T>(this);
  }

  Size deviceSize() {
    return MediaQuery.of(this).size;
  }
}
