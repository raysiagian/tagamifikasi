<?php
namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Level;
use App\Models\MataPelajaran;

class WebLevelController extends Controller
{
    public function index()
    {
        $levels = Level::with('mataPelajaran')->get();
        $mataPelajaran = MataPelajaran::all();  
        return view('admin.level.level',[
            'title' => 'Web Level',
            'levels' => $levels,
            'mataPelajaran' => $mataPelajaran

        ]);
    }

    public function store(Request $request)
    {
        $request->validate([
            'id_mataPelajaran' => 'required|exists:matapelajaran,id_mataPelajaran',
            'penjelasan_level' => 'required|string|max:255',
        ]);

        Level::create([
            'id_mataPelajaran' => $request->id_mataPelajaran,
            'penjelasan_level' => $request->penjelasan_level,
        ]);

        return redirect()->route('admin.levels.index')->with('success', 'Level berhasil ditambahkan.');
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'id_mataPelajaran' => 'required|exists:matapelajaran,id_mataPelajaran',
            'penjelasan_level' => 'required|string|max:255',
        ]);

        $level = Level::findOrFail($id);
        $level->update([
            'id_mataPelajaran' => $request->id_mataPelajaran,
            'penjelasan_level' => $request->penjelasan_level,
        ]);

        return redirect()->route('admin.levels.index')->with('success', 'Level berhasil diperbarui.');
    }

    public function destroy($id)
    {
        $level = Level::findOrFail($id);
        $level->delete();

        return redirect()->route('admin.levels.index')->with('success', 'Level berhasil dihapus.');
    }
}
