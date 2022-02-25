import 'package:flutter/material.dart';
class MotivationScreen extends StatelessWidget{
  const MotivationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return  Scaffold(
            appBar: AppBar(
              title:const Text(
                  'Your life is your story'
              ),
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Padding(
                            padding:  EdgeInsets.all(8.0),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                    'Remaining hopeful during cancer treatment is as much an art as it is a skill.'
                                )
                              ],
                            )
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Padding(
                            padding:  EdgeInsets.all(8.0),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                    '“Cancer is just a chapter in our lives and not the whole story.”  — Allie Moreno'
                                )
                              ],
                            )
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Padding(
                            padding:  EdgeInsets.all(8.0),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                    '“Every day you wake up is another opportunity to be a blessing to someone else.”  — Jacqueline Wallace'
                                )
                              ],
                            )
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Padding(
                            padding:  EdgeInsets.all(8.0),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                    '“Life becomes more purposeful when you’re doing something good.”  — Brendan Locke'
                                )
                              ],
                            )
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Padding(
                            padding:  EdgeInsets.all(8.0),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                    '“Giving in to the darkness offers no benefit.”  — Marivel Preciado'
                                )
                              ],
                            )
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Padding(
                            padding:  EdgeInsets.all(8.0),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                    '“Cancer is a part of our life, but it’s not our whole life.”  — Nick Prochak'
                                )
                              ],
                            )
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Padding(
                            padding:  EdgeInsets.all(8.0),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                    '“You can do anything you set your mind to.”  — Layne Compston'
                                )
                              ],
                            )
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Padding(
                            padding:  EdgeInsets.all(8.0),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                    '“There’s almost always something to smile about.”  — Aaliyah Parker'
                                )
                              ],
                            )
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Padding(
                            padding:  EdgeInsets.all(8.0),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                    '“When cancer happens, you don’t put life on hold. You live now.”  — Fabi Powell'
                                )
                              ],
                            )
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Padding(
                            padding:  EdgeInsets.all(8.0),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                    'Never give up. Never give in. Never, ever, ever give up.'
                                )
                              ],
                            )
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Padding(
                            padding:  EdgeInsets.all(8.0),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                    'Remember how far you\'ve come, not just how far you have to go. You may not be where you want to be, but neither are you where you used to be.'
                                )
                              ],
                            )
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Padding(
                            padding:  EdgeInsets.all(8.0),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                    'It can be easy to get caught up in how far you have to go. Don\'t forget to look back, and recognize how far you have come. Every day brings you one step closer'
                                )
                              ],
                            )
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Padding(
                            padding:  EdgeInsets.all(8.0),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                    'You are braver than you believe, stronger than you seem, smarter than you think, and twice as beautiful as you\'d ever imagined.Don\'t let cancer cause you to sell yourself short or forget your worth.'
                                )
                              ],
                            )
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Padding(
                            padding:  EdgeInsets.all(8.0),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                    'When you have exhausted all possibilities, remember this: You haven\'t. —Thomas Edison. Keep searching for what you\'re looking for. You will find it.'
                                )
                              ],
                            )
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Padding(
                            padding:  EdgeInsets.all(8.0),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                    'Your life is your story. Write well. Edit Often. You can\'t control what happens to you, but you can control the way that you handle it.What do you want your story to say?'
                                )
                              ],
                            )
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Padding(
                            padding:  EdgeInsets.all(8.0),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                    'Be thankful for this day. You are here, breathing and living life. Even if it\'s not the life you want or hoped for, it\'s life.There\'s always something to be thankful for.'
                                )
                              ],
                            )
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Padding(
                            padding:  EdgeInsets.all(8.0),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                    'Small steps every day. Every small step counts. You might not reach your goal today but that is okay.'
                                )
                              ],
                            )
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Padding(
                            padding:  EdgeInsets.all(8.0),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                    'Never be ashamed of a scar. It simply means you were stronger than whatever tried to hurt you. Everyone has scars—whether you can see them or not.Wear yours with pride.'
                                )
                              ],
                            )
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Padding(
                            padding:  EdgeInsets.all(8.0),
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                    'Never be ashamed of a scar. It simply means you were stronger than whatever tried to hurt you. Everyone has scars—whether you can see them or not.Wear yours with pride.'
                                )
                              ],
                            )
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}