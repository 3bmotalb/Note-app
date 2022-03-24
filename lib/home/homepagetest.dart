import 'dart:ui';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> question = [
    'السن ؟',
    'الجنس ؟',
    'ادخل طولك و وزنك',
    'هل حدث تغيير مفاجيء في الوزن؟',
    'هل تشعر بالجفاف المستمر في الحلق؟',
    ' عدد مرات التبول ليلا؟',
    'هل تعاني من بطأ شفاء الجروح؟',
    'هل تعاني من العطش المستمر؟',
    'هل تم تشخيص إصابة أحد أفراد عائلتك بالسكري (من النوع الأول أو النوع الثاني)؟',
    'هل تعاني من امراض مزمنه ؟',
    'هل انت شخص مدخن؟',
  ];
  int questionnum = 0;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("الاختبار"),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed("addnotes");
            }),
        body: Center(
          child: Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.height,
              height: MediaQuery.of(context).size.height,
              child: questionnum < question.length - 1
                  ? Column(
                      children: [
                        Container(
                          height: 200,
                          width: 300,
                          child: Card(
                            elevation: 8,
                            shadowColor: Colors.grey,
                            margin: EdgeInsets.all(20),
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey)),
                            child: Container(
                              padding: EdgeInsets.all(5),
                              alignment: Alignment.center,
                              child: Text(
                                question[questionnum],
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RaisedButton(
                              onPressed: () {
                                if (questionnum < question.length - 1) {
                                  setState(() {
                                    questionnum += 1;
                                  });
                                }
                              },
                              child: Text("التالي"),
                              color: Colors.blue,
                            ),
                            RaisedButton(
                              onPressed: () {
                                if (questionnum > 0) {
                                  setState(() {
                                    questionnum -= 1;
                                  });
                                }
                              },
                              child: Text('السابق'),
                            )
                          ],
                        )
                      ],
                    )
                  : Column(
                      children: [
                        Text("انتهي الاختبار"),
                        RaisedButton(
                          onPressed: () {
                            setState(() {
                              questionnum = 0;
                            });
                          },
                          child: Text("اعادة الاختبار"),
                        ),
                      ],
                    )),
        ),
      ),
    );
  }
}
