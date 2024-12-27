import 'package:cloud_firestore/cloud_firestore.dart';

final firestore = FirebaseFirestore.instance;

///
final customersRef = firestore.collection('Customer');
final cardRef = firestore.collection('Card');
final vehicleRef = firestore.collection('Vehicle');
final fuelRef = firestore.collection('Fuels');
final fuelTransaction = firestore.collection('FuelsTransactions');
final PrivacyPolicyRef = firestore.collection('Privacypolicy');
final TandCRef = firestore.collection('Termandcondition');
final FAQRef = firestore.collection('Faq');
final notificationRef = firestore.collection('Notification');







final quizRef = firestore.collection('Quiz');
final avatarRef = firestore.collection('Avatar');




