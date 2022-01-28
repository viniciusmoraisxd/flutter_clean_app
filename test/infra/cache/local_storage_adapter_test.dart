import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localstorage/localstorage.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';

class LocalStorageAdapter {
  final LocalStorage localStorage;

  LocalStorageAdapter({@required this.localStorage});

  Future<void> save({@required String key, @required dynamic value}) async {
    await localStorage.setItem(key, value);
  }
}

class LocalStorageSpy extends Mock implements LocalStorage {}

void main() {
  test('Should call localStorage with correct values', () async {
    final localStorageSpy = LocalStorageSpy();
    final sut = LocalStorageAdapter(localStorage: localStorageSpy);
    final key = faker.randomGenerator.string(5);
    final value = faker.randomGenerator.string(50);

    await sut.save(key: key, value: value);

    verify(localStorageSpy.setItem(key, value)).called(1);
  });
}
