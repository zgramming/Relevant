import 'dart:io';

import '../../domain/repository/event_repository.dart';
import '../../utils/utils.dart';
import '../datasource/event_remote_datasource.dart';
import '../model/event/event_create_form_model.dart';
import '../model/event/event_for_you_model.dart';
import '../model/event/event_model.dart';
import '../model/event/event_nearest_date_model.dart';

class EventRepositoryImpl implements EventRepository {
  EventRepositoryImpl({
    required this.remoteDataSource,
  });
  final EventRemoteDataSource remoteDataSource;

  @override
  Future<Event> create(EventCreateFormModel form) async {
    try {
      final result = await remoteDataSource.create(form);
      return result;
    } on SocketException catch (_) {
      throw const ConnectionFailure('Koneksi ke server bermasalah, coba beberapa saat lagi');
    } on ValidationException catch (e) {
      throw ValidationFailure(e.message);
    } catch (e) {
      throw CommonFailure(e.toString());
    }
  }

  @override
  Future<List<EventNearestDateModel>> nearestDate() async {
    try {
      final result = await remoteDataSource.nearestDate();
      return result;
    } on SocketException catch (_) {
      throw const ConnectionFailure('Koneksi ke server bermasalah, coba beberapa saat lagi');
    } on ValidationException catch (e) {
      throw ValidationFailure(e.message);
    } catch (e) {
      throw CommonFailure(e.toString());
    }
  }

  @override
  Future<List<EventForYouModel>> forYou() async {
    try {
      final result = await remoteDataSource.forYou();
      return result;
    } on SocketException catch (_) {
      throw const ConnectionFailure('Koneksi ke server bermasalah, coba beberapa saat lagi');
    } on ValidationException catch (e) {
      throw ValidationFailure(e.message);
    } catch (e) {
      throw CommonFailure(e.toString());
    }
  }
}
