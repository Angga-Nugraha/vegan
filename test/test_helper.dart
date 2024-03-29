import "package:vegan/data/datasource/auth_remote_datasource.dart";
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:vegan/data/datasource/product_remote_datasource.dart';
import 'package:vegan/data/datasource/user_remote_datasource.dart';
import 'package:vegan/domain/repositories/auth_repositories.dart';
import 'package:vegan/domain/repositories/product_repositories.dart';
import 'package:vegan/domain/repositories/user_repository.dart';

@GenerateMocks([
  UserRemoteDatasource,
  UserRepository,
  AuthRepository,
  AuthRemoteDataSource,
  ProductRepository,
  ProductRemoteDatasource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
