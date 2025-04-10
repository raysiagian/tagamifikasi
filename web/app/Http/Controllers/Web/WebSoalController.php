<?php
namespace App\Http\Controllers\Web; 
 

use Illuminate\Http\Request;
use App\Models\Soal;
use App\Models\Level;
use App\Models\MataPelajaran;
use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\Controller;
use CloudinaryLabs\CloudinaryLaravel\Facades\Cloudinary;
class WebSoalController extends Controller
{
    public function index()
    {
        

        $matapelajaran = MataPelajaran::all();  
        return view('admin.soal.index', [
            'title' => 'Soal',
            'matapelajaran' => $matapelajaran, // Kirim data ke view
        ]);
    }
    


public function store(Request $request)
{
    $data = $request->all();

    // Upload media jika ada
    if ($request->hasFile('media')) {
        $data['media'] = $request->file('media')->store('media', 'public');
    }

    if ($request->hasFile('audioPertanyaan')) {
        $data['audioPertanyaan'] = $request->file('audioPertanyaan')->store('audio', 'public');
    }

    // Handle opsi dan pasangan A–D
    foreach (['A', 'B', 'C', 'D'] as $opt) {
        // Opsi
        if ($request->hasFile("opsi$opt")) {
            $data["opsi$opt"] = $request->file("opsi$opt")->store("opsi", "public");
        }

        // Pasangan (jika kinestetik)
        if ($request->tipeSoal === 'kinestetik' && $request->hasFile("pasangan$opt")) {
            $data["pasangan$opt"] = $request->file("pasangan$opt")->store("pasangan", "public");
        }
    }

    // Jawaban
    $data['jawabanBenar'] = $request->tipeSoal === 'kinestetik'
        ? json_encode(array_filter($request->jawaban_pair)) // simpan pasangan
        : $request->jawabanBenar;

    // Simpan ke DB
    Soal::create([
        'id_level' => $data['id_level'],
        'pertanyaan' => $data['pertanyaan'],
        'tipeSoal' => $data['tipeSoal'],
        'opsiA' => $data['opsiA'] ?? null,
        'opsiB' => $data['opsiB'] ?? null,
        'opsiC' => $data['opsiC'] ?? null,
        'opsiD' => $data['opsiD'] ?? null,
        'pasanganA' => $data['pasanganA'] ?? null,
        'pasanganB' => $data['pasanganB'] ?? null,
        'pasanganC' => $data['pasanganC'] ?? null,
        'pasanganD' => $data['pasanganD'] ?? null,
        'jawabanBenar' => $data['jawabanBenar'],
        'media' => $data['media'] ?? null,
        'audioPertanyaan' => $data['audioPertanyaan'] ?? null,
    ]);

    return redirect()->route('soal.list', ['id' => $data['id_level']])
        ->with('success', 'Soal berhasil disimpan!');
}



    public function update(Request $request, $id)
    {
        $soal = Soal::findOrFail($id);

        $request->validate([
            'pertanyaan' => 'required|string',
            'opsiA' => 'required|string',
            'opsiB' => 'required|string',
            'opsiC' => 'required|string',
            'opsiD' => 'required|string',
            'jawabanBenar' => 'required|in:A,B,C,D',
            'media' => 'nullable|file',
            'audioPertanyaan' => 'nullable|file',
        ]);

        if ($request->hasFile('media')) {
            $soal->media = Cloudinary::upload($request->file('media')->getRealPath(), ['folder' => 'soal_media'])->getSecurePath();
        }

        if ($request->hasFile('audioPertanyaan')) {
            $soal->audioPertanyaan = Cloudinary::upload($request->file('audioPertanyaan')->getRealPath(), ['folder' => 'soal_audio'])->getSecurePath();
        }

        $soal->update($request->only('pertanyaan', 'opsiA', 'opsiB', 'opsiC', 'opsiD', 'jawabanBenar'));

        return redirect()->back()->with('success', 'Soal berhasil diperbarui!');
    }

    public function destroy($id)
    {
        $soal = Soal::findOrFail($id);
        $soal->delete();
        return redirect()->back()->with('success', 'Soal berhasil dihapus!');
    }

    public function showLevels($id)
{
    // Ambil data mata pelajaran berdasarkan id
    $mataPelajaran = MataPelajaran::findOrFail($id);

    // Ambil level berdasarkan mata pelajaran yang dipilih
    $levels = Level::where('id_mataPelajaran', $id)->get();

    return view('admin.soal.levels', [
        'title' => 'Pilih Level - ' . $mataPelajaran->nama_mataPelajaran,
        'mataPelajaran' => $mataPelajaran,
        'levels' => $levels
    ]);
}

public function showSoal($id)
{
    $level = Level::findOrFail($id);

    // Ambil soal berdasarkan id_level, 5 soal per halaman
    $soals = Soal::where('id_level', $id)->paginate(5);

    return view('admin.soal.list_soal', [
        'title' => 'Soal - Level ' . $level->id_level,
        'level' => $level,
        'soals' => $soals
    ]);
}



public function create($id_level)
{
    $level = Level::findOrFail($id_level);
    return view('admin.soal.create', [
        'title' => 'Tambah Soal',
        'level' => $level
    ]);
}
 
 


 
}