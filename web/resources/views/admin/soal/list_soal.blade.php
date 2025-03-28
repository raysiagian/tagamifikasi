@extends('layouts.master')

@section('content')
<body class="g-sidenav-show bg-gray-100">
    <div class="min-height-300 bg-dark position-absolute w-100"></div>
    <main class="main-content position-relative border-radius-lg">
        <div class="container-fluid py-4">
            
           
            <!-- Tombol Tambah Soal -->
            <table>
                <tr>
                    <h4 class="text-white">Soal {{ $level->penjelasan_level }}</h4>
        
                </tr>
                <tr>
            <div class="d-flex justify-content-start mb-3">
                <a href="{{ route('soal.create', ['id_level' => $level->id_level]) }}" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Tambah Soal
                </a>
            </div>
        </tr>
       
        </table>
            <!-- Daftar Soal -->
            <!-- Daftar Soal -->
<div class="row">
    @foreach($soals as $index => $soal) <!-- Menambahkan index -->
        <div class="col-12">
            <div class="card mb-4 shadow-sm p-3">
                <div class="card-body">
                    <h5 class="text-dark">{{ $index + 1 }}. {{ $soal->pertanyaan }}</h5> <!-- Tambahkan nomor soal -->
                    <p><strong>Tipe Soal:</strong> {{ ucfirst($soal->tipeSoal) }}</p>

                    @if($soal->media)
                        <p><strong>Media:</strong></p>
                        @if(preg_match('/\.(jpg|jpeg|png|gif)$/i', $soal->media))
                            <img src="{{ $soal->media }}" class="img-fluid rounded" style="max-width: 300px;">
                        @elseif(preg_match('/\.(mp4|webm|ogg)$/i', $soal->media))
                            <video controls class="w-100" style="max-width: 400px;">
                                <source src="{{ $soal->media }}" type="video/mp4">
                                Browser tidak mendukung pemutaran video.
                            </video>
                        @else
                            <a href="{{ $soal->media }}" target="_blank">Lihat Media</a>
                        @endif
                    @endif

                    @if($soal->audioPertanyaan)
                        <p><strong>Audio:</strong></p>
                        <audio controls>
                            <source src="{{ $soal->audioPertanyaan }}" type="audio/mpeg">
                            Browser tidak mendukung pemutaran audio.
                        </audio>
                    @endif

                    <ul>
                        <li>A: {{ $soal->opsiA }}</li>
                        <li>B: {{ $soal->opsiB }}</li>
                        <li>C: {{ $soal->opsiC }}</li>
                        <li>D: {{ $soal->opsiD }}</li>
                    </ul>
                    <p class="text-success">Jawaban Benar: {{ $soal->jawabanBenar }}</p>
                </div>
            </div>
        </div>
    @endforeach
</div>

        </div>
    </main>
</body>
@endsection
