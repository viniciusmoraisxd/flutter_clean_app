import 'package:meta/meta.dart';

abstract class HttpClient<ResponseType> {
  Future<ResponseType> request({
    @required String url,
    @required method,
    Map body,
  });
}
