<?php
namespace App\Http\Controllers\Web; 
 

use Illuminate\Http\Request;
use App\Models\Soal;
use App\Models\Level;
use App\Models\MataPelajaran;
use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\Controller;
use Illuminate\Validation\Rule;

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
        // Validasi input dasar
        $request->validate([
            'id_level' => 'required|exists:level,id_level',
            'tipeSoal' => 'required|in:visual1,visual2,auditori1,auditori2,kinestetik1,kinestetik2',
            'pertanyaan' => 'required|string',
        ]);
    
        // Fungsi reusable: upload file ke Cloudinary atau ambil teks
        $uploadOrText = function ($name, $folder) use ($request) {
            if ($request->hasFile($name)) {
                return Cloudinary::upload(
                    $request->file($name)->getRealPath(),
                    ['folder' => $folder, 'resource_type' => 'auto']
                )->getSecurePath();
            }
            return $request->input($name); // teks biasa
        };
    
        // Proses semua kolom yang bisa berupa teks/file
        $data = [
            'id_level' => $request->id_level,
            'tipeSoal' => $request->tipeSoal,
            'pertanyaan' => $request->pertanyaan,
            'audioPertanyaan' => $uploadOrText('audioPertanyaan', 'soal/audio'),
            'media' => $uploadOrText('media', 'soal/media'),
            'opsiA' => $uploadOrText('opsiA', 'soal/opsi'),
            'opsiB' => $uploadOrText('opsiB', 'soal/opsi'),
            'opsiC' => $uploadOrText('opsiC', 'soal/opsi'),
            'opsiD' => $uploadOrText('opsiD', 'soal/opsi'),
        ];
    
        // Hanya untuk tipe kinestetik → pasanganA–D & jawaban pair
        if (str_contains($request->tipeSoal, 'kinestetik')) {
            $data['pasanganA'] = $uploadOrText('pasanganA', 'soal/pasangan');
            $data['pasanganB'] = $uploadOrText('pasanganB', 'soal/pasangan');
            $data['pasanganC'] = $uploadOrText('pasanganC', 'soal/pasangan');
            $data['pasanganD'] = $uploadOrText('pasanganD', 'soal/pasangan');
    
            $data['jawabanBenar'] = json_encode(array_filter($request->jawaban_pair));
        } else {
            $data['jawabanBenar'] = $request->jawabanBenar;
        }
    
        // Simpan ke database
        $soal = Soal::create($data);
    
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