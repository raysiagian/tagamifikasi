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
    public function simpanJawaban(Request $request)
    {
        \Log::info('User Auth:', ['user' => Auth::user()]);

        if (!Auth::user()) {
            return response()->json(['message' => 'User tidak ditemukan.'], 401);
        }

        $user = Auth::user();
        $soal = Soal::with('level.mataPelajaran')->find($request->id_soal);

        if (!$soal || !$soal->level || !$soal->level->mataPelajaran) {
            return response()->json(['message' => 'Data soal atau mata pelajaran tidak valid.'], 404);
        }

        $id_mataPelajaran = $soal->level->id_mataPelajaran;

        // Cek apakah user sudah menjawab soal ini sebelumnya
        $jawaban = JawabanPengguna::where('id_user', $user->id_user)
            ->where('id_soal', $soal->id_soal)
            ->first();

        // Konversi jawaban siswa menjadi JSON string jika perlu
        $jawabanSiswa = is_array($request->jawaban_siswa)
            ? json_encode($request->jawaban_siswa)
            : $request->jawaban_siswa;

        // Cek status jawaban
        $decodedJawabanSiswa = json_decode($jawabanSiswa, true);
        $decodedJawabanBenar = json_decode($soal->jawabanBenar, true);

        if (is_array($decodedJawabanSiswa) && is_array($decodedJawabanBenar)) {
            ksort($decodedJawabanSiswa);
            ksort($decodedJawabanBenar);
            $status = ($decodedJawabanSiswa == $decodedJawabanBenar) ? 'benar' : 'salah';
        } else {
            $status = ($jawabanSiswa === $soal->jawabanBenar) ? 'benar' : 'salah';
        }

        // Cek apakah jawaban sebelumnya sudah benar
        $jawabanSudahBenar = $jawaban && $jawaban->status === 'benar';

        // Simpan atau update jawaban
        if ($jawaban) {
            $jawaban->update([
                'jawaban_siswa' => $jawabanSiswa,
                'status' => $status
            ]);
        } else {
            $jawaban = JawabanPengguna::create([
                'id_user' => $user->id_user,
                'id_soal' => $soal->id_soal,
                'jawaban_siswa' => $jawabanSiswa,
                'status' => $status
            ]);
        }

        // Ambil tipe dasar: kinestetik1 → kinestetik
        $tipeDasar = $this->getTipeDasar($soal->tipeSoal);

        if (!$tipeDasar) {
            return response()->json(['message' => 'Tipe soal tidak dikenali.'], 400);
        }

        // Tambah skor jika benar dan belum pernah benar
        if ($status === 'benar' && !$jawabanSudahBenar) {
            $this->updateSkor($user->id_user, $soal->id_level, $id_mataPelajaran, $tipeDasar);
            $this->updateRekap($user->id_user, $soal->id_level, $id_mataPelajaran, $tipeDasar, $status);
        }

        // Ambil skor terbaru
        $skorBaru = SkorPengguna::where('id_user', $user->id_user)
            ->where('id_level', $soal->id_level)
            ->where('id_mataPelajaran', $id_mataPelajaran)
            ->where('tipeSoal', $tipeDasar)
            ->first();

        return response()->json([
            'message' => 'Jawaban disimpan dan skor diperbarui.',
            'jawaban' => $jawaban,
            'skor' => $skorBaru
        ], 200);
    }

    private function updateSkor($userId, $mataPelajaranId, $levelId, $tipeSoal)
    {
        $tipeDasar = $this->getTipeDasar($tipeSoal);
    
        $existingSkor = SkorPengguna::where('id_user', $userId)
            ->where('id_mataPelajaran', $mataPelajaranId)
            ->where('id_level', $levelId)
            ->where('tipeSoal', $tipeDasar)
            ->first();
    
        if ($existingSkor) {
            $existingSkor->increment('skor');
        } else {
            SkorPengguna::create([
                'id_user' => $userId,
                'id_mataPelajaran' => $mataPelajaranId,
                'id_level' => $levelId,
                'tipeSoal' => $tipeDasar,
                'skor' => 1
            ]);
        }
    
        $this->updateRekapSkor($userId, $mataPelajaranId, $levelId);
    }
    
    private function updateRekapSkor($userId, $mataPelajaranId, $levelId)
    {
        $skorPerTipe = SkorPengguna::where('id_user', $userId)
            ->where('id_mataPelajaran', $mataPelajaranId)
            ->where('id_level', $levelId)
            ->select('tipeSoal', DB::raw('SUM(skor) as total_skor'))
            ->groupBy('tipeSoal')
            ->get();
    
        $tipeDominan = null;
        $skorMax = 0;
    
        foreach ($skorPerTipe as $skor) {
            if ($skor->total_skor > $skorMax) {
                $tipeDominan = $skor->tipeSoal;
                $skorMax = $skor->total_skor;
            }
        }
    
        RekapSkorPengguna::updateOrCreate(
            [
                'id_user' => $userId,
                'id_mataPelajaran' => $mataPelajaranId,
                'id_level' => $levelId,
            ],
            [
                'tipe_dominan' => $tipeDominan,
                'total_skor' => $skorMax,
            ]
        );
    }
    
    private function getTipeDasar($tipe)
    {
        if (str_starts_with($tipe, 'visual')) {
            return 'visual';
        } elseif (str_starts_with($tipe, 'auditori')) {
            return 'auditori';
        } elseif (str_starts_with($tipe, 'kinestetik')) {
            return 'kinestetik';
        }
        return $tipe; // fallback
    }
    

}

