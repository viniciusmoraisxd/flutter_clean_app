import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter_clean_app/data/http/http.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:meta/meta.dart';

class ClientSpy extends Mock implements Client {}

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  Future<Map> request({
    @required String url,
    @required method,
    Map body,
  }) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };

    final jsonBody = body != null ? jsonEncode(body) : null;
    final response = await client.post(url, headers: headers, body: jsonBody);

    return response.body.isNotEmpty ? jsonDecode(response.body) : null;
  }
}

void main() {
  HttpAdapter sut;
  ClientSpy client;
  String url;

  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client);
    url = faker.internet.httpUrl();
  });

  group('Post Tests', () {
    PostExpectation mockRequest() => when(
        client.post(any, headers: anyNamed('headers'), body: anyNamed('body')));

    void mockResponse(int statusCode,
        {String body = '{"any_key":"any_value"}'}) {
      mockRequest().thenAnswer((_) async => Response(body, statusCode));
    }

    setUp(() {
      mockResponse(200);
    });

    test('Should call post with correct values', () async {
      await sut
          .request(url: url, method: 'post', body: {'any_key': 'any_value'});

      verify(
        client.post(
          url,
          headers: {
            'content-type': 'application/json',
            'accept': 'application/json'
          },
          body: '{"any_key":"any_value"}',
        ),
      );
    });

    test('Should call post without body', () async {
      await sut.request(url: url, method: 'post');

      verify(
        client.post(
          any,
          headers: anyNamed('headers'),
        ),
      );
    });

    test('Should return a data if status code 200', () async {
      final response = await sut.request(url: url, method: 'post');

      expect(response, {'any_key': 'any_value'});
    });

    test('Should return null if status code 200 without data', () async {
      mockResponse(200, body: '');

      final response = await sut.request(url: url, method: 'post');

      expect(response, null);
    });


     test('Should return null if status code 204', () async {
      mockResponse(204, body: '');

      final response = await sut.request(url: url, method: 'post');

      expect(response, null);
    });
  });
}
