import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:salla/shared/components/constants.dart';
import 'package:salla/shared/cubits/register_cubit/cubit.dart';
import 'package:salla/shared/cubits/register_cubit/states.dart';
import '../../layout/shop_layout.dart';
import '../../shared/components/component.dart';
import '../../shared/network/local/cache_helper/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status!) {
              toast(
                  message: state.loginModel.message!,
                  data: ToastStates.success);

              CacheHelper.saveData(
                      key: 'token', data: state.loginModel.data!.token)
                  .then((value) {
                print(CacheHelper.getData(key: 'token'));
                token = state.loginModel.data!.token!;
                navigateAndFinish(context, const ShopLayout());
              });
            }
          }
        },
        builder: (context, state) {
          RegisterCubit cubit = RegisterCubit.getCubit(context);
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Register Now',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 30.6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'To experience our great services',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                            context: context,
                            label: 'User Name',
                            prefix: const Icon(Icons.person),
                            controller: nameController,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'user name can\'t be empty';
                              }
                              return null;
                            },
                            type: TextInputType.text,
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          defaultFormField(
                            context: context,
                            label: 'Email Address',
                            prefix: const Icon(Icons.email),
                            controller: emailController,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'email can\'t be empty';
                              }
                              return null;
                            },
                            type: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          defaultFormField(
                              context: context,
                              controller: passwordController,
                              label: 'Password',
                              prefix: const Icon(Icons.lock),
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'password can\'t be empty';
                                }
                                return null;
                              },
                              suffix: cubit.isPassword
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                              pressedShow: () {
                                cubit.changePasswordVisibility();
                              },
                              isPassword: cubit.isPassword,
                              type: TextInputType.visiblePassword),
                          const SizedBox(
                            height: 15.0,
                          ),
                          defaultFormField(
                            context: context,
                            label: 'Phone',
                            prefix: const Icon(Icons.phone),
                            controller: phoneController,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'phone can\'t be empty';
                              }
                              return null;
                            },
                            type: TextInputType.text,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            width: double.infinity,
                            height: 40,
                            color: Colors.blue,
                            child: MaterialButton(
                              child: ConditionalBuilder(
                                condition: state is! ShopRegisterLoadingState,
                                builder: (context) => const Text(
                                  'Register',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                fallback: (context) => const SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.register(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
