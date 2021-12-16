import 'package:faker/faker.dart';
import 'package:flutter_clean_app/domain/entities/account_entity.dart';
import 'package:flutter_clean_app/domain/usecases/load_current_account.dart';
import 'package:flutter_clean_app/ui/pages/pages.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

class GetxSplashPresenter implements SplashPresenter {
  final LoadCurrentAccount loadCurrentAccount;
  var _navigateTo = RxString();

  GetxSplashPresenter({@required this.loadCurrentAccount});

  @override
  Future<void> checkAccount() async {
    final account = await loadCurrentAccount.load();

    _navigateTo.value = account.isNull ? '/login' : '/surveys';
  }

  @override
  Stream<String> get navigateToStream => _navigateTo.stream;
}

class LoadCurrentAccountSpy extends Mock implements LoadCurrentAccount {}

void main() {
  LoadCurrentAccountSpy loadCurrentAccount;
  GetxSplashPresenter sut;

  void mockLoadCurrentAccount({AccountEntity account}) {
    when(loadCurrentAccount.load()).thenAnswer((_) async => account);
  }

  setUp(() {
    loadCurrentAccount = LoadCurrentAccountSpy();
    sut = GetxSplashPresenter(loadCurrentAccount: loadCurrentAccount);

    mockLoadCurrentAccount(account: AccountEntity(faker.guid.guid()));
  });

  test('Should call checkAccount', () async {
    await sut.checkAccount();

    verify(loadCurrentAccount.load()).called(1);
  });

  test('Should call checkAccount', () async {
    await sut.checkAccount();

    verify(loadCurrentAccount.load()).called(1);
  });

  test('Should go to SurveysPage on success', () async {
    sut.navigateToStream
        .listen(expectAsync1((page) => expect(page, '/surveys')));

    await sut.checkAccount();
  });
  
  test('Should go to LoginPage on null result', () async {
    mockLoadCurrentAccount(account: null);

    sut.navigateToStream.listen(expectAsync1((page) => expect(page, '/login')));

    await sut.checkAccount();
  });
}
