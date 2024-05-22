class User {
  final int id;
  final String nama;
  final String noTelp;
  final String tanggalLahir;
  final int point;

  User({
    required this.id,
    required this.nama,
    required this.noTelp,
    required this.tanggalLahir,
    required this.point
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nama: json['nama'],
      noTelp: json['no_telp'],
      tanggalLahir: json['tanggal_lahir'],
      point: json['point']
    );
  }
}
