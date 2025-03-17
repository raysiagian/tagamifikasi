@extends('layouts.master')

@section('content')
<body class="g-sidenav-show bg-gray-100">
    <div class="min-height-300 bg-dark position-absolute w-100"></div>
    <main class="main-content position-relative border-radius-lg">
        <div class="container-fluid py-4">
            
            <!-- Tambah Mata Pelajaran -->
            <div class="row">
                <div class="col-12">
                    <div class="card mb-4">
                        <div class="card-header pb-0">
                            <h6>Tambah Mata Pelajaran</h6>
                        </div>
                        <div class="card-body">
                            <form action="{{ route('admin.matapelajaran.store') }}" method="POST">
                                @csrf
                                <div class="mb-3">
                                    <label for="nama_mataPelajaran" class="form-label">Nama Mata Pelajaran</label>
                                    <input type="text" class="form-control" id="nama_mataPelajaran" name="nama_mataPelajaran" required>
                                </div>
                                <button type="submit" class="btn btn-primary">Tambah</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Daftar Mata Pelajaran -->
            <div class="row">
                <div class="col-12">
                    <div class="card mb-4">
                        <div class="card-header pb-0">
                            <h6>Daftar Mata Pelajaran</h6>
                        </div>
                        <div class="card-body">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        {{-- <th>#</th> --}}
                                        <th>Nama Mata Pelajaran</th>
                                        <th>Aksi</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach($matapelajaran as $mata)
                                    <tr>
                                        {{-- <td>{{ $mata->id_mataPelajaran }}</td> --}}
                                        <td>{{ $mata->nama_mataPelajaran }}</td>
                                        <td>
                                            <a href="#" class="btn btn-warning btn-sm">Edit</a>
                                            <form action="{{ route('admin.matapelajaran.destroy', $mata->id_mataPelajaran) }}" method="POST" style="display:inline;">
                                                @csrf
                                                @method('DELETE')
                                                <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Yakin ingin menghapus?')">Hapus</button>
                                            </form>
                                        </td>
                                    </tr>
                                @endforeach
                                
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
</body>
@endsection