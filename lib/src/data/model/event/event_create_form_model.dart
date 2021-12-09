import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../../utils/utils.dart';

class EventCreateFormModel extends Equatable {
  const EventCreateFormModel({
    this.title = '',
    required this.idOrganization,
    required this.idCategory,
    required this.quota,
    required this.startDate,
    required this.endDate,
    required this.eventType,
    this.location = '',
    this.description = '',
    this.file,
  });

  final String title;
  final int idOrganization;
  final int idCategory;
  final int quota;
  final DateTime startDate;
  final DateTime endDate;
  final EventType eventType;
  final String location;
  final String description;
  final File? file;

  @override
  List<Object?> get props {
    return [
      title,
      idOrganization,
      idCategory,
      quota,
      startDate,
      endDate,
      eventType,
      location,
      description,
      file,
    ];
  }

  EventCreateFormModel copyWith({
    String? title,
    int? idOrganization,
    int? idCategory,
    int? quota,
    DateTime? startDate,
    DateTime? endDate,
    EventType? eventType,
    String? location,
    String? description,
    File? file,
  }) {
    return EventCreateFormModel(
      title: title ?? this.title,
      idOrganization: idOrganization ?? this.idOrganization,
      idCategory: idCategory ?? this.idCategory,
      quota: quota ?? this.quota,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      eventType: eventType ?? this.eventType,
      location: location ?? this.location,
      description: description ?? this.description,
      file: file ?? this.file,
    );
  }

  @override
  String toString() {
    return 'EventCreateFormModel(title: $title, idOrganization: $idOrganization, idCategory: $idCategory, quota: $quota, startDate: $startDate, endDate: $endDate, eventType: $eventType, location: $location, description: $description, file: $file)';
  }
}
