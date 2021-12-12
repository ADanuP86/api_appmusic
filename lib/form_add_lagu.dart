import 'package:flutter/material.dart';
import 'package:api_appmusic/model/lagu.dart';
import 'package:api_appmusic/api_service.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class FormAddLagu extends StatefulWidget {
  @override
  _FormAddLaguState createState() => _FormAddLaguState();
}

class _FormAddLaguState extends State<FormAddLagu> {
  bool _isLoading = false;
  ApiService _apiService = ApiService();
  bool _isFieldjudulValid;
  bool _isFieldnamapenyanyiValid;
  bool _isFieldnama_albumValid;
  bool _isFieldnama_genreValid;
  TextEditingController _controllerjudul = TextEditingController();
  TextEditingController _controllernamapenyanyi = TextEditingController();
  TextEditingController _controllernama_album = TextEditingController();
  TextEditingController _controllernama_genre = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Form Add",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextFieldjudul(),
                _buildTextFieldnamapenyanyi(),
                _buildTextFieldnama_album(),
                _buildTextFieldnama_genre(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_isFieldjudulValid == null ||
                          _isFieldnamapenyanyiValid == null ||
                          _isFieldnama_albumValid == null ||
                          _isFieldnama_genreValid == null ||
                          !_isFieldjudulValid ||
                          !_isFieldnamapenyanyiValid ||
                          !_isFieldnama_albumValid ||
                          !_isFieldnama_genreValid) {
                        _scaffoldState.currentState.showSnackBar(
                          SnackBar(
                            content: Text("Please fill all field"),
                          ),
                        );
                        return;
                      }
                      setState(() => _isLoading = true);
                      String judul = _controllerjudul.text.toString();
                      String namapenyanyi = _controllernamapenyanyi.text.toString();
                      String nama_album = _controllernama_album.text.toString();
                      String nama_genre = _controllernama_genre.text.toString();
                      Lagu lagu = Lagu(judul: judul, namapenyanyi: namapenyanyi, nama_album: nama_album, nama_genre: nama_genre);
                      _apiService.createLagu(lagu).then((isSuccess) {
                        setState(() => _isLoading = false);
                        if (isSuccess) {
                          Navigator.pop(_scaffoldState.currentState.context);
                        } else {
                          _scaffoldState.currentState.showSnackBar(SnackBar(
                            content: Text("Submit data failed"),
                          ));
                        }
                      });
                    },
                    child: Text(
                      "Submit".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.orange[600],
                  ),
                )
              ],
            ),
          ),
          _isLoading
              ? Stack(
                  children: <Widget>[
                    Opacity(
                      opacity: 0.3,
                      child: ModalBarrier(
                        dismissible: false,
                        color: Colors.grey,
                      ),
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildTextFieldjudul() {
    return TextField(
      controller: _controllerjudul,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Full judul",
        errorText: _isFieldjudulValid == null || _isFieldjudulValid
            ? null
            : "Full judul is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldjudulValid) {
          setState(() => _isFieldjudulValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldnamapenyanyi() {
    return TextField(
      controller: _controllernamapenyanyi,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "namapenyanyi",
        errorText: _isFieldnamapenyanyiValid == null || _isFieldnamapenyanyiValid
            ? null
            : "namapenyanyi is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldnamapenyanyiValid) {
          setState(() => _isFieldnamapenyanyiValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldnama_album() {
    return TextField(
      controller: _controllernama_album,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "nama_album",
        errorText: _isFieldnama_albumValid == null || _isFieldnama_albumValid
            ? null
            : "nama_album is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldnama_albumValid) {
          setState(() => _isFieldnama_albumValid = isFieldValid);
        }
      },
    );
  }

Widget _buildTextFieldnama_genre() {
    return TextField(
      controller: _controllernama_genre,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "nama_genre",
        errorText: _isFieldnama_genreValid == null || _isFieldnama_genreValid
            ? null
            : "nama_genre is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldnama_genreValid) {
          setState(() => _isFieldnama_genreValid = isFieldValid);
        }
      },
    );
  }
}
