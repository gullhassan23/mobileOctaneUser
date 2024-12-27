// // import 'package:flutter/material.dart';
// // import 'package:firebase_auth/firebase_auth.dart';

// // class PhoneOTPVerification extends StatefulWidget {
// //   const PhoneOTPVerification({Key? key}) : super(key: key);

// //   @override
// //   State<PhoneOTPVerification> createState() => _PhoneOTPVerificationState();
// // }

// // class _PhoneOTPVerificationState extends State<PhoneOTPVerification> {
// //   TextEditingController phoneNumber = TextEditingController();
// //   TextEditingController otp = TextEditingController();
// //   bool visible = false;
// //   var temp;

// //   @override
// //   void dispose() {
// //     phoneNumber.dispose();
// //     otp.dispose();
// //     super.dispose();
// //   }
// // Future<void> verifyPhone() async {
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //   verificationCompleted(PhoneAuthCredential credential) async {
// //     await _auth.signInWithCredential(credential);
// //     print("TEST_LOG============verificationCompleted=========>");
// //   }

// //   verificationFailed(FirebaseAuthException e) {
// //     print("TEST_LOG========failure=============>${e.message}");
// //   }

// //   codeSent(String verificationId, int? resendToken) {
// //     print("TEST_LOG===========Code shared==========>${verificationId}");
// //   }

// //   codeAutoRetrievalTimeout(String verificationId) {
// //     print("TEST_LOG===========Time out==========>${verificationId}");
// //   }

// //   try{
// //   await FirebaseAuth.instance.verifyPhoneNumber(

// //    phoneNumber: '+92${phoneNumber.text}',

   
// //   verificationCompleted:verificationCompleted,
// //   verificationFailed: verificationFailed,
// //   codeSent:codeSent,
// //   codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
// // );}
// // catch(e){

// //     print("ERROR_LOG===========Time out==========>${e}");

// // }
// // }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Firebase Phone OTP Authentication"),
// //       ),
// //       body: SizedBox(
// //         width: MediaQuery.of(context).size.width,
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             inputTextField("Contact Number", phoneNumber, context),
// //             visible ? inputTextField("OTP", otp, context) : SizedBox(),
// //             !visible ? SendOTPButton("Send OTP") : SubmitOTPButton("Submit"),
// //              SendOTPButton("Send OTP")
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget SendOTPButton(String text) => ElevatedButton(
// //         onPressed: () async {
// //           setState(() {
// //             visible = !visible;
// //           });
// //           temp =  verifyPhone();
// //         },
// //         child: Text(text),
// //       );

// //   Widget SubmitOTPButton(String text) => ElevatedButton(
// //         onPressed: () => FirebaseAuthentication().authenticate(temp, otp.text),
// //         child: Text(text),
// //       );

// //   Widget inputTextField(String labelText,
// //           TextEditingController textEditingController, BuildContext context) =>
// //       Padding(
// //         padding: EdgeInsets.all(10.00),
// //         child: SizedBox(
// //           width: MediaQuery.of(context).size.width / 1.5,
// //           child: TextFormField(
// //             obscureText: labelText == "OTP" ? true : false,
// //             controller: textEditingController,
// //             decoration: InputDecoration(
// //               hintText: labelText,
// //               hintStyle: TextStyle(color: Colors.blue),
// //               filled: true,
// //               fillColor: Colors.blue[100],
// //               enabledBorder: OutlineInputBorder(
// //                 borderSide: BorderSide(color: Colors.transparent),
// //                 borderRadius: BorderRadius.circular(5.5),
// //               ),
// //               focusedBorder: OutlineInputBorder(
// //                 borderSide: BorderSide(color: Colors.transparent),
// //                 borderRadius: BorderRadius.circular(5.5),
// //               ),
// //             ),
// //           ),
// //         ),
// //       );
// // }

// // class FirebaseAuthentication {
// //   String phoneNumber = "";

// //   sendOTP(String phoneNumber) async {
// //     this.phoneNumber = phoneNumber;
// //     FirebaseAuth auth = FirebaseAuth.instance;
// //     ConfirmationResult result = await auth.signInWithPhoneNumber(
// //       '+92$phoneNumber',
// //     );
// //     printMessage("OTP Sent to +92 $phoneNumber");
// //     return result;
// //   }

// //   authenticate(ConfirmationResult confirmationResult, String otp) async {
// //     UserCredential userCredential = await confirmationResult.confirm(otp);
// //     userCredential.additionalUserInfo!.isNewUser
// //         ? printMessage("Authentication Successful")
// //         : printMessage("User already exists");
// //   }

// //   printMessage(String msg) {
// //     debugPrint(msg);
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';


// class PhoneOTPVerification extends StatefulWidget {
//   @override
//   _PhoneOTPVerificationState createState() => _PhoneOTPVerificationState();
// }

// class _PhoneOTPVerificationState extends State<PhoneOTPVerification> {
//   FirebaseAuth _auth = FirebaseAuth.instance;

//   String phoneNumber = '';
//   String verificationId = '';
//   String smsCode = '';

//   Future<void> signInWithPhoneNumber() async {
//     try {
//       await _auth.verifyPhoneNumber(
//         phoneNumber: phoneNumber,
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           await _auth.signInWithCredential(credential);
//           print('Verification Completed');
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           print('Verification Failed: $e');
//         },
//         codeSent: (String verificationId, int? resendToken) {
//           print('Code Sent to $phoneNumber');
//           setState(() {
//             this.verificationId = verificationId;
//           });
//         },
//         codeAutoRetrievalTimeout: (String verificationId) {
//           print('Auto Retrieval Timeout');
//         },
//       );
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   Future<void> signInWithOTP() async {
//     try {
//       PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: verificationId,
//         smsCode: smsCode,
//       );
//       await _auth.signInWithCredential(credential);
//       print('Verification Successful');
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Phone Authentication'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               decoration: InputDecoration(labelText: 'Phone Number (+1 xxx-xxx-xxxx)'),
//               onChanged: (value) {
//                 setState(() {
//                   phoneNumber = value;
//                 });
//               },
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 signInWithPhoneNumber();
//               },
//               child: Text('Send OTP'),
//             ),
//             SizedBox(height: 20),
//             TextField(
//               decoration: InputDecoration(labelText: 'Enter OTP'),
//               onChanged: (value) {
//                 setState(() {
//                   smsCode = value;
//                 });
//               },
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 signInWithOTP();
//               },
//               child: Text('Verify OTP'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
