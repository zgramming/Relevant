import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../utils/utils.dart';
import 'event_bookmark_model.dart';

part 'event_for_you_model.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class EventForYouModel extends Equatable {
  const EventForYouModel({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.type,
    required this.quota,
    required this.image,
    required this.namaCategory,
    required this.namaOrganisasi,
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

  factory EventForYouModel.fromJson(Map<String, dynamic> json) => _$EventForYouModelFromJson(json);
  Map<String, dynamic> toJson() => _$EventForYouModelToJson(this);

  EventBookmarkModel toBookmarkModel({required int idUser}) {
    return EventBookmarkModel(
      id: id,
      title: title,
      startDate: startDate,
      endDate: endDate,
      type: type,
      quota: quota,
      image: image,
      namaCategory: namaCategory,
      namaOrganisasi: namaOrganisasi,
      idUser: idUser,
    );
  }

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

  EventForYouModel copyWith({
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
    return EventForYouModel(
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
