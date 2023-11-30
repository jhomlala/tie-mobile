import 'package:dartz/dartz.dart';

extension EitherExt<L, R> on Either<L, R> {
  R getRight() {
    late R right;
    map((r) => right = r);
    return right;
  }

  L getLeft() {
    late L left;
    leftMap((l) => left = l);
    return left;
  }

  R getRightOrElse(R orElse) {
    if (isLeft()) {
      return orElse;
    } else {
      return getRight();
    }
  }
}
