import 'package:flutter/material.dart';
import 'package:temp_project/helpers/my_text_field.dart';
import 'package:temp_project/main.dart';
import 'package:temp_project/pages/home_page.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


final Map<String, String> validCredentials = {
    'mos@gmail.com': '12345678',
   
    'user@example.com': 'password123',
  };

  void _login() {
   
    String inputId = _idController.text;
    String inputPassword = _passwordController.text;

    if(inputId==""&& inputPassword==""){
      setState(() {
   ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('กรุณากรอกข้อมูล ID และ Password กรุณาลองใหม่อีกครั้ง'))
    );
  });
     showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('เกิดข้อผิดพลาด'),
          content: Text('กรุณากรอกข้อมูล ID และ Password กรุณาลองใหม่อีกครั้ง'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // ปิด dialog
              child: Text('ตกลง'),
            ),
          ],
        ),
      );
     }
    else if(inputId==""){
      setState(() {
        _passwordController.clear();
   ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('กรุณากรอกข้อมูล ID กรุณาลองใหม่อีกครั้ง'))
    );
  });
     showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('เกิดข้อผิดพลาด'),
          content: Text('กรุณากรอกข้อมูล ID กรุณาลองใหม่อีกครั้ง'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // ปิด dialog
              child: Text('ตกลง'),
            ),
          ],
        ),
      );
    } 
     else if(inputPassword==""){
      setState(() {
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('กรุณากรอกข้อมูล Password กรุณาลองใหม่อีกครั้ง'))
    );
  });
     showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('เกิดข้อผิดพลาด'),
          content: Text('กรุณากรอกข้อมูล Password กรุณาลองใหม่อีกครั้ง'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // ปิด dialog
              child: Text('ตกลง'),
            ),
          ],
        ),
      );
    } 
else if (validCredentials.containsKey(inputId) && validCredentials[inputId] == inputPassword) {
      // ถ้าตรง นำทางไปยัง HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home_page()),
      );
    } else if(validCredentials.containsKey(inputId)==false) {
        setState(() {
    _idController.clear();
    _passwordController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('ไม่มี Id นี้ในระบบ กรุณาลองใหม่อีกครั้ง'))
    );
  });
      // ถ้าไม่ตรง แสดง dialog แจ้งเตือน
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('เกิดข้อผิดพลาด'),
          content: Text('ไม่มี Id นี้ในระบบ กรุณาลองใหม่อีกครั้ง'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // ปิด dialog
              child: Text('ตกลง'),
            ),
          ],
        ),
      );
    }
    else {
       setState(() {
    
    _passwordController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Password ไม่ถูกต้อง กรุณาลองใหม่อีกครั้ง'))
    );
  });
      // ถ้าไม่ตรง แสดง dialog แจ้งเตือน
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('เกิดข้อผิดพลาด'),
          content: Text('Password ไม่ถูกต้อง กรุณาลองใหม่อีกครั้ง'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // ปิด dialog
              child: Text('ตกลง'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text('ล็อกอิน'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Icon(Icons.security, size: 100),
            SizedBox(height: 50),
            Text('ID', style: TextStyle(fontSize: 20)),
            MyTextField(controller: _idController, keyboardType: TextInputType.emailAddress, hintText: 'Enter ID'),
            Text('password', style: TextStyle(fontSize: 20)),
            MyTextField(controller: _passwordController, keyboardType: TextInputType.visiblePassword, hintText: 'Enter password', obscureText: true),
            SizedBox(height: 20,),
            ElevatedButton(
             
              child: Text('Login'),
              onPressed: _login,
            ),
          ],
        ),
      ),
    );
  }
}