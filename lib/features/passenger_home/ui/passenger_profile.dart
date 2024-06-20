import 'package:egy_bus/core/caching/app_shared_pref.dart';
import 'package:egy_bus/core/caching/app_shared_pref_key.dart';
import 'package:egy_bus/core/helper/extension.dart';
import 'package:egy_bus/core/routing/routes.dart';
import 'package:egy_bus/core/theming/styles.dart';
import 'package:egy_bus/core/widgets/app_loading.dart';
import 'package:egy_bus/core/widgets/app_text_button.dart';
import 'package:egy_bus/features/passenger_home/logic/cubit/passenger_home_cubit.dart';
import 'package:egy_bus/features/passenger_home/logic/cubit/passenger_home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PassengerProfile extends StatelessWidget {
  const PassengerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PassengerHomeCubit>().emitPassengerProfileResponse();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: BlocBuilder<PassengerHomeCubit, PassengerHomeState>(
        builder: (context, state) {
          return state.maybeWhen(
              orElse: () => Container(),
              passengerProfileLoading: () {
                return const AppLoading();
              },
              passengerProfileSuccess: (data) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            profileRow('full name', data.fullName.toString()),
                            profileRow('user name', data.username.toString(), ),
                            profileRow('email', data.email.toString()),
                            profileRow('number', data.phoneNumber.toString()),

                          AppTextButton(onPressed: (){
                            context.pushNamedAndRemoveUntil(Routes.chooseUser);
                            AppSharedPref.removeKey(key: AppSharedPrefKey.passengerUserId);
                            AppSharedPref.removeKey(key: AppSharedPrefKey.passengerIdFrom);
                            AppSharedPref.removeKey(key: AppSharedPrefKey.passengerIdTo);
                            AppSharedPref.removeKey(key: AppSharedPrefKey.passengerName);
                          },
                          text: 'logOut',
                            textStyle: TextStyles.font28WhiteSemiBold.copyWith(

                            )
                          )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              passengerProfileFailure: (failure) {
                return Text(failure.toString());
              });
        },
      ),
    );
  }

  Widget profileRow(String title, String value, {bool verified = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4.0),
              Row(
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
