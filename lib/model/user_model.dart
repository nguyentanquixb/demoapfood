import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String fullName;
  final String emailAddress;
  final String password;
  final String userUid;
  UserModel({
    required this.fullName,
    required this.emailAddress,
    required this.password,
    required this.userUid,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      fullName: doc.data().toString().contains('fullName') ? doc.get('fullName') : '',
      emailAddress: doc.data().toString().contains('emailAddress') ? doc.get('emailAddress') : '',
      password: doc.data().toString().contains('password') ? doc.get('password') : '',
      userUid: doc.data().toString().contains('userUid') ? doc.get('userUid') : '',

    );
  }
}
