import 'package:flutter_clean_app/data/usecases/add_account/add_account.dart';
import 'package:flutter_clean_app/domain/usecases/add_account.dart';
import 'package:flutter_clean_app/main/factories/factories.dart';

AddAccount makeRemoteAddAccount() =>
    RemoteAddAccount(httpClient: makeHttpAdapter(), url: makeApiUrl('signup'));
