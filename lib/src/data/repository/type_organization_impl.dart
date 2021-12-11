import 'dart:io';

import '../../domain/repository/type_organization_repository.dart';
import '../../utils/utils.dart';
import '../datasource/type_organization_remote_datasource.dart';
import '../model/type_organization/type_organization_model.dart';

class TypeOrganizationRepositoryImpl implements TypeOrganizationRepository {
  const TypeOrganizationRepositoryImpl({
    required this.remoteDataSource,
  });
  final TypeOrganizationRemoteDataSource remoteDataSource;
  @override
  Future<List<TypeOrganization>> get() async {
    try {
      final result = await remoteDataSource.get();
      return result;
    } on SocketException catch (_) {
      throw const ConnectionFailure('Koneksi ke server bermasalah, coba beberapa saat lagi');
    } catch (e) {
      throw CommonFailure(e.toString());
    }
  }
}
