class Menu {
  final int id;
  final String nama;
  final String deskripsi;
  final int harga;
  final String gambar;
  final String kategori;
  final String status;

  Menu({
    required this.id,
    required this.nama,
    required this.deskripsi,
    required this.harga,
    required this.gambar,
    required this.kategori,
    required this.status,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['id'],
      nama: json['nama'],
      deskripsi: json['deskripsi'],
      harga: json['harga'],
      gambar: json['gambar'],
      kategori: json['kategori'],
      status: json['status'],
    );
  }
}
