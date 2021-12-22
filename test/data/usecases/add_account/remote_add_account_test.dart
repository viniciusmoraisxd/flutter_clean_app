import 'package:faker/faker.dart';
import 'package:flutter_clean_app/data/http/http.dart';
import 'package:flutter_clean_app/data/usecases/add_account/add_account.dart';

import 'package:flutter_clean_app/domain/helpers/helpers.dart';
import 'package:flutter_clean_app/domain/usecases/usecases.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  HttpClientSpy httpClientSpy;
  String url;
  String method;
  String password;
  AddAccountParams params;
  RemoteAddAccount sut;

  Map mockValidData() =>
      {"accessToken": faker.guid.guid(), "name": faker.person.name()};
  PostExpectation mockRequest() => when(httpClientSpy.request(
      url: anyNamed('url'),
      method: anyNamed('method'),
      body: anyNamed('body')));

  void mockHttpError(HttpError error) {
    mockRequest().thenThrow(error);
  }

  void mockHttpData(Map data) {
    mockRequest().thenAnswer((_) async => data);
  }

  setUp(() {
    httpClientSpy = HttpClientSpy();
    url = faker.internet.httpUrl();
    method = 'post';
    password = faker.internet.password();
    params = AddAccountParams(
        email: faker.internet.email(),
        name: faker.person.name(),
        password: password,
        passwordConfirmation: password);
    sut = RemoteAddAccount(url: url, httpClient: httpClientSpy);

    mockHttpData(mockValidData());
  });

  test('Should Call HttpClientSpy with correct values', () async {
    await sut.add(params);

    verify(httpClientSpy.request(url: url, method: method, body: {
      "name": params.name,
      "email": params.email,
      "password": params.password,
      "passwordConfirmation": params.passwordConfirmation
    }));
  });

  test('Should throw an UnexpectedError if status code 400', () async {
    mockHttpError(HttpError.badRequest);

    final future = sut.add(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw an EmailInUseError if status code 403', () async {
    mockHttpError(HttpError.forbidden);

    final future = sut.add(params);

    expect(future, throwsA(DomainError.emailInUse));
  });

  test('Should throw an UnexpectedError if status code 404', () async {
    mockHttpError(HttpError.notFound);

    final future = sut.add(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw an UnexpectedError if status code 500', () async {
    mockHttpError(HttpError.serverError);

    final future = sut.add(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should return an UnexpectedError on success and data is invalid',
      () async {
    mockHttpData({
      "invalid_key": "invalid_value",
    });

    final future = sut.add(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should return an EntityAccount on success', () async {
    final validData = mockValidData();
    mockHttpData(validData);

    final response = await sut.add(params);

    expect(response.token, validData['accessToken']);
  });
}
