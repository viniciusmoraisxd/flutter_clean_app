import 'package:flutter_clean_app/data/usecases/remote_authentication.dart';
import 'package:flutter_clean_app/domain/usecases/authentication.dart';
import 'package:flutter_clean_app/main/factories/factories.dart';

Authentication makeRemoteAuthentication() => RemoteAuthentication(
    url: makeApiUrl('login'), httpClient: makeHttpAdapter());
