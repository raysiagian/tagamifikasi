import 'package:flutter/material.dart';
import 'package:vak_app/style/boldTextStyle.dart';
import 'package:vak_app/style/localColor.dart';

class SubjectList extends StatefulWidget {
  const SubjectList({super.key});

  @override
  State<SubjectList> createState() => _SubjectListState();
}

class _SubjectListState extends State<SubjectList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 24),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color:LocalColor.primary),
                  )
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/component/HiFi-Statistic Bahasa Indonesia Icon.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20,),
                    Text(
                      'Bahasa Indonesia',
                      style: BoldTextStyle.textTheme.bodyLarge!.copyWith(
                        color: LocalColor.primary,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color:LocalColor.primary),
                  )
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/component/HiFi-Statistic Bahasa Inggris Icon.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20,),
                    Text(
                      'Bahasa Inggris',
                      style: BoldTextStyle.textTheme.bodyLarge!.copyWith(
                        color: LocalColor.primary,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color:LocalColor.primary),
                  )
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/component/HiFi-Statistic Matematika Icon.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20,),
                    Text(
                      'Matematika',
                      style: BoldTextStyle.textTheme.bodyLarge!.copyWith(
                        color: LocalColor.primary,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color:LocalColor.primary),
                  )
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/component/HiFi-Statistic Komunikasi Icon.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20,),
                    Text(
                      'Komunikasi',
                      style: BoldTextStyle.textTheme.bodyLarge!.copyWith(
                        color: LocalColor.primary,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color:LocalColor.primary),
                  )
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/component/HiFi-Statistic Sains Icon.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20,),
                    Text(
                      'Sains',
                      style: BoldTextStyle.textTheme.bodyLarge!.copyWith(
                        color: LocalColor.primary,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}