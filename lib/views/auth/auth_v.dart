import 'package:easy_localization/easy_localization.dart';
import 'package:fitness/core/base/routes.dart';
import 'package:fitness/core/constants/images.dart';
import 'package:fitness/core/constants/texts.dart';
import 'package:fitness/core/enums/auth_enum.dart';
import 'package:fitness/core/extensions/ui_exts.dart';
import 'package:fitness/services/auth_service.dart';
import 'package:fitness/services/hive_service.dart';
import 'package:fitness/views/auth/register_form_v.dart';
import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:pinput/pinput.dart';

class AuthView extends StatelessWidget {
  final PhoneController phoneCont =
      PhoneController(initialValue: const PhoneNumber(isoCode: IsoCode.TR, nsn: ''));
  AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService.init();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildBody(context),
          ],
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return StreamBuilder<AuthEnum>(
        stream: AuthService.otpStream.stream,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: 35.toRadiusAll(),
                      ),
                      child: Image.asset(Images.auth)),
                  const SizedBox(height: 50),
                  Text(
                    Texts.loginTitle.tr(),
                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  Card.outlined(
                    elevation: 1.3,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (snapshot.data == AuthEnum.phone) phoneForm(true),
                          if (snapshot.data == AuthEnum.otp) phoneForm(false),
                          if (snapshot.data == AuthEnum.otp)
                            otpForm(context, snapshot.data ?? AuthEnum.error),
                          if (snapshot.data == AuthEnum.error) onError(),
                          if (snapshot.data == AuthEnum.register) RegisterFormView(),
                          if (snapshot.data != AuthEnum.otp && snapshot.data != AuthEnum.register)
                            actionButton(context, snapshot.data ?? AuthEnum.error),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget phoneForm(bool enable) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: PhoneFormField(
        controller: phoneCont,
        countrySelectorNavigator: const CountrySelectorNavigator.modalBottomSheet(),
        enabled: enable,
        countryButtonPadding: null,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: 20.toRadiusAll()),
          labelText: Texts.phoneNumber,
        ),
        isCountrySelectionEnabled: true,
        isCountryButtonPersistent: true,
        showDialCode: true,
        showIsoCodeInInput: false,
        showFlagInInput: true,
        flagSize: 24,
      ),
    );
  }

  Widget otpForm(BuildContext context, AuthEnum status) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Pinput(
        keyboardType: TextInputType.number,
        length: 6,
        autofocus: true,
        onCompleted: (pin) async {
          await AuthService.otpVerify(pin).then((userModel) {
            if (userModel != null) {
              HiveService.userBox!.put(0, userModel);
              AuthService.otpStream.close();
              Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
            }
          });
        },
      ),
    );
  }

  Widget actionButton(BuildContext _, AuthEnum status) {
    String text;
    switch (status) {
      case AuthEnum.phone:
        text = Texts.login;
        break;
      case AuthEnum.error:
        text = Texts.tryAgain;
        break;
      default:
        text = Texts.login;
    }
    return Container(
      margin: const EdgeInsets.all(10),
      child: OutlinedButton(
        onPressed: () async {
          if (status == AuthEnum.phone) {
            if (!phoneCont.value.isValid()) {
              ScaffoldMessenger.of(_).showSnackBar(
                SnackBar(content: Text(Texts.phoneNumberAlert.tr())),
              );
            } else {
              // AuthService.phoneVerify(phoneCont.value.international);
              AuthService.testLogin().then((value) {
                if (value == null) {
                  AuthService.otpStream.sink.add(AuthEnum.register);
                }
              });
              // AuthService.otpStream.sink.add(AuthEnum.otp);
            }
          } else if (status == AuthEnum.error) {
            AuthService.otpStream.sink.add(AuthEnum.phone);
          }
        },
        child: Text(text.tr()),
      ),
    );
  }

  Widget onError() {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 10),
      child: Center(
        child: Column(
          children: [
            Text(
              Texts.someThingWentWrong.tr(),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(AuthService.error)
          ],
        ),
      ),
    );
  }
}
