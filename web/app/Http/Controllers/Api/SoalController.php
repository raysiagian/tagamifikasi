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

  public function getByMataPelajaranAndLevel($id_mataPelajaran, $id_level)
  {
      $level = Level::where('id_mataPelajaran', $id_mataPelajaran)
                    ->where('id_level', $id_level)
                    ->first();

      if (!$level) {
          return response()->json([
              'status' => 'error',
              'message' => 'Level tidak ditemukan untuk mata pelajaran ini'
          ], 404);
      }

      $soal = Soal::where('id_level', $id_level)->get();

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
    // Validasi input dasar
    $request->validate([
        'id_level' => 'required|exists:level,id_level',
        'tipeSoal' => 'required|in:visual1,visual2,auditori1,auditori2,kinestetik1,kinestetik2',
        'pertanyaan' => 'required|string',
        'jawabanBenar' => 'nullable|string'
    ]);

    // Fungsi reusable: jika file, upload ke Cloudinary. Jika teks, ambil langsung.
    $uploadOrText = function ($name, $folder) use ($request) {
        if ($request->hasFile($name)) {
            return Cloudinary::upload($request->file($name)->getRealPath(), [
                'folder' => $folder,
                'resource_type' => 'auto'
            ])->getSecurePath();
        } else {
            return $request->input($name); // Ambil teks jika bukan file
        }
    };

    // Proses semua kolom yang bisa teks/file
    $audioPertanyaan = $uploadOrText('audioPertanyaan', 'soal/audio');
    $media           = $uploadOrText('media', 'soal/media');

    $opsiA = $uploadOrText('opsiA', 'soal/opsi');
    $opsiB = $uploadOrText('opsiB', 'soal/opsi');
    $opsiC = $uploadOrText('opsiC', 'soal/opsi');
    $opsiD = $uploadOrText('opsiD', 'soal/opsi');

    $pasanganA = $uploadOrText('pasanganA', 'soal/pasangan');
    $pasanganB = $uploadOrText('pasanganB', 'soal/pasangan');
    $pasanganC = $uploadOrText('pasanganC', 'soal/pasangan');
    $pasanganD = $uploadOrText('pasanganD', 'soal/pasangan');

    // Simpan data ke database
    $soal = Soal::create([
        'id_level' => $request->id_level,
        'tipeSoal' => $request->tipeSoal,
        'pertanyaan' => $request->pertanyaan,
        'audioPertanyaan' => $audioPertanyaan,
        'media' => $media,
        'opsiA' => $opsiA,
        'opsiB' => $opsiB,
        'opsiC' => $opsiC,
        'opsiD' => $opsiD,
        'pasanganA' => $pasanganA,
        'pasanganB' => $pasanganB,
        'pasanganC' => $pasanganC,
        'pasanganD' => $pasanganD,
        'jawabanBenar' => $request->jawabanBenar,
    ]);

    return response()->json([
        'message' => 'Soal berhasil ditambahkan!',
        'data' => $soal
    ], 201);
}

    
     

    
public function simpanJawaban(Request $request)
    {
        \Log::info('User Auth:', ['user' => Auth::user()]);
 
        if (!Auth::user()) {
            return response()->json(['message' => 'User tidak ditemukan.'], 401);
        }
 
        $user = Auth::user();
        $soal = Soal::find($request->id_soal);
 
        if (!$soal) {
            return response()->json(['message' => 'Soal tidak ditemukan.'], 404);
        }
 
        if (!$soal->level || !$soal->level->mataPelajaran) {
            return response()->json(['message' => 'Mata Pelajaran tidak ditemukan dalam soal.'], 404);
        }
 
        $id_mataPelajaran = $soal->level->id_mataPelajaran;
 
        // Cek apakah user sudah menjawab soal ini sebelumnya
        $jawaban = JawabanPengguna::where('id_user', $user->id_user)
            ->where('id_soal', $soal->id_soal)
            ->first();
 
        // Tentukan status jawaban
        $status = 'salah'; // default
 
        if ($soal->tipeSoal === 'kinestetik') {
            $jawabanSiswa = $request->jawaban_siswa;
 
            if (
                isset($jawabanSiswa['opsiA'], $jawabanSiswa['opsiB'], $jawabanSiswa['opsiC'], $jawabanSiswa['opsiD']) &&
                $jawabanSiswa['opsiA'] === $soal->pasanganA &&
                $jawabanSiswa['opsiB'] === $soal->pasanganB &&
                $jawabanSiswa['opsiC'] === $soal->pasanganC &&
                $jawabanSiswa['opsiD'] === $soal->pasanganD
            ) {
                $status = 'benar';
            }
        } else {
            $status = ($request->jawaban_siswa === $soal->jawabanBenar) ? 'benar' : 'salah';
        }
 
        if ($jawaban) {
            $jawaban->update([
                'jawaban_siswa' => json_encode($request->jawaban_siswa),
                'status' => $status
            ]);
        } else {
            $jawaban = JawabanPengguna::create([
                'id_user' => $user->id_user,
                'id_soal' => $soal->id_soal,
                'jawaban_siswa' => json_encode($request->jawaban_siswa),
                'status' => $status
            ]);
 
            // Jika benar, update skor
            if ($status === 'benar') {
                $skor = SkorPengguna::where('id_user', $user->id_user)
                    ->where('id_mataPelajaran', $id_mataPelajaran)
                    ->where('id_level', $soal->id_level)
                    ->where('tipeSoal', $soal->tipeSoal)
                    ->first();
 
                if ($skor) {
                    $skor->jumlah_benar += 1;
                    $skor->save();
                } else {
                    SkorPengguna::create([
                        'id_user' => $user->id_user,
                        'id_mataPelajaran' => $id_mataPelajaran,
                        'id_level' => $soal->id_level,
                        'tipeSoal' => $soal->tipeSoal,
                        'jumlah_benar' => 1,
                        'created_at' => now()
                    ]);
                }
            }
        }
 
        // Hitung total skor semua tipe
        $totalVisual = SkorPengguna::where('id_user', $user->id_user)
            ->where('id_mataPelajaran', $id_mataPelajaran)
            ->where('id_level', $soal->id_level)
            ->where('tipeSoal', 'visual')
            ->sum('jumlah_benar');
 
        $totalAuditory = SkorPengguna::where('id_user', $user->id_user)
            ->where('id_mataPelajaran', $id_mataPelajaran)
            ->where('id_level', $soal->id_level)
            ->where('tipeSoal', 'auditory')
            ->sum('jumlah_benar');
 
        $totalKinestetik = SkorPengguna::where('id_user', $user->id_user)
            ->where('id_mataPelajaran', $id_mataPelajaran)
            ->where('id_level', $soal->id_level)
            ->where('tipeSoal', 'kinestetik')
            ->sum('jumlah_benar');
 
        $scores = [
            'visual' => $totalVisual,
            'auditory' => $totalAuditory,
            'kinestetik' => $totalKinestetik
        ];
 
        $tipeDominan = array_search(max($scores), $scores);
 
        // Update atau buat rekap skor
        $rekap = RekapSkorPengguna::updateOrCreate(
            [
                'id_user' => $user->id_user,
                'id_mataPelajaran' => $id_mataPelajaran,
                'id_level' => $soal->id_level
            ],
            [
                'total_visual' => $totalVisual,
                'total_auditory' => $totalAuditory,
                'total_kinestetik' => $totalKinestetik,
                'tipe_dominan' => $tipeDominan
            ]
        );
 
        return response()->json([
            'message' => 'Jawaban disimpan dan rekap skor diperbarui',
            'jawaban' => $jawaban,
            'rekap' => $rekap
        ], 200);
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
        $soal = Soal::find($id);
        if (!$soal) {
            return response()->json(['message' => 'Soal tidak ditemukan'], 404);
        }

        $request->validate([
            'id_level' => 'nullable|exists:level,id_level',
            'tipeSoal' => 'nullable|in:visual,auditori,kinestetik',
            'pertanyaan' => 'nullable|string',
            'audioPertanyaan' => 'nullable',
            'media' => 'nullable',
            'opsiA' => 'nullable',
            'opsiB' => 'nullable',
            'opsiC' => 'nullable',
            'opsiD' => 'nullable',
            'pasanganA' => 'nullable',
            'pasanganB' => 'nullable',
            'pasanganC' => 'nullable',
            'pasanganD' => 'nullable',
            'jawabanBenar' => 'nullable|string'
        ]);

        $uploadOrText = function ($inputName, $folder, $default) use ($request) {
            if ($request->hasFile($inputName)) {
                return Cloudinary::upload($request->file($inputName)->getRealPath(), [
                    'folder' => $folder,
                    'resource_type' => 'auto'
                ])->getSecurePath();
            } elseif ($request->filled($inputName)) {
                return $request->input($inputName);
            } else {
                return $default;
            }
        };

        $soal->update([
            'id_level'       => $request->input('id_level', $soal->id_level),
            'tipeSoal'       => $request->input('tipeSoal', $soal->tipeSoal),
            'pertanyaan'     => $request->input('pertanyaan', $soal->pertanyaan),
            'audioPertanyaan'=> $uploadOrText('audioPertanyaan', 'soal/audio', $soal->audioPertanyaan),
            'media'          => $uploadOrText('media', 'soal/media', $soal->media),
            'opsiA'          => $uploadOrText('opsiA', 'soal/opsi', $soal->opsiA),
            'opsiB'          => $uploadOrText('opsiB', 'soal/opsi', $soal->opsiB),
            'opsiC'          => $uploadOrText('opsiC', 'soal/opsi', $soal->opsiC),
            'opsiD'          => $uploadOrText('opsiD', 'soal/opsi', $soal->opsiD),
            'pasanganA'      => $uploadOrText('pasanganA', 'soal/pasangan', $soal->pasanganA),
            'pasanganB'      => $uploadOrText('pasanganB', 'soal/pasangan', $soal->pasanganB),
            'pasanganC'      => $uploadOrText('pasanganC', 'soal/pasangan', $soal->pasanganC),
            'pasanganD'      => $uploadOrText('pasanganD', 'soal/pasangan', $soal->pasanganD),
            'jawabanBenar'   => $request->input('jawabanBenar', $soal->jawabanBenar)
        ]);

        return response()->json([
            'message' => 'Soal berhasil diperbarui',
            'data' => $soal
        ], 200);
    }


    public function destroy($id)
    {
        $soal = Soal::find($id);
        if (!$soal) {
            return response()->json(['message' => 'Soal tidak ditemukan'], 404);
        }

        // Optional: Ambil public_id dari URL jika kamu ingin destroy dari Cloudinary
        // Cloudinary::destroy('public_id'); <-- opsional, kalau kamu simpan public_id

        $soal->delete();

        return response()->json(['message' => 'Soal berhasil dihapus']);
    }

    public function getByLevel($id_level)
    {
        $level = Level::find($id_level);

        if (!$level) {
            return response()->json([
                'status' => 'error',
                'message' => 'Level tidak ditemukan'
            ], 404);
        }

        $soal = Soal::where('id_level', $id_level)->get();

        if ($soal->isEmpty()) {
            return response()->json([
                'status' => 'error',
                'message' => 'Tidak ada soal untuk level ini'
            ], 404);
        }

        return response()->json([
            'status' => 'success',
            'level' => $level->penjelasan_level,
            'soal' => $soal
        ], 200);
    }
}