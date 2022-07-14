
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../main.dart';
import '../../routes/app_pages.dart';

class MiddleWareMe extends GetMiddleware {



  @override
  int? get priority => 2;

  bool? isAuthenticated;

  @override
  RouteSettings? redirect(String? route) {
    accountStorage.read("login")==null?isAuthenticated=false:isAuthenticated=true;
    if (isAuthenticated == false) {
      return const RouteSettings(name: Routes.ACCOUNTS);
    }
    return null;
  }





}