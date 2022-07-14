import 'package:get/get.dart';

import 'package:lablebwallet/app/modules/accounts/bindings/accounts_binding.dart';
import 'package:lablebwallet/app/modules/accounts/views/accounts_view.dart';
import 'package:lablebwallet/app/modules/assets/bindings/assets_binding.dart';
import 'package:lablebwallet/app/modules/assets/views/assets_view.dart';
import 'package:lablebwallet/app/modules/create_wallet/bindings/create_wallet_binding.dart';
import 'package:lablebwallet/app/modules/create_wallet/views/create_wallet_view.dart';
import 'package:lablebwallet/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:lablebwallet/app/modules/dashboard/views/dashboard_view.dart';
import 'package:lablebwallet/app/modules/home/bindings/home_binding.dart';
import 'package:lablebwallet/app/modules/home/views/home_view.dart';
import 'package:lablebwallet/app/modules/import_wallet/bindings/import_wallet_binding.dart';
import 'package:lablebwallet/app/modules/import_wallet/views/import_wallet_view.dart';
import 'package:lablebwallet/app/modules/receiver/bindings/receiver_binding.dart';
import 'package:lablebwallet/app/modules/receiver/views/receiver_view.dart';
import 'package:lablebwallet/app/modules/sender/bindings/sender_binding.dart';
import 'package:lablebwallet/app/modules/sender/views/sender_view.dart';
import 'package:lablebwallet/app/modules/settings/bindings/settings_binding.dart';
import 'package:lablebwallet/app/modules/settings/views/settings_view.dart';

import '../modules/middle_ware/middle_ware.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.DASHBOARD;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ASSETS,
      page: () => const AssetsView(),
      binding: AssetsBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
      middlewares: [MiddleWareMe()],
    ),
    GetPage(
      name: _Paths.ACCOUNTS,
      page: () => const AccountsView(),
      binding: AccountsBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_WALLET,
      page: () => CreateWalletView(),
      binding: CreateWalletBinding(),
    ),
    GetPage(
      name: _Paths.IMPORT_WALLET,
      page: () => ImportWalletView(),
      binding: ImportWalletBinding(),
    ),
    GetPage(
      name: _Paths.RECEIVER,
      page: () => ReceiverView(),
      binding: ReceiverBinding(),
    ),
    GetPage(
      name: _Paths.SENDER,
      page: () => SenderView(),
      binding: SenderBinding(),
    ),
  ];
}
