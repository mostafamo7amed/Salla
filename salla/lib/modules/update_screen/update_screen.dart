import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla/shared/cubits/shop_cubit/shop_cubit.dart';
import 'package:salla/shared/cubits/shop_cubit/shop_states.dart';

import '../../shared/components/component.dart';

class UpdateScreen extends StatelessWidget {
  UpdateScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {
        if(state is ShopSuccessUpdateUserDataState){
          toast(message:state.model.message! , data: ToastStates.success);
        }
      },
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.getCubit(context);
        nameController.text = cubit.userDataModel!.data!.name!;
        emailController.text = cubit.userDataModel!.data!.email!;
        phoneController.text = cubit.userDataModel!.data!.phone!;
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key:formKey ,
              child: Column(
                children: [
                  defaultFormField(
                    controller: nameController,
                    label: 'User Name',
                    prefix: const Icon(Icons.person),
                    validate: (value){
                      if(value.isEmpty){
                        return 'name can\'t be empty';
                      }
                    },
                    type: TextInputType.name,
                  ),
                  const SizedBox(height: 10,),
                  defaultFormField(
                    controller: emailController,
                    label: 'Email Address',
                    prefix: const Icon(Icons.email),
                    validate: (value){
                      if(value.isEmpty){
                        return 'email can\'t be empty';
                      }
                    },
                    type: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 10,),
                  defaultFormField(
                    controller: phoneController,
                    label: 'Phone Number',
                    prefix: const Icon(Icons.phone),
                    validate: (value){
                      if(value.isEmpty){
                        return 'phone can\'t be empty';
                      }
                    },
                    type: TextInputType.phone,
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    width: double.infinity,
                    height: 50,
                    color: Colors.blue,
                    child: MaterialButton(
                      child: ConditionalBuilder(
                        condition: state is! ShopLoadingUpdateUserDataState,
                        builder: (context) => const Text(
                          'Update',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        fallback: (context) => const SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          cubit.updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,);
                        }
                      },
                    ),
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
