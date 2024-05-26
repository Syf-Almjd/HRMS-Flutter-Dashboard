import 'package:admin/config/utils/styles/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../data/remote/RemoteData_cubit/RemoteData_cubit.dart';
import '../../../Shared/Components.dart';
import '../../../Shared/WidgetBuilders.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isObscure = true;
  late String emailData, passData;
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  final _validateKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _validateKey,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: getWidth(2, context)),
        physics: const BouncingScrollPhysics(),
        children: [
          Text(
            "Login",
            style: fontLobster(size: getWidth(5, context)),
            textAlign: TextAlign.center,
          ),
          getCube(3, context),
          Container(
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty || !value.contains('@')) {
                  showToast("Your Email is incorrect!", Colors.red, context);
                  return "Your Email is incorrect";
                }
                return null;
              },
              style: TextStyle(color: AppColors.darkColor.withOpacity(0.7)),
              controller: email,
              decoration: InputDecoration(
                labelStyle: TextStyle(color: AppColors.greyDark),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                labelText: "Email",
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: AppColors.greyDark,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            onFieldSubmitted: (value) {
              if (validateForm(_validateKey)) {
                RemoteDataCubit.get(context)
                    .adminUserLogin(email.text, pass.text, context);
              }
            },
            validator: (value) {
              if (value!.isEmpty || value.length <= 4) {
                showToast("Wrong Password", Colors.red, context);
                return "Wrong Password";
              }
              return null;
            },
            controller: pass,
            obscureText: _isObscure,
            style: TextStyle(color: AppColors.darkColor.withOpacity(0.7)),
            decoration: InputDecoration(
              labelStyle: TextStyle(color: AppColors.greyDark),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              labelText: 'Password',
              prefixIcon: const Icon(Icons.password_outlined,
                  color: AppColors.greyDark),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                      color: AppColors.greyDark),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                ),
              ),
            ),
          ),
          // Container(
          //   padding: const EdgeInsets.all(10),
          //   alignment: Alignment.centerRight,
          //   child: InkWell(
          //     child: Text(
          //       "Register a new employee?",
          //       softWrap: true,
          //       style: TextStyle(color: Colors.grey),
          //       textAlign: TextAlign.right,
          //     ),
          //     onTap: () {
          //       BlocProvider.of<RegisterNavigationBloc>(context)
          //           .add(TabChange(1));
          //     },
          //   ),
          // ),
          getCube(3, context),
          loadButton(
              textSize: 20,
              buttonText: "Login",
              onPressed: () {
                if (validateForm(_validateKey)) {
                  RemoteDataCubit.get(context)
                      .adminUserLogin(email.text, pass.text, context);
                }
              }),
        ],
      ),
    );
  }
}
