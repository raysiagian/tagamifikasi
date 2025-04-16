<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Models\JawabanPengguna;
use App\Models\SkorPengguna;
use App\Models\RekapSkorPengguna;
use App\Models\Soal;
use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\DB; // tambahkan di atas jika belum


class JawabanPenggunaController extends Controller
{
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

    // Mapping tipeSoal
    $tipeSoalOriginal = strtolower($soal->tipeSoal);
    $tipeSoal = match (true) {
        str_contains($tipeSoalOriginal, 'visual') => 'visual',
        str_contains($tipeSoalOriginal, 'auditori') => 'auditori',
        str_contains($tipeSoalOriginal, 'kinestetik') => 'kinestetik',
        default => $tipeSoalOriginal,
    };

    // Cek apakah user sudah menjawab soal ini sebelumnya
    $jawaban = JawabanPengguna::where('id_user', $user->id_user)
        ->where('id_soal', $soal->id_soal)
        ->first();

    $status = ($request->jawaban_siswa === $soal->jawabanBenar) ? 'benar' : 'salah';

    if ($jawaban) {
        $jawaban->update([
            'jawaban_siswa' => $request->jawaban_siswa,
            'status' => $status
        ]);
    } else {
        $jawaban = JawabanPengguna::create([
            'id_user' => $user->id_user,
            'id_soal' => $soal->id_soal,
            'jawaban_siswa' => $request->jawaban_siswa,
            'status' => $status
        ]);
    }

    // ✅ updateSkor dipindah ke luar if else
    if ($status === 'benar') {
        $this->updateSkor($user->id_user, $soal->id_level, $id_mataPelajaran, $tipeSoal);
    }

    $this->updateRekap($user->id_user, $soal->id_level, $id_mataPelajaran, $tipeSoal, $status);

    $rekap = RekapSkorPengguna::where('id_user', $user->id_user)
        ->where('id_mataPelajaran', $id_mataPelajaran)
        ->where('id_level', $soal->id_level)
        ->first();

    return response()->json([
        'message' => 'Jawaban disimpan dan rekap skor diperbarui',
        'jawaban' => $jawaban,
        'rekap' => $rekap
    ], 200);
}

    
    private function updateSkor($userId, $levelId, $mataPelajaranId, $tipeSoal)
    {
        $skor = SkorPengguna::where('id_user', $userId)
            ->where('id_level', $levelId)
            ->where('id_mataPelajaran', $mataPelajaranId)
            ->where('tipeSoal', $tipeSoal)
            ->first();
    
        if ($skor) {
            $skor->increment('jumlah_benar');
        } else {
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
        $rekap = RekapSkorPengguna::firstOrCreate([
            'id_user' => $userId,
            'id_mataPelajaran' => $mataPelajaranId,
            'id_level' => $levelId
        ], [
            'total_visual' => 0,
            'total_auditori' => 0,
            'total_kinestetik' => 0,
            'tipe_dominan' => null
        ]);
    
        if ($status === 'benar') {
            if ($tipeSoal === 'visual') {
                $rekap->increment('total_visual');
            } elseif ($tipeSoal === 'auditori') {
                $rekap->increment('total_auditori');
            } elseif ($tipeSoal === 'kinestetik') {
                $rekap->increment('total_kinestetik');
            }
        }
    
        $tipeDominan = collect([
            'visual' => $rekap->total_visual,
            'auditori' => $rekap->total_auditori,
            'kinestetik' => $rekap->total_kinestetik
        ])->sortDesc()->keys()->first();
    
        $rekap->update(['tipe_dominan' => $tipeDominan]);
    }
    

}