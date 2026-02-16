import 'package:equatable/equatable.dart';

class MessageResponse extends Equatable {
    MessageResponse({
        required this.message,
    });

    final String? message;
    static const String messageKey = "message";
    

    MessageResponse copyWith({
        String? message,
    }) {
        return MessageResponse(
            message: message ?? this.message,
        );
    }

    factory MessageResponse.fromJson(Map<String, dynamic> json){ 
        return MessageResponse(
            message: json["message"],
        );
    }

    Map<String, dynamic> toJson() => {
        "message": message,
    };

    @override
    String toString(){
        return "$message, ";
    }

    @override
    List<Object?> get props => [
    message, ];
}
