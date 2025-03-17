@extends('layouts.master')

@section('content')
<body class="g-sidenav-show bg-gray-100">
    <div class="min-height-300 bg-dark position-absolute w-100"></div>
    <main class="main-content position-relative border-radius-lg">
        <div class="container-fluid py-4">
            <h4 class="text-white">Tambah Soal untuk Level {{ $level->id_level }}</h4>

            <div class="card p-4">
                <form action="{{ route('soal.store') }}" method="POST" enctype="multipart/form-data">
                    @csrf
                    <input type="hidden" name="id_level" value="{{ $level->id_level }}">

                    <div class="mb-3">
                        <label for="pertanyaan" class="form-label">Pertanyaan</label>
                        <input type="text" name="pertanyaan" class="form-control" required>
                    </div>

                    <div class="mb-3">
                        <label for="tipeSoal" class="form-label">Tipe Soal</label>
                        <select name="tipeSoal" class="form-control" required>
                            <option value="visual">Visual</option>
                            <option value="auditori">Auditori</option>
                            <option value="kinestetik">Kinestetik</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Jawaban</label>
                        <div class="input-group">
                            <span class="input-group-text">A</span>
                            <input type="text" name="opsiA" class="form-control" required>
                        </div>
                        <div class="input-group mt-2">
                            <span class="input-group-text">B</span>
                            <input type="text" name="opsiB" class="form-control" required>
                        </div>
                        <div class="input-group mt-2">
                            <span class="input-group-text">C</span>
                            <input type="text" name="opsiC" class="form-control" required>
                        </div>
                        <div class="input-group mt-2">
                            <span class="input-group-text">D</span>
                            <input type="text" name="opsiD" class="form-control" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="jawabanBenar" class="form-label">Jawaban Benar</label>
                        <select name="jawabanBenar" class="form-control" required>
                            <option value="A">A</option>
                            <option value="B">B</option>
                            <option value="C">C</option>
                            <option value="D">D</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="media" class="form-label">Media (Opsional)</label>
                        <input type="file" name="media" class="form-control">
                    </div>

                    <div class="mb-3">
                        <label for="audioPertanyaan" class="form-label">Audio (Opsional)</label>
                        <input type="file" name="audioPertanyaan" class="form-control">
                    </div>

                    <button type="submit" class="btn btn-success">
                        <i class="fas fa-save"></i> Simpan Soal
                    </button>
                    <a href="{{ route('soal.list', ['id' => $level->id_level]) }}" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Kembali
                    </a>
                </form>
            </div>
        </div>
    </main>
</body>
@endsection
