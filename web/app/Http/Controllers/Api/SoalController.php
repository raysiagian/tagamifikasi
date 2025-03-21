<?php
namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Models\Soal;
use App\Models\Level;
use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\Controller; // Pastikan ini sudah benar
use CloudinaryLabs\CloudinaryLaravel\Facades\Cloudinary;

class SoalController extends Controller
{
    /**
     * Menampilkan semua data soal.
     */
  // Menampilkan semua soal
  public function index()
  {
      $soal = Soal::all();
      return response()->json([
          'success' => true,
          'message' => 'List semua soal',
          'data' => $soal
      ], 200);
  }

  // Menampilkan soal berdasarkan matapelajaran dan level   
  public function getByMataPelajaranAndLevel($id_mataPelajaran, $id_level)
{
    // Ambil level berdasarkan id_mataPelajaran dan id_level
    $level = Level::where('id_mataPelajaran', $id_mataPelajaran)
                  ->where('id_level', $id_level)
                  ->first();

    // Jika level tidak ditemukan, return error
    if (!$level) {
        return response()->json([
            'status' => 'error',
            'message' => 'Level tidak ditemukan untuk mata pelajaran ini'
        ], 404);
    }

    // Ambil soal berdasarkan level yang ditemukan
    $soal = Soal::where('id_level', $id_level)->get();

    // Jika tidak ada soal, return error
    if ($soal->isEmpty()) {
        return response()->json([
            'status' => 'error',
            'message' => 'Tidak ada soal untuk level ini'
        ], 404);
    }

    return response()->json([
        'status' => 'success',
        'mataPelajaran' => $level->mataPelajaran->nama_mataPelajaran,
        'level' => $level->penjelasan_level,
        'soal' => $soal
    ], 200);
}


  //

    /**
     * Menyimpan soal baru dengan media dan audio ke Cloudinary.
     */
    public function store(Request $request)
    {
        $request->validate([
            'id_level' => 'required|exists:level,id_level',
            'tipeSoal' => 'required|in:visual,auditori,kinestetik',
            'pertanyaan' => 'required|string',
            'audioPertanyaan' => 'nullable|file', // Bisa semua jenis file
            'media' => 'nullable|file', // Bisa semua jenis file
            'opsiA' => 'required|string',
            'opsiB' => 'required|string',
            'opsiC' => 'required|string',
            'opsiD' => 'required|string',
            'jawabanBenar' => 'required|in:A,B,C,D'
        ]);

        // Upload media ke Cloudinary jika ada
        $uploadedMedia = null;
        if ($request->hasFile('media')) {
            $uploadedMedia = Cloudinary::upload($request->file('media')->getRealPath(), [
                'folder' => 'soal_media',
                'resource_type' => 'auto' // Bisa gambar, video, PDF, dll.
            ])->getSecurePath();
        }

        // Upload audio ke Cloudinary jika ada
        $uploadedAudio = null;
        if ($request->hasFile('audioPertanyaan')) {
            $uploadedAudio = Cloudinary::upload($request->file('audioPertanyaan')->getRealPath(), [
                'folder' => 'soal_audio',
                'resource_type' => 'auto' // Bisa semua tipe audio
            ])->getSecurePath();
        }

        // Simpan ke database
        $soal = Soal::create([
            'id_level' => $request->id_level,
            'tipeSoal' => $request->tipeSoal,
            'pertanyaan' => $request->pertanyaan,
            'audioPertanyaan' => $uploadedAudio,
            'media' => $uploadedMedia,
            'opsiA' => $request->opsiA,
            'opsiB' => $request->opsiB,
            'opsiC' => $request->opsiC,
            'opsiD' => $request->opsiD,
            'jawabanBenar' => $request->jawabanBenar,
        ]);

        return response()->json([
            'message' => 'Soal berhasil ditambahkan!',
            'data' => $soal
        ], 201);
    }

    /**
     * Menampilkan detail soal.
     */
    public function show($id_soal)
    {
        $soal = Soal::find($id_soal);
        if (!$soal) {
            return response()->json(['message' => 'Soal tidak ditemukan'], 404);
        }
        return response()->json($soal);
    }

    /**
     * Mengupdate soal.
     */
    public function update(Request $request, $id)
{
    $soal = Soal::where('id_soal', $id)->first();
    if (!$soal) {
        return response()->json(['message' => 'Soal tidak ditemukan'], 404);
    }

    // Validasi data yang dikirim
    $request->validate([
        'id_level' => 'nullable|exists:level,id_level',
        'tipeSoal' => 'nullable|in:visual,auditori,kinestetik',
        'pertanyaan' => 'nullable|string',
        'audioPertanyaan' => 'nullable|file',
        'media' => 'nullable|file',
        'opsiA' => 'nullable|string',
        'opsiB' => 'nullable|string',
        'opsiC' => 'nullable|string',
        'opsiD' => 'nullable|string',
        'jawabanBenar' => 'nullable|in:A,B,C,D'
    ]);

    // Update media jika ada file baru diunggah
    if ($request->hasFile('media')) {
        $uploadedMedia = Cloudinary::upload($request->file('media')->getRealPath(), [
            'folder' => 'soal_media',
            'resource_type' => 'auto'
        ])->getSecurePath();
        $soal->media = $uploadedMedia;
    }

    // Update audio jika ada file baru diunggah
    if ($request->hasFile('audioPertanyaan')) {
        $uploadedAudio = Cloudinary::upload($request->file('audioPertanyaan')->getRealPath(), [
            'folder' => 'soal_audio',
            'resource_type' => 'auto'
        ])->getSecurePath();
        $soal->audioPertanyaan = $uploadedAudio;
    }

    // Update data selain file
    $soal->fill($request->except(['media', 'audioPertanyaan'])); // Kecuali file

    $soal->save(); // Simpan perubahan ke database

    return response()->json([
        'message' => 'Soal berhasil diperbarui!',
        'data' => $soal
    ]);
}


    
    /**
     * Menghapus soal.
     */
    public function destroy($id)
{
    $soal = Soal::find($id);
    if (!$soal) {
        return response()->json(['message' => 'Soal tidak ditemukan'], 404);
    }

    // Hapus media dari Cloudinary jika ada
    if ($soal->media) {
        Cloudinary::destroy($soal->media);
    }
    if ($soal->audioPertanyaan) {
        Cloudinary::destroy($soal->audioPertanyaan);
    }

    // Hapus data dari database
    $soal->delete();

    return response()->json(['message' => 'Soal berhasil dihapus']);
}

}