import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/layouts/app_layout/app_cubit.dart';
import 'package:graduation_project/layouts/app_layout/states.dart';
import '../../layouts/app_layout/app_layout.dart';
import '../../shared/components/components.dart';
import '../reservation_screen/doctors.dart';
class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
    listener: (context, state) {},
    builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor:Colors.grey ,
            leading:  BackButton(
              color: Colors.black,
              onPressed:(){
                AppCubit.get(context).currentIndex=2;
                AppCubit.get(context).searchController.clear();
                navigateAndFinish(context, const AppLayout());
              },
            ),
          // The search area here
            title: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: TextField(
                    controller:AppCubit.get(context).searchController,
                  decoration: InputDecoration(
                      prefixIcon:  InkWell(
                          onTap: ()
                          async {
                           await AppCubit.get(context).existSpecialization();
                           if(AppCubit.get(context).searchController.text.isEmpty)
                             {
                               showToast(text: 'please enter valid Specialization', state: ToastStates.ERROR);
                             }
                           else if(AppCubit.get(context).searchController.text.isNotEmpty&&AppCubit.get(context).specializationExist)
                           {
                             navigateTo(context,const DoctorsScreen());
                             //showToast(text: 'please enter valid Specialization', state: ToastStates.ERROR);
                           }
                           else
                             {
                               showToast(text: 'this Specialization is not available now please enter another one or try later ', state: ToastStates.ERROR);
                             }

                           //showToast(text: 'specialization is ${AppCubit.get(context).specializationExist} and value is ${AppCubit.get(context).searchController.text}', state: ToastStates.SUCCESS);
                          } ,
                          child: const Icon(Icons.search)),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          AppCubit.get(context).searchController.clear();
                          /* Clear the search field */
                        },
                      ),
                      hintText: 'Search...',
                      border: InputBorder.none),
                ),
              ),
            )),
      );
    }
    );
    }
  }
/*class SearchScreen extends SearchDelegate {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AppCubit.get(context).getUsers(),
        builder: (context, _) {
          AppCubit.get(context).doctors;
          return BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
                appBar:AppBar(
                  actions: [],
                ) ,
              );
            },
          );
        }
    );
  }
  @override
  List<Widget>? buildActions(BuildContext context)=>[IconButton(
    icon:const Icon(Icons.clear),
    onPressed: () {
      if(query.isEmpty){
        close(context,null);        //close searchbar
      }
      else {
        query = '';
      }      //empty searcbar
    },
  ),
];

  @override
  Widget? buildLeading(BuildContext context)=>IconButton(
      icon:const Icon(Icons.arrow_back),
    onPressed: () {
        close(context,null);             //close searchbar
    },
  );

  @override
  Widget buildResults(BuildContext context) {
    return Text(
      query
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String>suggestions=[
      "Lung Cancer",
      "Colon Cancer"
    ];
    return ListView.separated(
        itemBuilder: (context, index){
          final suggestion=suggestions[index];
          return ListTile(
            title:Text(suggestion),
            onTap:(){
              query=suggestion;
              showResults(context);
            },

          );
        },
        separatorBuilder: (context, index) => Container(),
        itemCount: AppCubit.get(context).doctors.length);
  }
}*/