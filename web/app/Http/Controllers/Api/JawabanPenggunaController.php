<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Models\JawabanPengguna;
use App\Models\SkorPengguna;
use App\Models\RekapSkorPengguna;
use App\Models\Soal;
use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\Controller;

class JawabanPenggunaController extends Controller
{
    // public function simpanJawaban(Request $request)
    // {
    //     \Log::info('User Auth:', ['user' => Auth::user()]);
    
    //     if (!Auth::user()) {
    //         return response()->json(['message' => 'User tidak ditemukan.'], 401);
    //     }
    
    //     $user = Auth::user();
    //     $soal = Soal::find($request->id_soal);
    //     $status = ($request->jawaban_siswa === $soal->jawabanBenar) ? 'benar' : 'salah';
    
    //     $jawaban = JawabanPengguna::create([
    //         'id_user' => $user->id_user, // Pastikan pakai id_user
    //         'id_soal' => $soal->id_soal,
    //         'jawaban_siswa' => $request->jawaban_siswa,
    //         'status' => $status
    //     ]);
    
    //     return response()->json(['message' => 'Jawaban disimpan', 'data' => $jawaban], 200);
    // }
    
    // public function simpanJawaban(Request $request)
    // {
    //     \Log::info('User Auth:', ['user' => Auth::user()]);
    
    //     if (!Auth::user()) {
    //         return response()->json(['message' => 'User tidak ditemukan.'], 401);
    //     }
    
    //     $user = Auth::user();
    //     $soal = Soal::with('level.mataPelajaran')->find($request->id_soal);
    
    //     if (!$soal) {
    //         return response()->json(['message' => 'Soal tidak ditemukan.'], 404);
    //     }
    
    //     if (!$soal->level || !$soal->level->mataPelajaran) {
    //         return response()->json(['message' => 'Mata Pelajaran tidak ditemukan dalam soal.'], 404);
    //     }
    
    //     // Ambil id_mataPelajaran dari level yang terkait dengan soal
    //     $id_mataPelajaran = $soal->level->mataPelajaran->id_mataPelajaran;
    
    //     // Cek apakah jawaban benar atau salah
    //     $status = ($request->jawaban_siswa === $soal->jawabanBenar) ? 'benar' : 'salah';
    
    //     // Simpan jawaban pengguna
    //     $jawaban = JawabanPengguna::create([
    //         'id_user' => $user->id_user,
    //         'id_soal' => $soal->id_soal,
    //         'jawaban_siswa' => $request->jawaban_siswa,
    //         'status' => $status
    //     ]);
    
    //     // Cek apakah skor sudah ada untuk user, mapel, level, dan tipe soal
    //     $skor = SkorPengguna::where('id_user', $user->id_user)
    //         ->where('id_mataPelajaran', $id_mataPelajaran)
    //         ->where('id_level', $soal->id_level)
    //         ->where('tipeSoal', $soal->tipeSoal)
    //         ->first();
    
    //     if ($status === 'benar') {
    //         if ($skor) {
    //             // Update skor jika sudah ada
    //             $skor->jumlah_benar += 1;
    //             $skor->save();
    //         } else {
    //             // Buat entri baru jika belum ada
    //             SkorPengguna::create([
    //                 'id_user' => $user->id_user,
    //                 'id_mataPelajaran' => $id_mataPelajaran,
    //                 'id_level' => $soal->id_level,
    //                 'tipeSoal' => $soal->tipeSoal,
    //                 'jumlah_benar' => 1,
    //                 'created_at' => now()
    //             ]);
    //         }
    //     }
    
