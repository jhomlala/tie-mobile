import 'package:freezed_annotation/freezed_annotation.dart';
part 'tie_user.freezed.dart';
part 'tie_user.g.dart';

@freezed
class TieUser with _$TieUser {
  const factory TieUser({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'email') required String email,
    @JsonKey(name: 'emailVerified') required bool emailVerified,
  }) = _TieUser;

  factory TieUser.fromJson(Map<String, Object?> json) =>
      _$TieUserFromJson(json);
}
