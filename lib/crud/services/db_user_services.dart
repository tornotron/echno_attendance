class DBUser {
  final int id;
  final String name;
  final String email;
  final int phoneNumber;
  final String employeeID;
  final String employeeRole;
  final bool isActiveEmployee;

  const DBUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.employeeID,
    required this.employeeRole,
    required this.isActiveEmployee,
  });

  DBUser.fromRow(Map<String, Object?> map)
      : id = map[idColumn] as int,
        name = map[nameColumn] as String,
        email = map[emailColumn] as String,
        phoneNumber = map[phoneNumberColumn] as int,
        employeeID = map[employeeIdColumn] as String,
        employeeRole = map[employeeRoleColumn] as String,
        isActiveEmployee = (map[isActiveEmployeeColumn] as int) == 1;

  @override
  String toString() =>
      'Person, ID = $id, email = $email, name = $name, phoneNumber = $phoneNumber, employeeID = $employeeID, employeeRole = $employeeRole, isActiveEmployee = $isActiveEmployee,';

  @override
  bool operator ==(covariant DBUser other) => id == other.id;

  @override
  int get hashCode => id.hashCode;
}

// Database 'user' table

const idColumn = 'id';
const emailColumn = 'email';
const employeeIdColumn = 'employeeId';
const nameColumn = 'name';
const phoneNumberColumn = 'phone_number';
const employeeRoleColumn = 'employee_role';
const isActiveEmployeeColumn = 'is_active_employee';
