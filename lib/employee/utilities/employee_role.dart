enum EmployeeRole {
  hr,
  pm,
  se,
  sp,
  tc,
  emp,
}

EmployeeRole getEmployeeRole(String role) {
  switch (role) {
    case 'hr':
      return EmployeeRole.hr;
    case 'pm':
      return EmployeeRole.pm;
    case 'se':
      return EmployeeRole.se;
    case 'sp':
      return EmployeeRole.sp;
    case 'tc':
      return EmployeeRole.tc;
    case 'emp':
      return EmployeeRole.emp;
    default:
      throw Exception('Invalid employee role');
  }
}

String getEmloyeeRoleName(EmployeeRole? role) {
  switch (role) {
    case EmployeeRole.hr:
      return 'HR Manager';
    case EmployeeRole.pm:
      return 'Project Manager';
    case EmployeeRole.se:
      return 'Site Engineer';
    case EmployeeRole.sp:
      return 'Supervisor';
    case EmployeeRole.tc:
      return 'Technical Co-ordinator';
    case EmployeeRole.emp:
      return 'Employee';
    default:
      throw Exception('Invalid employee role');
  }
}
