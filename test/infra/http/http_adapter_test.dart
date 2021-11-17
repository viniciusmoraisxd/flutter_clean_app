import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:meta/meta.dart';

class ClientSpy extends Mock implements Client {}

class HttpAdapter {
  final Client client;

  HttpAdapter(this.client);

  Future<void> request({
    @required String url,
    @required method,
    Map body,
  }) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };
    await client.post(url, headers: headers);
  }
}

void main() {
  HttpAdapter sut;
  ClientSpy client;
  String url;
  
  group('Post Tests', () {
    test('Should call post with correct values', () async {
      client = ClientSpy();
      sut = HttpAdapter(client);

      url = faker.internet.httpUrl();

      await sut.request(url: url, method: 'post');

      verify(
        client.post(
          url,
          headers: {
            'content-type': 'application/json',
            'accept': 'application/json'
          },
        ),
      );
    });
  });
}
