import 'package:flutter_clean_app/data/http/http.dart';
import 'package:flutter_clean_app/main/decorators/decorators.dart';
import 'package:flutter_clean_app/main/factories/factories.dart';

HttpClient makeAuthorizeHttpClientDecorator() => AuthorizeHttpClientDecorator(
    decoratee: makeHttpAdapter(),
    fetchSecureCacheStorage: makeSecureStorageAdapter());
