import 'package:student/data/models/shift.dart';

class Student {
  Student({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.currentAddress,
    required this.permanentAddress,
    required this.email,
    required this.mobile,
    required this.image,
    required this.dob,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.classSectionId,
    required this.categoryId,
    required this.admissionNo,
    required this.rollNumber,
    required this.caste,
    required this.religion,
    required this.admissionDate,
    required this.bloodGroup,
    required this.height,
    required this.weight,
    required this.fatherId,
    required this.guardianId,
    required this.motherId,
    required this.isNewAdmission,
    required this.categoryName,
    required this.classSectionName,
    required this.mediumName,
    required this.shift,
  });

  late final int id;
  late final String email;
  late final String firstName;
  late final String lastName;
  late final String currentAddress;
  late final String permanentAddress;
  late final String mobile;
  late final String image;
  late final String dob;
  late final String status;
  late final String createdAt;
  late final String updatedAt;
  late final String userId;
  late final String classSectionId;
  late final String categoryId;
  late final String admissionNo;
  late final String rollNumber;
  late final String caste;
  late final String religion;
  late final String admissionDate;
  late final String bloodGroup;
  late final String height;
  late final String weight;
  late final String fatherId;
  late final String motherId;
  late final String guardianId;
  late final String isNewAdmission;
  late final String classSectionName;
  late final String mediumName;
  late final String categoryName;
  late final Shift? shift;

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    lastName = json['last_name'] ?? "";
    firstName = json['first_name'] ?? "";
    currentAddress = json['current_address'] ?? "";
    permanentAddress = json['permanent_address'] ?? "";
    email = json['email'] ?? "";
    mobile = json['mobile'] ?? "";
    image = json['image'] ?? "";
    dob = json['dob'] ?? "";
    status = json['status'] ?? 0;
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
    userId = json['user_id'] ?? 0;
    classSectionId = json['class_section_id'] ?? 0;
    categoryId = json['category_id'] ?? 0;
    admissionNo = json['admission_no'] ?? "";
    rollNumber = json['roll_number'] ?? 0;
    caste = json['caste'] ?? "";
    religion = json['religion'] ?? "";
    admissionDate = json['admission_date'] ?? "";
    bloodGroup = json['blood_group'] ?? "";
    height = json['height'] ?? "";
    weight = json['weight'] ?? "";
    fatherId = json['father_id'] ?? 0;
    motherId = json['mother_id'] ?? 0;
    guardianId = json['guardian_id'] ?? 0;
    isNewAdmission = json['is_new_admission'] ?? 0;
    classSectionName = json['class_section_name'] ?? "";
    mediumName = json['medium_name'] ?? "";
    categoryName = json['category_name'] ?? "";
    shift = json['shift'] == null || json['shift'].isEmpty
        ? null
        : Shift.fromJson(json['shift']);
  }

  String getFullName() {
    return "$firstName $lastName";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['last_name'] = lastName;
    data['first_name'] = firstName;
    data['current_address'] = currentAddress;
    data['permanent_address'] = permanentAddress;
    data['email'] = email;
    data['mobile'] = mobile;
    data['image'] = image;
    data['dob'] = dob;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['user_id'] = userId;
    data['class_section_id'] = classSectionId;
    data['category_id'] = categoryId;
    data['admission_no'] = admissionNo;
    data['roll_number'] = rollNumber;
    data['caste'] = caste;
    data['religion'] = religion;
    data['admission_date'] = admissionDate;
    data['blood_group'] = bloodGroup;
    data['height'] = height;
    data['weight'] = weight;
    data['father_id'] = fatherId;
    data['mother_id'] = motherId;
    data['guardian_id'] = guardianId;
    data['is_new_admission'] = isNewAdmission;
    data['class_section_name'] = classSectionName;
    data['medium_name'] = mediumName;
    data['category_name'] = categoryName;
    data['shift'] = shift == null ? null : shift!.toJson();
    return data;
  }
}
