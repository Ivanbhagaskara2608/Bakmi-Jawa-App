class ApiResponse<T> {
  final bool status;
  final String message;
  final T data;

  ApiResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(dynamic json) fromJsonData) {
    return ApiResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: fromJsonData(json['data']),
    );
  }
}
