import 'package:flutter/material.dart';
import 'package:GamiLearn/models/topik.dart';
import 'package:GamiLearn/services/score_service.dart';
import 'package:GamiLearn/style/localColor.dart';

class ScoreBoardWidget extends StatefulWidget {
  final Topik topik;
  const ScoreBoardWidget({super.key, required this.topik});

  @override
  State<ScoreBoardWidget> createState() => _ScoreBoardWidgetState();
}

class _ScoreBoardWidgetState extends State<ScoreBoardWidget> {
  late Future<Map<String, dynamic>> _resultsFuture;
  final SkorService _skorService = SkorService();
  
  int _stars = 0;
  int _correctAnswers = 0;
  String _topicName = '';
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadResults();
  }

  Future<void> _loadResults() async {
    setState(() => _isLoading = true);
    try {
      final results = await _skorService.fetchJumlahBenarTerbaru(widget.topik.id_topik);
      if (mounted) {
        setState(() {
          _stars = results['jumlah_bintang'] as int;
          _correctAnswers = results['jumlah_benar'] as int;
          _topicName = results['nama_topik'] as String;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Gagal memuat hasil: ${e.toString()}';
          _isLoading = false;
        });
      }
    }
  }

  Widget _buildStars() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Icon(
            index < _stars ? Icons.star : Icons.star_border,
            color: index < _stars ? Colors.amber : Colors.grey,
            size: 40,
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_isLoading)
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: CircularProgressIndicator(),
          )
        else if (_errorMessage != null)
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _loadResults,
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Level Selesai!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: LocalColor.primary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  _topicName,
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                _buildStars(),
                const SizedBox(height: 24),
                Text(
                  "Jawaban Benar: $_correctAnswers",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: LocalColor.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Kembali",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}