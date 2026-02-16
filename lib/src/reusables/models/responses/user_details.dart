import 'package:equatable/equatable.dart';
import 'package:wallet/src/reusables/models/user.dart';

class UserDetails extends Equatable {
  const UserDetails({required this.user});

  final User? user;
  static const String userKey = "user";

  UserDetails copyWith({User? user}) {
    return UserDetails(user: user ?? this.user);
  }

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {"user": user?.toJson()};

  @override
  String toString() {
    return "$user, ";
  }

  @override
  List<Object?> get props => [user];
}
