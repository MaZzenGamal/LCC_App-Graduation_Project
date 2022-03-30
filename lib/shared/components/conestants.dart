// https://newsapi.org/v2/everything?q=tesla&apiKey=65f7f556ec76449fa7dc7c0069f040ca
//https://newsapi.org/v2/everything?q=s&from=2021-07-25&sortBy=publishedAt&apiKey=900e3e7bff394f4081716b0c83b5fde6
//https://newsapi.org/v2/everything?q=v&apiKey=900e3e7bff394f4081716b0c83b5fde6



import 'package:graduation_project/modules/login/login_screen.dart';
import 'package:graduation_project/shared/components/components.dart';
import 'package:graduation_project/shared/network/local/cash_helper.dart';

// void signOut(context)
// {
//   CacheHelper.removeDate(
//       key: 'token',
//   ).then((value) {
//     if(value)
//       {
//         navigateAndFinish(context,LoginScreen());
//       }
//   });
// }



void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = '';

String uId   = '';