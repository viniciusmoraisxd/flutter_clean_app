import 'package:faker/faker.dart';
import 'package:flutter_clean_app/data/cache/cache.dart';
import 'package:flutter_clean_app/data/http/http.dart';
import 'package:flutter_clean_app/main/decorators/decorators.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class FetchSecureCacheStorageSpy extends Mock
    implements FetchSecureCacheStorage {}

class DeleteSecureCacheStorageSpy extends Mock
    implements DeleteSecureCacheStorage {}

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  FetchSecureCacheStorageSpy fetchSecureCacheStorageSpy;
  DeleteSecureCacheStorageSpy deleteSecureCacheStorageSpy;
  HttpClientSpy httpClientSpy;
  AuthorizeHttpClientDecorator sut;
  String url;
  String method;
  Map body;
  String token;
  String httpResponse;

  PostExpectation mockTokenCall() =>
      when(fetchSecureCacheStorageSpy.fetch(any));

  void mockToken() {
    token = faker.guid.guid();

    mockTokenCall().thenAnswer((_) async => token);
  }

  void mockTokenError() {
    mockTokenCall().thenThrow(Exception());
  }

  PostExpectation mockHttpResponseCall() => when(httpClientSpy.request(
        url: anyNamed('url'),
        method: anyNamed('method'),
        body: anyNamed('body'),
        headers: anyNamed('headers'),
      ));

  void mockHttpResponse() {
    httpResponse = faker.randomGenerator.string(50);

    mockHttpResponseCall().thenAnswer((_) async => httpResponse);
  }

  void mockHttpResponseError(HttpError error) {
    mockHttpResponseCall().thenThrow(error);
  }

  setUp(() {
    httpClientSpy = HttpClientSpy();
    fetchSecureCacheStorageSpy = FetchSecureCacheStorageSpy();
    deleteSecureCacheStorageSpy = DeleteSecureCacheStorageSpy();
    sut = AuthorizeHttpClientDecorator(
        fetchSecureCacheStorage: fetchSecureCacheStorageSpy,
        deleteSecureCacheStorage: deleteSecureCacheStorageSpy,
        decoratee: httpClientSpy);

    url = faker.internet.httpUrl();
    method = faker.randomGenerator.string(10);
    body = {'any_key': 'any_value'};
    mockToken();
    mockHttpResponse();
  });

  test('Should call FetchSecureCacheStorage with correct key', () async {
    await sut.request(url: url, method: method, body: body);
    verify(fetchSecureCacheStorageSpy.fetch('token')).called(1);
  });

  test('Should call decoratee with access token on header', () async {
    await sut.request(url: url, method: method, body: body);

    verify(httpClientSpy.request(
        url: url,
        method: method,
        body: body,
        headers: {'x-access-token': token})).called(1);

    await sut.request(
        url: url,
        method: method,
        body: body,
        headers: {'any_header': 'any_value'});

    verify(httpClientSpy.request(
            url: url,
            method: method,
            body: body,
            headers: {'x-access-token': token, 'any_header': 'any_value'}))
        .called(1);
  });

  test('Should return same response as decoratee', () async {
    final response = await sut.request(url: url, method: method, body: body);

    expect(response, httpResponse);
  });

  test('Should throw ForbiddenError if FetchSecureCacheStorage throws',
      () async {
    mockTokenError();

    final future = sut.request(url: url, method: method, body: body);

    expect(future, throwsA(HttpError.forbidden));
    verify(deleteSecureCacheStorageSpy.delete('token')).called(1);
  });

  test('Should rethrow if decoratee throws', () async {
    mockHttpResponseError(HttpError.badRequest);

    final future = sut.request(url: url, method: method, body: body);

    expect(future, throwsA(HttpError.badRequest));
  });

  test('Should delete cache if request throws forbiddenError', () async {
    mockHttpResponseError(HttpError.forbidden);

    final future = sut.request(url: url, method: method, body: body);
    await untilCalled(deleteSecureCacheStorageSpy.delete('token'));
    expect(future, throwsA(HttpError.forbidden));
    verify(deleteSecureCacheStorageSpy.delete('token')).called(1);
  });
}
