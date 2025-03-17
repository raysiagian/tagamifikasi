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
        // $matapelajaran = MataPelajaran::all();  

        // $soals = Soal::with('level')->get();
        // $levels = Level::all(); // Ambil data level dari database
    
        // return view('admin.soal.index', [
        //     'title' => 'Manajemen Soal',
        //     'soals' => $soals,
        //     'levels' => $levels,
        //     'matapelajaran' => $matapelajaran,

        // ]);

        $matapelajaran = MataPelajaran::all();  
        return view('admin.soal.index', [
            'title' => 'Soal',
            'matapelajaran' => $matapelajaran, // Kirim data ke view
        ]);
    }
    
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
    
        try {
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
    
            return redirect()->back()->with('success', 'Soal berhasil ditambahkan!');
        } catch (\Exception $e) {
            return redirect()->back()->with('error', 'Gagal menambahkan soal: ' . $e->getMessage());
        }
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
    $soals = Soal::where('id_level', $id)->get();
    $soals = Soal::where('id_level', $id)->paginate(1); // 1 soal per halaman

    return view('admin.soal.list_soal', [
        // 'title' => 'Soal - Level ' . $level->id_level,
        'title' => 'Soal - Level ' ,
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