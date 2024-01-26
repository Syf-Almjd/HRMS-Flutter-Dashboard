import 'package:admin/domain/entities/Authentication/AuthenticationLayout.dart';
import 'package:dart_secure/dart_secure.dart';
import 'package:flutter/material.dart';

import '../../../presentation/Modules/SideBar/home_page.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return userAuthMonitor(
        authenticatedUserPage: HomePage(),
        unAuthenticatedUserPage: SignLayout());
  }
}
