import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/modules/register/cubit/register_cubit.dart';
import 'package:graduation_project/modules/register/cubit/states.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:hexcolor/hexcolor.dart';

class RegisterScreen3 extends StatelessWidget {
  const RegisterScreen3({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var cubit = RegisterCubit.get(context);
    var formKey = GlobalKey<FormState>();
    bool visible1=false;

    return BlocConsumer<RegisterCubit,RegisterStates>(

      listener: (context,state){
        if(state is DoctorCreateSuccessState||state is PatientCreateSuccessState ){
          //Navigator.pushReplacementNamed(context,'login');

        }
      },
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            title:const Text(
                'Register'
            ),
          ),
          body: Container(
            constraints:const BoxConstraints.expand(),
            decoration:const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/background2.jpg'),
                    fit: BoxFit.cover)),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
                bottom: 20.0,
                top: 20.0
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      // PAGE INDICATOR //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 10,
                            width: 10,
                            decoration:const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(
                            width: 3.0,
                          ),
                          Container(
                            height: 1,
                            width: 30,
                            color: Colors.grey[300],
                          ),
                          const SizedBox(
                            width: 3.0,
                          ),
                          Container(
                            height: 10,
                            width: 10,
                            decoration:const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(
                            width: 3.0,
                          ),
                          Container(
                            height: 1,
                            width: 30,
                            color: Colors.grey[300],
                          ),
                          const SizedBox(
                            width: 3.0,
                          ),
                          Container(
                            height: 10,
                            width: 10,
                            decoration:const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'If you are doctor\n please select and fill these forms',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Colors.white,
                            fontSize:23.0
                        ),),
                      const SizedBox(
                        height: 130.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50.0)
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      title: const Text('Patient'),
                                      leading: Radio<condition>(
                                        value: condition.patient,
                                        groupValue: cubit.val,
                                        onChanged: (condition? value) {
                                          cubit.radioPatient(value);
                                        },
                                        activeColor: HexColor('4E51BF'),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListTile(
                                      title: const Text('Doctor'),
                                      leading: Radio<condition>(
                                        value: condition.doctor,
                                        groupValue: cubit.val,
                                        onChanged: (condition? value) {
                                          cubit.radioDoctor(value);
                                        },
                                        activeColor: HexColor('4E51BF'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                                controller: cubit.registrationNuController,
                                keyboardType: TextInputType.number,
                                enabled: cubit.doctor ? true : false,
                                cursorColor: HexColor('4E51BF'),
                                validator:cubit.doctor? (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your Registration number';
                                  }
                                }:null,
                                style: TextStyle(
                                    color: cubit.doctor ? Colors.black : Colors.grey[300]
                                ),
                                decoration: InputDecoration(
                                  labelText: 'Registration number',
                                  alignLabelWithHint: true,
                                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                                  floatingLabelStyle: TextStyle(
                                      color: cubit.doctor ? HexColor('4E51BF') : Colors.grey),
                                  labelStyle: TextStyle(
                                    color: cubit.doctor ? Colors.grey[400] : Colors.grey[300],
                                  ),
                                  fillColor: cubit.doctor ? Colors.grey[200] : Colors.grey[100],
                                  filled: true,
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.red,
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: HexColor('4E51BF'),
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(50.0),),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(
                                          90.0)),
                                      borderSide: BorderSide.none
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: HexColor('4E51BF'),
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  prefixIcon: Icon(Icons.credit_card,
                                    color: cubit.doctor ? HexColor('4E51BF') : Colors.grey,),

                                )),
                            const SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                                controller: cubit.universityController,
                                keyboardType: TextInputType.text,
                                enabled: cubit.doctor ? true : false,
                                cursorColor: HexColor('4E51BF'),
                                validator:cubit.doctor? (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your the university';
                                  }
                                }:null,
                                style: TextStyle(
                                    color: cubit.doctor ? Colors.black : Colors.grey[300]
                                ),
                                decoration: InputDecoration(
                                  labelText: 'University',
                                  alignLabelWithHint: true,
                                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                                  floatingLabelStyle: TextStyle(
                                      color: cubit.doctor ? HexColor('4E51BF') : Colors.grey),
                                  labelStyle: TextStyle(
                                    color: cubit.doctor ? Colors.grey[400] : Colors.grey[300],
                                  ),
                                  fillColor: cubit.doctor ? Colors.grey[200] : Colors.grey[100],
                                  filled: true,
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.red,
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: HexColor('4E51BF'),
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(50.0),),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(
                                          90.0)),
                                      borderSide: BorderSide.none
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: HexColor('4E51BF'),
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  prefixIcon: Icon(Icons.school_outlined,
                                    color: cubit.doctor ? HexColor('4E51BF') : Colors.grey,),

                                )),
                            const SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                                controller: cubit.specialtyController,
                                keyboardType: TextInputType.text,
                                enabled: cubit.doctor ? true : false,
                                cursorColor: HexColor('4E51BF'),
                                validator:cubit.doctor? (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your your specialization';
                                  }
                                }:null,
                                style: TextStyle(
                                    color: cubit.doctor ? Colors.black : Colors.grey[300]
                                ),
                                decoration: InputDecoration(
                                  labelText: 'Specialization',
                                  alignLabelWithHint: true,
                                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                                  floatingLabelStyle: TextStyle(
                                      color: cubit.doctor ? HexColor('4E51BF') : Colors.grey),
                                  labelStyle: TextStyle(
                                    color: cubit.doctor ? Colors.grey[400] : Colors.grey[300],
                                  ),
                                  fillColor: cubit.doctor ? Colors.grey[200] : Colors.grey[100],
                                  filled: true,
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.red,
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: HexColor('4E51BF'),
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(50.0),),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(
                                          90.0)),
                                      borderSide: BorderSide.none
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: HexColor('4E51BF'),
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  prefixIcon: Icon(Icons.medical_services_outlined,
                                    color: cubit.doctor ? HexColor('4E51BF') : Colors.grey,),

                                )),
                            const SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                                controller: cubit.certificateController,
                                keyboardType: TextInputType.text,
                                enabled: cubit.doctor ? true : false,
                                cursorColor: HexColor('4E51BF'),
                                validator:cubit.doctor? (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your Certificates';
                                  }
                                }:null,
                                style: TextStyle(
                                    color: cubit.doctor ? Colors.black : Colors.grey[300]
                                ),
                                decoration: InputDecoration(
                                  labelText: 'Certificates',
                                  alignLabelWithHint: true,
                                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                                  floatingLabelStyle: TextStyle(
                                      color: cubit.doctor ? HexColor('4E51BF') : Colors.grey),
                                  labelStyle: TextStyle(
                                    color: cubit.doctor ? Colors.grey[400] : Colors.grey[300],
                                  ),
                                  fillColor: cubit.doctor ? Colors.grey[200] : Colors.grey[100],
                                  filled: true,
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.red,
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: HexColor('4E51BF'),
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(50.0),),
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(
                                          90.0)),
                                      borderSide: BorderSide.none
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: HexColor('4E51BF'),
                                        width: 2.0),
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                  prefixIcon: Icon(Icons.filter_frames_outlined,
                                    color: cubit.doctor ? HexColor('4E51BF') : Colors.grey,),

                                )),
                            // const SizedBox(
                            //   height: 20.0,
                            // ),
                            // MaterialButton(onPressed: ()
                            // {
                            //   //if(cubit.flag==true) {
                            //     cubit.getProfileImage();
                            //   //}
                            //   //null;
                            // },
                            //   height: 50,
                            //   color:cubit.flag?Colors.grey[200]:Colors.grey[100],
                            //   shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(50.0),),
                            //   child: Text('Upload your personal image',
                            //     style: TextStyle(
                            //       color:HexColor('4E51BF'),
                            //         //color:cubit.flag? HexColor('4E51BF') : Colors.grey
                            //     ),),
                            // ),
                            // Visibility(
                            //     visible: cubit.visible1,
                            //     child: Container(
                            //         width: double.infinity,
                            //         child:const Text("please upload your image",
                            //             textAlign: TextAlign.left,
                            //             style: TextStyle(color: Colors.red)))
                            //   ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                     BuildCondition(
                       condition: state is! PatientRegisterLoadingState ,
                       builder: (context)=> Align(
                         alignment: Alignment.bottomRight,
                         child: defaultButton(
                           width: 100.0,
                           function: ()
                           {
                             if (formKey.currentState!.validate()&&cubit.doctor==true){
                               cubit.doctorRegister(
                                   email: cubit.emailController.text ,
                                   fullName: cubit.nameController.text,
                                   password: cubit.passwordController.text,
                                   phone: cubit.phoneController.text,
                                   gender: cubit.gender,
                                   address: cubit.addressController.text,
                                   maritalStatus: cubit.status,
                                   age: cubit.age,
                                   university: cubit.universityController.text,
                                   specialization: cubit.specialtyController.text,
                                   regisNumber: cubit.registrationNuController.text,
                                  certificates: cubit.certificateController.text
                                    );
                             }
                             if (cubit.doctor==false){
                               cubit.patientRegister(
                                   email: cubit.emailController.text ,
                                   fullName: cubit.nameController.text,
                                   password: cubit.passwordController.text,
                                   phone: cubit.phoneController.text,
                                   gender: cubit.gender,
                                   address: cubit.addressController.text,
                                   maritalStatus: cubit.status,
                                   age: cubit.age,
                               );
                             }
                           },
                           text: ('Next'),
                         ),
                       ),
                       fallback: (context) => const Center(child: CircularProgressIndicator()),
                     )
                  ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
