import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../utils/utils.dart';
import 'event_for_you_model.dart';

part 'my_event_model.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class MyEventModel extends Equatable {
  final int id;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final EventType type;
  final int quota;
  final String? image;
  final String namaCategory;
  final String namaOrganisasi;

  const MyEventModel({
    this.id = 0,
    this.title = '',
    required this.startDate,
    required this.endDate,
    this.type = EventType.offline,
    this.quota = 0,
    this.image,
    this.namaCategory = '',
    this.namaOrganisasi = '',
  });

  factory MyEventModel.fromJson(Map<String, dynamic> json) => _$MyEventModelFromJson(json);
  Map<String, dynamic> toJson() => _$MyEventModelToJson(this);

  EventForYouModel toEventForYouModel() {
    return EventForYouModel(
      id: id,
      title: title,
      startDate: startDate,
      endDate: endDate,
      type: type,
      quota: quota,
      image: image,
      namaCategory: namaCategory,
      namaOrganisasi: namaOrganisasi,
    );
  }

  @override
  bool get stringify => true;
  @override
  List<Object?> get props {
    return [
      id,
      title,
      startDate,
      endDate,
      type,
      quota,
      image,
      namaCategory,
      namaOrganisasi,
    ];
  }

  MyEventModel copyWith({
    int? id,
    String? title,
    DateTime? startDate,
    DateTime? endDate,
    EventType? type,
    int? quota,
    String? image,
    String? namaCategory,
    String? namaOrganisasi,
  }) {
    return MyEventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      type: type ?? this.type,
      quota: quota ?? this.quota,
      image: image ?? this.image,
      namaCategory: namaCategory ?? this.namaCategory,
      namaOrganisasi: namaOrganisasi ?? this.namaOrganisasi,
    );
  }
}