    //     return response()->json(['message' => 'Jawaban disimpan', 'data' => $jawaban], 200);
    // }

//     public function simpanJawaban(Request $request)
// {
//     \Log::info('User Auth:', ['user' => Auth::user()]);

//     if (!Auth::user()) {
//         return response()->json(['message' => 'User tidak ditemukan.'], 401);
//     }

//     $user = Auth::user();
//     $soal = Soal::find($request->id_soal);

//     if (!$soal) {
//         return response()->json(['message' => 'Soal tidak ditemukan.'], 404);
//     }

//     // Ambil mata pelajaran dari level soal
//     if (!$soal->level || !$soal->level->mataPelajaran) {
//         return response()->json(['message' => 'Mata Pelajaran tidak ditemukan dalam soal.'], 404);
//     }

//     $id_mataPelajaran = $soal->level->id_mataPelajaran;

//     // Tentukan status jawaban
//     $status = ($request->jawaban_siswa === $soal->jawabanBenar) ? 'benar' : 'salah';

//     // Simpan jawaban pengguna
//     $jawaban = JawabanPengguna::create([
//         'id_user' => $user->id_user, 
//         'id_soal' => $soal->id_soal,
//         'jawaban_siswa' => $request->jawaban_siswa,
//         'status' => $status
//     ]);

//     // Proses Skor
//     if ($status === 'benar') {
//         // Cari skor pengguna berdasarkan tipe soal
//         $skor = SkorPengguna::where('id_user', $user->id_user)
//             ->where('id_mataPelajaran', $id_mataPelajaran)
//             ->where('id_level', $soal->id_level)
//             ->where('tipeSoal', $soal->tipeSoal)
//             ->first();

//         if ($skor) {
//             $skor->jumlah_benar += 1;
//             $skor->save();
//         } else {
//             SkorPengguna::create([
//                 'id_user' => $user->id_user,
//                 'id_mataPelajaran' => $id_mataPelajaran,
//                 'id_level' => $soal->id_level,
//                 'tipeSoal' => $soal->tipeSoal,
//                 'jumlah_benar' => 1,
//                 'created_at' => now()
//             ]);
//         }
//     }

//     // Ambil total skor berdasarkan tipe soal
//     $totalVisual = SkorPengguna::where('id_user', $user->id_user)
//         ->where('id_mataPelajaran', $id_mataPelajaran)
//         ->where('id_level', $soal->id_level)
//         ->where('tipeSoal', 'visual')
//         ->sum('jumlah_benar');

//     $totalAuditory = SkorPengguna::where('id_user', $user->id_user)
//         ->where('id_mataPelajaran', $id_mataPelajaran)
//         ->where('id_level', $soal->id_level)
//         ->where('tipeSoal', 'auditory')
//         ->sum('jumlah_benar');

//     $totalKinestetik = SkorPengguna::where('id_user', $user->id_user)
//         ->where('id_mataPelajaran', $id_mataPelajaran)
//         ->where('id_level', $soal->id_level)
//         ->where('tipeSoal', 'kinestetik')
//         ->sum('jumlah_benar');

//     // Tentukan tipe dominan
//     $scores = [
//         'visual' => $totalVisual,
//         'auditory' => $totalAuditory,
//         'kinestetik' => $totalKinestetik
//     ];
    
//     $tipeDominan = array_search(max($scores), $scores);

//     // Cek apakah rekap sudah ada
//     $rekap = RekapSkorPengguna::where('id_user', $user->id_user)
//         ->where('id_mataPelajaran', $id_mataPelajaran)
//         ->where('id_level', $soal->id_level)
//         ->first();

//     if ($rekap) {
//         $rekap->update([
//             'total_visual' => $totalVisual,
//             'total_auditory' => $totalAuditory,
//             'total_kinestetik' => $totalKinestetik,
//             'tipe_dominan' => $tipeDominan
//         ]);
//     } else {
//         $rekap = RekapSkorPengguna::create([
//             'id_user' => $user->id_user,
//             'id_mataPelajaran' => $id_mataPelajaran,
//             'id_level' => $soal->id_level,
//             'total_visual' => $totalVisual,
//             'total_auditory' => $totalAuditory,
//             'total_kinestetik' => $totalKinestetik,
//             'tipe_dominan' => $tipeDominan
//         ]);
//     }

//     return response()->json([
//         'message' => 'Jawaban disimpan dan rekap skor diperbarui',
//         'jawaban' => $jawaban,
//         'rekap' => $rekap
//     ], 200);
// }

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
    $status = ($request->jawaban_siswa === $soal->jawabanBenar) ? 'benar' : 'salah';

    if ($jawaban) {
        // Jika sudah ada, update jawaban saja tanpa menambah skor
        $jawaban->update(['jawaban_siswa' => $request->jawaban_siswa, 'status' => $status]);
    } else {
        // Jika belum ada, buat jawaban baru
        $jawaban = JawabanPengguna::create([
            'id_user' => $user->id_user, 
            'id_soal' => $soal->id_soal,
            'jawaban_siswa' => $request->jawaban_siswa,
            'status' => $status
        ]);

        // Jika jawaban benar, update skor
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

    // Ambil total skor berdasarkan tipe soal
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

    // Tentukan tipe dominan
    $scores = [
        'visual' => $totalVisual,
        'auditory' => $totalAuditory,
        'kinestetik' => $totalKinestetik
    ];
    
    $tipeDominan = array_search(max($scores), $scores);

    // Update atau buat rekap
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


    


    private function updateSkor($userId, $levelId, $mataPelajaranId, $tipeSoal)
    {
        // Cek apakah skor pengguna sudah ada
        $skor = SkorPengguna::where('id_user', $userId)
            ->where('id_level', $levelId)
            ->where('id_mataPelajaran', $mataPelajaranId)
            ->where('tipeSoal', $tipeSoal)
            ->first();

        if ($skor) {
            // Update skor jika sudah ada
            $skor->increment('jumlah_benar');
        } else {
            // Buat entri baru jika belum ada
            SkorPengguna::create([
                'id_user' => $userId,
                'id_mataPelajaran' => $mataPelajaranId,
                'id_level' => $levelId,
                'tipeSoal' => $tipeSoal,
                'jumlah_benar' => 1
            ]);
        }
    }

    private function updateRekap($userId, $levelId, $mataPelajaranId, $tipeSoal, $status)
    {
        // Cek apakah rekap pengguna sudah ada
        $rekap = RekapSkorPengguna::where('id_user', $userId)
            ->where('id_level', $levelId)
            ->where('id_mataPelajaran', $mataPelajaranId)
            ->first();

        if (!$rekap) {
            // Buat entri baru jika belum ada
            $rekap = RekapSkorPengguna::create([
                'id_user' => $userId,
                'id_mataPelajaran' => $mataPelajaranId,
                'id_level' => $levelId,
                'total_visual' => 0,
                'total_auditory' => 0,
                'total_kinestetik' => 0,
                'tipe_dominan' => null
            ]);
        }

        // Update total berdasarkan tipe soal
        if ($status === 'benar') {
            if ($tipeSoal === 'visual') {
                $rekap->increment('total_visual');
            } elseif ($tipeSoal === 'auditory') {
                $rekap->increment('total_auditory');
            } elseif ($tipeSoal === 'kinestetik') {
                $rekap->increment('total_kinestetik');
            }
        }

        // Tentukan tipe dominan berdasarkan jumlah tertinggi
        $tipeDominan = collect([
            'visual' => $rekap->total_visual,
            'auditory' => $rekap->total_auditory,
            'kinestetik' => $rekap->total_kinestetik
        ])->sortDesc()->keys()->first();

        $rekap->update(['tipe_dominan' => $tipeDominan]);
    }
}
