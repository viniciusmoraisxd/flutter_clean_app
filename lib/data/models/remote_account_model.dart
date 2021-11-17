import 'package:flutter_clean_app/data/http/http.dart';
import 'package:flutter_clean_app/domain/entities/entities.dart';

class RemoteAccountModel {
  final String accessToken;

  RemoteAccountModel(this.accessToken);

  factory RemoteAccountModel.fromJson(Map json) {
   if(!json.containsKey('accessToken')){
     throw HttpError.invalidData;
   }
   return RemoteAccountModel(json['accessToken']);
  }

  AccountEntity toEntity() => AccountEntity(accessToken);
}
