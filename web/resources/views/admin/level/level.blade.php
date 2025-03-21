    @extends('layouts.master')
    @section('content')

    <div class="container-fluid py-4">
        <div class="row">
            <div class="col-12">
                <div class="card mb-4">
                    <div class="card-body px-0 pt-0 pb-2">
                        <div class="row">
                            <div class="col-12">
                                <div class="card mb-4">
                                    <div class="card-header pb-0">
                                        <h6>Tambah Level</h6>
                                    </div>
                                    <div class="card-body px-3 pt-3 pb-3">
                                        @if(session('success'))
                                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                                {{ session('success') }}
                                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                            </div>
                                        @endif
                                            
                                        <form id="formLevel" action="{{ route('admin.levels.store') }}" method="POST">
                                            @csrf
                                            <input type="hidden" id="methodField" name="_method" value="POST">
                    
                                            <div class="mb-3">
                                                <label for="id_mataPelajaran" class="form-label">Mata Pelajaran</label>
                                                <select id="id_mataPelajaran" name="id_mataPelajaran" class="form-control" required>
                                                    <option value="">-- Pilih Mata Pelajaran --</option>
                                                    @foreach($mataPelajaran as $mp)
                                                        <option value="{{ $mp->id_mataPelajaran }}">{{ $mp->nama_mataPelajaran }}</option>
                                                    @endforeach
                                                </select>
                                            </div>
                    
                                            <div class="mb-3">
                                                <label for="penjelasan_level" class="form-label">Nama Level</label>
                                                <input type="text" id="penjelasan_level" name="penjelasan_level" class="form-control" required placeholder="Masukkan Nama Level">
                                            </div>
                    
                                            <button type="submit" class="btn btn-success"><i class="bi bi-save"></i> Simpan</button>
                                            <button type="reset" id="btnResetForm" class="btn btn-secondary"><i class="bi bi-x-circle"></i> Batal</button>
                                        </form>
                                    </div>
                                </div>

                                <!-- List Mata Pelajaran -->
                                <div class="card mb-4">
                                    <div class="card-header pb-0">
                                        <h6>Pilih Mata Pelajaran</h6>
                                    </div>
                                    <div class="card-body">
                                        <div class="btn-group" role="group">
                                            @foreach($mataPelajaran as $mp)
                                                <button class="btn btn-primary filter-mataPelajaran" data-id="{{ $mp->id_mataPelajaran }}">
                                                    {{ $mp->nama_mataPelajaran }}
                                                </button>
                                            @endforeach
                                        </div>
                                    </div>
                                </div>

                                <!-- List Level -->
                                <div class="card mb-4">
                                    <div class="card-header pb-0">
                                        <h6>Daftar Level</h6>
                                    </div>
                                    <div class="card-body px-3 pt-3 pb-3">
                                        <div class="table-responsive">
                                            <table class="table table-hover">
                                                <thead class="table-primary">
                                                    <tr>
                                                        <th>ID Level</th>
                                                        <th>Mata Pelajaran</th>
                                                        <th>Nama Level</th>
                                                        <th>Aksi</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="levelTableBody">
                                                    @foreach ($levels as $level)
                                                        <tr>
                                                            <td>{{ $level->id_level }}</td>
                                                            <td>{{ $level->mataPelajaran->nama_mataPelajaran ?? 'Tidak Diketahui' }}</td>
                                                            <td>{{ $level->penjelasan_level }}</td>
                                                            <td>
                                                                <button class="btn btn-warning btn-sm btn-edit-level me-2" 
                                                                        data-id="{{ $level->id_level }}"
                                                                        data-id-mata-pelajaran="{{ $level->id_mataPelajaran }}"
                                                                        data-nama="{{ $level->penjelasan_level }}">
                                                                    <i class="bi bi-pencil-square"></i> Edit
                                                                </button>
                                                                <button class="btn btn-danger btn-sm btn-hapus-level" 
                                                                        data-id="{{ $level->id_level }}"
                                                                        data-nama="{{ $level->penjelasan_level }}">
                                                                    <i class="bi bi-trash"></i> Hapus
                                                                </button>
                                                            </td>
                                                        </tr>
                                                    @endforeach
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div> <!-- col-12 -->
                        </div> <!-- row -->
                    </div> <!-- card-body -->
                </div> <!-- card -->
            </div> <!-- col-12 -->
        </div> <!-- row -->
    </div> <!-- container-fluid -->

    <!-- Modal Hapus -->
    <div class="modal fade" id="modalHapusLevel" tabindex="-1" aria-labelledby="modalHapusLevelLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalHapusLevelLabel">Konfirmasi Hapus</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    Apakah Anda yakin ingin menghapus level "<span id="namaLevelHapus"></span>"?
                </div>
                <div class="modal-footer">
                    <form id="formHapusLevel" method="POST">
                        @csrf
                        @method('DELETE')
                        <button type="submit" class="btn btn-danger">Hapus</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Script AJAX -->
    <script>
        $(document).ready(function () {
            $(".filter-mataPelajaran").click(function () {
                var idMataPelajaran = $(this).data("id");
    
                var tbody = $("#levelTableBody");
                tbody.html("<tr><td colspan='4' class='text-center'>Loading...</td></tr>");
    
                $.ajax({
                    url: "/admin/levels/mata-pelajaran/" + idMataPelajaran,
                    type: "GET",
                    dataType: "json",
                    success: function (data) {
                        tbody.empty();
    
                        if (data.length === 0) {
                            tbody.append("<tr><td colspan='4' class='text-center'>Tidak ada level untuk mata pelajaran ini.</td></tr>");
                        } else {
                            $.each(data, function (index, level) {
                                tbody.append(`
                                    <tr>
                                        <td>${level.id_level}</td>
                                        <td>${level.mata_pelajaran ? level.mata_pelajaran.nama_mataPelajaran : 'Tidak Diketahui'}</td>
                                        <td>${level.penjelasan_level}</td>
                                        <td>
                                            <button class="btn btn-warning btn-sm btn-edit-level me-2" 
                                                    data-id="${level.id_level}"
                                                    data-id-mata-pelajaran="${level.id_mataPelajaran}"
                                                    data-nama="${level.penjelasan_level}">
                                                <i class="bi bi-pencil-square"></i> Edit
                                            </button>
                                            <button class="btn btn-danger btn-sm btn-hapus-level" 
                                                    data-id="${level.id_level}"
                                                    data-nama="${level.penjelasan_level}">
                                                <i class="bi bi-trash"></i> Hapus
                                            </button>
                                        </td>
                                    </tr>
                                `);
                            });
                        }
                    },
                    error: function (xhr, status, error) {
                        console.log(xhr.responseText);
                        tbody.html("<tr><td colspan='4' class='text-center text-danger'>Gagal mengambil data level.</td></tr>");
                    }
                });
            });
    
            // Modal Hapus
            $(document).on("click", ".btn-hapus-level", function () {
                var id = $(this).data("id");
                var nama = $(this).data("nama");
                $("#namaLevelHapus").text(nama);
                $("#formHapusLevel").attr("action", "/admin/levels/" + id);
                $("#modalHapusLevel").modal("show");
            });
        });
    </script>
    

    @endsection
