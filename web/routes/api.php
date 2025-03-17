<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\AdminController;
use App\Http\Controllers\Api\MataPelajaranController;
use App\Http\Controllers\Api\LevelController;
use App\Http\Controllers\Api\SoalController;
use App\Http\Controllers\Api\VisualController;


//daftar user
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/', [AuthController::class, 'x']);
});

Route::middleware(['auth:sanctum', 'role:admin,super_admin'])->group(function () {
    Route::get('/matapelajaran', [MataPelajaranController::class, 'index']);
    Route::post('/matapelajaran', [MataPelajaranController::class, 'store']);
    Route::get('/matapelajaran/{id}', [MataPelajaranController::class, 'show']);
    Route::put('/matapelajaran/{id}', [MataPelajaranController::class, 'update']);
    Route::delete('/matapelajaran/{id}', [MataPelajaranController::class, 'destroy']);


});

//level
Route::middleware(['auth:sanctum', 'role:admin,super_admin'])->group(function () {
    Route::get('/levels', [LevelController::class, 'index']);
    Route::post('/levels', [LevelController::class, 'store']);
    Route::delete('/levels/{id}', [LevelController::class, 'destroy']);
    Route::put('/levels/{id}', [LevelController::class, 'update']); 

    //soal
    Route::get('/soal', [SoalController::class, 'index']); // Menampilkan semua soal
    Route::post('/soal', [SoalController::class, 'store']); // Menambah soal baru
    Route::get('/soal/{id}', [SoalController::class, 'show']); // Menampilkan soal berdasarkan ID
    Route::put('/soal/{id}', [SoalController::class, 'update']); // Mengupdate soal
    Route::delete('/soal/{id}', [SoalController::class, 'destroy']); // Menghapus soal
});



// //daftarkan admin
// Route::middleware('auth:sanctum')->group(function () {
//     Route::post('/register-admin', [AdminController::class, 'registerAdmin']);
// });


// Route::middleware('auth:sanctum')->group(function () {
//     // Semua bisa melihat subjek
//     Route::get('/subjeks', [SubjekController::class, 'index']);
//     Route::get('/subjeks/{id}', [SubjekController::class, 'show']);

//     // Hanya admin & super admin yang bisa CRUD
//     Route::middleware('role:admin,super_admin')->group(function () {
//         Route::post('/subjeks', [SubjekController::class, 'store']);
//         Route::put('/subjeks/{id}', [SubjekController::class, 'update']);
//         Route::delete('/subjeks/{id}', [SubjekController::class, 'destroy']);
//     });

//     Route::middleware('role:admin,super_admin')->group(function () {
//         Route::get('subjek', [SubjekController::class, 'index']);
//         Route::post('subjek', [SubjekController::class, 'store']);
//         Route::get('subjek/{subjek}', [SubjekController::class, 'show']);
//         Route::put('subjek/{subjek}', [SubjekController::class, 'update']);
//         Route::delete('subjek/{subjek}', [SubjekController::class, 'destroy']);
//     });
// });
