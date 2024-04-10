import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';



class Home_page extends StatefulWidget {
  const Home_page({super.key});

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  List? _databaes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ประธานาธิบดีสหรัฐอเมริกา'),centerTitle: true,
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              var dio = Dio(BaseOptions(responseType: ResponseType.plain));
              var api =
                  await dio.get('https://api.sampleapis.com/presidents/presidents');

              setState(() {
                _databaes = jsonDecode(api.data.toString());
              });

              print(_databaes);
            },
            child: Text('แสดงข้อมูลประธานาธิบดีสหรัฐอเมริกา'),
          ),
          Expanded(
            child: _databaes == null
                ? SizedBox.shrink()
                : ListView.builder(
                    itemCount: _databaes!.length,
                    itemBuilder: (context, index) {
                      var dataa = _databaes![index];

                      return ListTile(
                        title: Text('ปีคริสต์ศักราช : '+dataa['yearsInOffice'],style: TextStyle(fontSize: 20)),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("ประธานาธิบดีสหรัฐอเมริกา"),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Image.network(
                                          dataa['photo'],
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Icon(Icons.error,
                                                color: Colors.black);
                                          },
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                        'ชื่อ: ${dataa['name']}',textAlign: TextAlign.center,style: TextStyle(fontSize: 20),),
                                    SizedBox(height: 10),
                                    Text(
                                        'รับตำแหน่งคนที่: ${dataa['ordinal']}',textAlign: TextAlign.center,style: TextStyle(fontSize: 20)),
                                    SizedBox(height: 10),
                                     Text(
                                        'ช่วงดำรงสมัยปี: ${dataa['yearsInOffice']}',textAlign: TextAlign.center,style: TextStyle(fontSize: 20)),
                                        SizedBox(height: 10),
                                    Text(
                                      'รองประธานประธานาธิบดี:',style: TextStyle(fontSize: 20)
                                      
                                    ),
                                    SizedBox(height: 5),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: dataa['vicePresidents']
                                          .map<Widget>((ingredient) =>
                                              Text('- $ingredient',style: TextStyle(fontSize: 20)))
                                          .toList(),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('ปิด'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}