import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../utils/utils.dart';

part 'event_nearest_date_model.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class EventNearestDateModel extends Equatable {
  const EventNearestDateModel({
    this.id = 0,
    this.title = '',
    required this.startDate,
    required this.endDate,
    this.type = EventType.online,
    this.quota = 0,
    this.image,
    this.namaCategory = '',
    this.namaOrganisasi = '',
  });

  final int id;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final EventType type;
  final int quota;
  final String? image;
  final String namaCategory;
  final String namaOrganisasi;

  factory EventNearestDateModel.fromJson(Map<String, dynamic> json) =>
      _$EventNearestDateModelFromJson(json);
  Map<String, dynamic> toJson() => _$EventNearestDateModelToJson(this);

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

  EventNearestDateModel copyWith({
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
    return EventNearestDateModel(
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
