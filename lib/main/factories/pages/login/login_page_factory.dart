import 'package:flutter/material.dart';
import 'package:flutter_clean_app/main/factories/factories.dart';
import 'package:flutter_clean_app/ui/pages/login/login_page.dart';

Widget makeLoginPage() => LoginPage(makeLoginPresenter());
