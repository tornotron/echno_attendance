import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:echno_attendance/domain/usecases/hr_manager_usecase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MockFirestore extends Mock implements FirebaseFirestore {}

void main() {
  group('HrClass', () {
    test('createUser should add user to Firestore', () async {
      final mockFirestore = MockFirestore();
      final hrClass = HrClass(firestore: mockFirestore);

      final userId = 'testUserId';
      final name = 'John Doe';
      final email = 'john.doe@example.com';
      final phoneNumber = '123-456-7890';
      final userRole = 'Employee';
      final isActiveUser = true;

      when(() => mockFirestore.collection('users').doc(userId).set(any()))
          .thenAnswer((_) async {
        print("creation succesful");
      });

      await hrClass.createUser(
        userId: userId,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        userRole: userRole,
        isActiveUser: isActiveUser,
      );
    });

    test('updateUser should update the details of an user in Firestore',
        () async {
      final mockFirestore = MockFirestore();
      final hrClass = HrClass(firestore: mockFirestore);

      final userId = 'testUserId';
      final updateData = <String, dynamic>{
        'employee-role': 'Product Manager',
        'employee-status': 'active',
      };

      when(() =>
              mockFirestore.collection('users').doc(userId).update(updateData))
          .thenAnswer((_) async {
        print("updation succesful");
      });
    });
  });
}
