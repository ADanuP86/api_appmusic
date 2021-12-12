import 'dart:convert';

class Lagu {
  String judul;
  String namapenyanyi;
  String nama_album;
  String nama_genre;

  Lagu({this.judul, this.namapenyanyi, this.nama_album, nama_genre});

  factory Lagu.fromJson(Map<String, dynamic> map) {
    return Lagu(
      judul: map["judul"], namapenyanyi: map["namapenyanyi"], nama_album: map["nama_album"], nama_genre: map["nama_genre"]);
  }

  Map<String, dynamic> toJson() {
    return {"judul": judul, "namapenyanyi": namapenyanyi, "nama_album": nama_album, "nama_genre": nama_genre};
  }
  @override
  String toString() {
    return 'Lagu{judul: $judul, namapenyanyi: $namapenyanyi, nama_album: $nama_album, nama_genre: $nama_genre}';
  }

}

List<Lagu> laguFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Lagu>.from(data.map((item) => Lagu.fromJson(item)));
}

String laguToJson(Lagu data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
