import 'dart:io';

import 'package:dartz/dartz.dart';
import '../datasource/type_organization_remote_datasource.dart';
import '../model/type_organization/type_organization_model.dart';
import '../../domain/repository/type_organization_repository.dart';
import '../../utils/utils.dart';

class TypeOrganizationRepositoryImpl implements TypeOrganizationRepository {
  const TypeOrganizationRepositoryImpl({
    required this.remoteDataSource,
  });
  final TypeOrganizationRemoteDataSource remoteDataSource;
  @override
  Future<Either<Failure, List<TypeOrganization>>> get() async {
    try {
      final result = await remoteDataSource.get();
      return Right(result);
    } on SocketException catch (_) {
      return const Left(ConnectionFailure('Koneksi ke server bermasalah, coba beberapa saat lagi'));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}
