import "package:vegan/data/datasource/auth_remote_datasource.dart";
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:vegan/domain/repositories/auth_repositories.dart';

@GenerateMocks([
  AuthRepository,
  AuthRemoteDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
