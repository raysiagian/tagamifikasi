@extends('layouts.master')

@section('content')
<body class="g-sidenav-show bg-gray-100">
    <div class="min-height-300 bg-dark position-absolute w-100"></div>
    <main class="main-content position-relative border-radius-lg">
        <div class="container-fluid py-4">
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
                        <select name="tipeSoal" id="tipeSoal" class="form-control" required onchange="toggleFields()">
                            <option value="visual">Visual</option>
                            <option value="auditori">Auditori</option>
                            <option value="kinestetik">Kinestetik</option>
                        </select>
                    </div>

                    {{-- OPSI --}}
                    <div class="mb-3">
                        <label class="form-label">Opsi</label>
                        @foreach(['A','B','C','D'] as $opt)
                        <div class="mt-3 border rounded p-3">
                            <label class="form-label">Opsi {{ $opt }}</label>
                            <select class="form-select mb-2" onchange="toggleInput(this, 'opsi{{ $opt }}')">
                                <option value="text">Teks</option>
                                <option value="file">File</option>
                            </select>
                            <input type="text" name="opsi{{ $opt }}" id="opsi{{ $opt }}_text" class="form-control opsi-input">
                            <input type="file" name="opsi{{ $opt }}" id="opsi{{ $opt }}_file" class="form-control opsi-input d-none">
                        </div>
                        @endforeach
                    </div>

                    {{-- PASANGAN --}}
                    <div id="pasanganFields" style="display: none;">
                        <div class="mb-3">
                            <label class="form-label">Pasangan</label>
                            @foreach(['A','B','C','D'] as $opt)
                            <div class="mt-3 border rounded p-3">
                                <label class="form-label">Pasangan {{ $opt }}</label>
                                <select class="form-select mb-2" onchange="toggleInput(this, 'pasangan{{ $opt }}')">
                                    <option value="text">Teks</option>
                                    <option value="file">File</option>
                                </select>
                                <input type="text" name="pasangan{{ $opt }}" id="pasangan{{ $opt }}_text" class="form-control pasangan-input">
                                <input type="file" name="pasangan{{ $opt }}" id="pasangan{{ $opt }}_file" class="form-control pasangan-input d-none">
                            </div>
                            @endforeach
                        </div>
                    </div>

                    {{-- Jawaban untuk visual dan auditori --}}
                    <div class="mb-3" id="jawabanSingleField">
                        <label for="jawabanBenar" class="form-label">Jawaban Benar</label>
                        <select name="jawabanBenar" class="form-control">
                            <option value="A">A</option>
                            <option value="B">B</option>
                            <option value="C">C</option>
                            <option value="D">D</option>
                        </select>
                    </div>

                    {{-- Jawaban kinestetik --}}
                    <div class="mb-3" id="jawabanBenarKinestetik" style="display: none;">
                        <label class="form-label">Jawaban Benar (Pasangan Opsi dan Pasangan)</label>
                        <div class="row">
                            @foreach(['A','B','C','D'] as $opt)
                            <div class="col-md-6 mb-2">
                                <label>Pasangan untuk Opsi {{ $opt }}</label>
                                <select class="form-control" name="jawaban_pair[{{ $opt }}]">
                                    <option value="">-- Tidak ada --</option>
                                    <option value="A">Pasangan A</option>
                                    <option value="B">Pasangan B</option>
                                    <option value="C">Pasangan C</option>
                                    <option value="D">Pasangan D</option>
                                </select>
                            </div>
                            @endforeach
                        </div>
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

    <script>
        function toggleInput(selectEl, baseId) {
            const type = selectEl.value;
            const textInput = document.getElementById(`${baseId}_text`);
            const fileInput = document.getElementById(`${baseId}_file`);
            if (type === 'text') {
                textInput.classList.remove('d-none');
                fileInput.classList.add('d-none');
                textInput.name = baseId;
                fileInput.name = '';
            } else {
                textInput.classList.add('d-none');
                fileInput.classList.remove('d-none');
                textInput.name = '';
                fileInput.name = baseId;
            }
        }

        function toggleFields() {
            const tipe = document.getElementById('tipeSoal').value;
            document.getElementById('pasanganFields').style.display = tipe === 'kinestetik' ? 'block' : 'none';
            document.getElementById('jawabanBenarKinestetik').style.display = tipe === 'kinestetik' ? 'block' : 'none';
            document.getElementById('jawabanSingleField').style.display = tipe === 'kinestetik' ? 'none' : 'block';
        }

        document.addEventListener('DOMContentLoaded', function () {
            toggleFields();
            document.querySelectorAll('select').forEach(select => {
                const next = select.nextElementSibling;
                if (next && next.id && next.id.endsWith('_text')) {
                    const baseId = next.id.replace('_text', '');
                    toggleInput(select, baseId);
                }
            });
        });
    </script>
</body>
@endsection
