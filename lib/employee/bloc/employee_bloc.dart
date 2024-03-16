import 'package:bloc/bloc.dart';
import 'package:echno_attendance/employee/bloc/employee_event.dart';
import 'package:echno_attendance/employee/bloc/employee_state.dart';
import 'package:echno_attendance/employee/domain/firestore/database_handler.dart';
import 'package:echno_attendance/employee/models/employee.dart';

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
  }
}
