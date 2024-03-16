import 'package:bloc/bloc.dart';
import 'package:echno_attendance/employee/bloc/employee_event.dart';
import 'package:echno_attendance/employee/bloc/employee_state.dart';
import 'package:echno_attendance/employee/domain/firestore/database_handler.dart';
import 'package:echno_attendance/employee/models/employee.dart';
import 'package:image_picker/image_picker.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final BasicEmployeeDatabaseHandler basicEmployeeDatabaseHandler;

  EmployeeBloc(this.basicEmployeeDatabaseHandler)
      : super(const EmployeeNotInitializedState()) {
    on<EmployeeInitializeEvent>((event, emit) async {
      final Employee employee =
          await basicEmployeeDatabaseHandler.currentEmployee;
      emit(EmployeeInitializedState(currentEmployee: employee));
    });
    on<EmployeeHomeEvent>((event, emit) {
      final currentEmployee = event.currentEmployee;
      emit(EmployeeHomeState(currentEmployee: currentEmployee));
    });
    on<EmployeeProfileEvent>((event, emit) async {
      final employee = event.currentEmployee;
      emit(EmployeeProfileState(currentEmployee: employee));
    });
    on<EmployeeUpdatePhotoEvent>((event, emit) async {
      final imagePicker = ImagePicker();
      final XFile? image = await imagePicker.pickImage(
          source: ImageSource.camera,
          imageQuality: 70,
          maxHeight: 512.0,
          maxWidth: 512.0);
      if (image != null && event.employeeId.isNotEmpty) {
        await basicEmployeeDatabaseHandler.uploadImage(
            imagePath: 'Profile/', employeeId: event.employeeId, image: image);
      }
      emit(state);
    });
  }
}
