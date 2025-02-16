String? validateUsername(String? username) {
  if (username == null || username.isEmpty) return 'الرقم الوظيفي مطلوب';

  return null;
}

String? validatePassword(String? password) {
  if (password == null || password.isEmpty) return 'كلمة المرور مطلوبة';

  return null;
}

String? validateVehiclePlateNumber1(String? vp1) {
  if (vp1 == null || vp1.isEmpty) return 'ادخل رقم المركبة';

  return null;
}

String? validateVehiclePlateNumber2(String? vp2) {
  if (vp2 == null || vp2.isEmpty) return 'ادخل رقم المركبة';

  return null;
}

String? validateTechnicianNumber(String? number) {
  if (number == null || number.isEmpty) return 'الرقم الوظيفي للفني المساعد مطلوب';

  return null;
}

String? validateTechnicianName(String? name) {
  if (name == null || name.isEmpty) return 'إسم الفني المساعد مطلوب';

  return null;
}
