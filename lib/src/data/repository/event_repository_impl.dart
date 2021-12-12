import 'dart:io';

import '../../domain/repository/event_repository.dart';
import '../../utils/utils.dart';
import '../datasource/event_local_datasource.dart';
import '../datasource/event_remote_datasource.dart';
import '../model/event/event_bookmark_model.dart';
import '../model/event/event_create_form_model.dart';
import '../model/event/event_detail_model.dart';
import '../model/event/event_for_you_model.dart';
import '../model/event/event_model.dart';
import '../model/event/event_nearest_date_model.dart';
import '../model/event/response/event_join_response_model.dart';

class EventRepositoryImpl implements EventRepository {
  const EventRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final EventRemoteDataSource remoteDataSource;
  final EventLocalDataSource localDataSource;

  ///* Remote DataSource
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
    } catch (e) {
      throw CommonFailure(e.toString());
    }
  }

  @override
  Future<EventDetailModel> eventById({
    required int idEvent,
    required int idUser,
  }) async {
    try {
      final result = await remoteDataSource.eventById(
        idEvent: idEvent,
        idUser: idUser,
      );
      return result;
    } on SocketException catch (_) {
      throw const ConnectionFailure('Koneksi ke server bermasalah, coba beberapa saat lagi');
    } catch (e) {
      throw CommonFailure(e.toString());
    }
  }

  @override
  Future<EventJoinResponseModel> joinEvent({required int idUser, required int idEvent}) async {
    try {
      final result = await remoteDataSource.joinEvent(idUser: idUser, idEvent: idEvent);
      return result;
    } on SocketException catch (_) {
      throw const ConnectionFailure('Koneksi ke server bermasalah, coba beberapa saat lagi');
    } on ValidationException catch (e) {
      throw ValidationFailure(e.message);
    } catch (e) {
      throw CommonFailure(e.toString());
    }
  }

  ///* Local DataSource
  @override
  Future<String> deleteBookmark(int id) async {
    try {
      return await localDataSource.deleteBookmark(id);
    } catch (e) {
      throw CommonFailure(e.toString());
    }
  }

  @override
  Future<String> saveBookmark(EventBookmarkModel model) async {
    try {
      return await localDataSource.saveBookmark(model);
    } catch (e) {
      throw CommonFailure(e.toString());
    }
  }

  @override
  List<EventBookmarkModel> fetchBookmark() {
    try {
      return localDataSource.fetchBookmark();
    } catch (e) {
      throw CommonFailure(e.toString());
    }
  }
}
