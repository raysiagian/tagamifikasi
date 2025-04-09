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

        // Konversi jawaban siswa menjadi string JSON jika berupa array
        $jawabanSiswa = is_array($request->jawaban_siswa)
            ? json_encode($request->jawaban_siswa)
            : $request->jawaban_siswa;

        // Validasi jawaban benar (untuk soal kinestetik gunakan json)
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

        // Tambahkan skor jika jawaban benar dan sebelumnya belum benar
        if ($status === 'benar' && !$jawabanSudahBenar) {
            $this->updateSkor($user->id_user, $soal->id_level, $id_mataPelajaran, $soal->tipeSoal);
            $this->updateRekap($user->id_user, $soal->id_level, $id_mataPelajaran, $soal->tipeSoal, $status);
        }

        // Ambil total jumlah benar berdasarkan tipe soal
        $totalVisual = SkorPengguna::where('id_user', $user->id_user)
            ->where('id_mataPelajaran', $id_mataPelajaran)
            ->where('id_level', $soal->id_level)
            ->where('tipeSoal', 'visual')
            ->sum('jumlah_benar');

        $totalAuditori = SkorPengguna::where('id_user', $user->id_user)
            ->where('id_mataPelajaran', $id_mataPelajaran)
            ->where('id_level', $soal->id_level)
            ->where('tipeSoal', 'auditori')
            ->sum('jumlah_benar');

        $totalKinestetik = SkorPengguna::where('id_user', $user->id_user)
            ->where('id_mataPelajaran', $id_mataPelajaran)
            ->where('id_level', $soal->id_level)
            ->where('tipeSoal', 'kinestetik')
            ->sum('jumlah_benar');

        // Tentukan tipe dominan
        $scores = [
            'visual' => $totalVisual,
            'auditori' => $totalAuditori,
            'kinestetik' => $totalKinestetik
        ];
        $tipeDominan = array_search(max($scores), $scores);

        // Simpan atau update rekap skor
        $rekap = RekapSkorPengguna::where('id_user', $user->id_user)
            ->where('id_mataPelajaran', $id_mataPelajaran)
            ->where('id_level', $soal->id_level)
            ->first();

        if ($rekap) {
            $rekap->update([
                'total_visual' => $totalVisual,
                'total_auditori' => $totalAuditori,
                'total_kinestetik' => $totalKinestetik,
                'tipe_dominan' => $tipeDominan
            ]);
        } else {
            $rekap = RekapSkorPengguna::create([
                'id_user' => $user->id_user,
                'id_mataPelajaran' => $id_mataPelajaran,
                'id_level' => $soal->id_level,
                'total_visual' => $totalVisual,
                'total_auditori' => $totalAuditori,
                'total_kinestetik' => $totalKinestetik,
                'tipe_dominan' => $tipeDominan
            ]);
        }

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
        $rekap = RekapSkorPengguna::where('id_user', $userId)
            ->where('id_level', $levelId)
            ->where('id_mataPelajaran', $mataPelajaranId)
            ->first();

        if (!$rekap) {
            $rekap = RekapSkorPengguna::create([
                'id_user' => $userId,
                'id_mataPelajaran' => $mataPelajaranId,
                'id_level' => $levelId,
                'total_visual' => 0,
                'total_auditori' => 0,
                'total_kinestetik' => 0,
                'tipe_dominan' => null
            ]);
        }

        if ($status === 'benar') {
            if ($tipeSoal === 'visual') {
                $rekap->increment('total_visual');
            } elseif ($tipeSoal === 'auditori') {
                $rekap->increment('total_auditori');
            } elseif ($tipeSoal === 'kinestetik') {
                $rekap->increment('total_kinestetik');
            }
        }

        // Hitung ulang dominan
        $tipeDominan = collect([
            'visual' => $rekap->total_visual,
            'auditori' => $rekap->total_auditori,
            'kinestetik' => $rekap->total_kinestetik
        ])->sortDesc()->keys()->first();

        $rekap->update(['tipe_dominan' => $tipeDominan]);
    }
}
