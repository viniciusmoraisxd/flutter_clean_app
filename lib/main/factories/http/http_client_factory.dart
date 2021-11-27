import 'package:flutter_clean_app/data/http/http.dart';
import 'package:flutter_clean_app/infra/http/http.dart';
import 'package:http/http.dart';

HttpClient makeHttpAdapter() => HttpAdapter(Client());
