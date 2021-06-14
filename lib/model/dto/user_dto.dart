import 'dart:convert';

UserDto userDtoFromJson(String str) => UserDto.fromJson(json.decode(str));
String userDtoResponseToJson(UserDto data) => json.encode(data.toJson());

class UserDto {
  UserDto({
    this.name,
    this.email,
    this.image,
    this.loginDate,
  });

  String? name;
  String? email;
  String? image;
  DateTime? loginDate;

  factory UserDto.fromJson(Map<String, dynamic> json) => UserDto(
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    image: json["image"] == null ? null : json["image"],
    loginDate: json["loginDate"] == null ? null : DateTime.parse(json["loginDate"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "image": image == null ? null : image,
    "loginDate": loginDate == null ? null : "${loginDate!.year.toString().padLeft(4, '0')}-${loginDate!.month.toString().padLeft(2, '0')}-${loginDate!.day.toString().padLeft(2, '0')}",
  };
}