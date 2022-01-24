import 'package:flutter_clean_app/data/usecases/add_account/add_account.dart';
import 'package:flutter_clean_app/data/usecases/usecases.dart';
import 'package:flutter_clean_app/domain/usecases/usecases.dart';
import 'package:flutter_clean_app/main/factories/factories.dart';

LoadSurveys makeRemoteLoadSurveys() => RemoteLoadSurveys(
    httpClient: makeHttpAdapter(), url: makeApiUrl('surveys'));
