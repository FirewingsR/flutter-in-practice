
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:functional_data/functional_data.dart';

part 'app.g.dart';

@JsonSerializable()
@FunctionalData()
class AppState extends $AppState {
  final String version;

  AppState({@required this.version});

  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);

  Map<String, dynamic> toJson() => _$AppStateToJson(this);
}
