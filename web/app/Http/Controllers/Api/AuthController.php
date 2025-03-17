<?php
namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    // Register User
    public function register(Request $request)
    {
        $request->validate([
            'role' => 'required|in:admin,super_admin,user',
            'name' => 'required|string|max:255',
            'username' => 'required|string|unique:users,username',
            'password' => 'required|string|min:6',
            'gender' => 'required|in:laki-laki,perempuan',
        ]);
    
        $user = User::create([
            'role' => $request->role,
            'name' => $request->name,
            'username' => $request->username,
            'password' => Hash::make($request->password),
            'gender' => $request->gender,
        ]);
    
        $token = $user->createToken('auth_token')->plainTextToken;
    
        return response()->json([
            'access_token' => $token,
            // 'token_type' => 'Bearer',
            'user' => [
                'id_user' => $user->id_user,
                'role' => $user->role,
                'password' => $user->password,
                'name' => $user->name,
                'username' => $user->username,
                'gender' => $user->gender,
            ]
        ], 201);
    }
    

    // Login User
    public function login(Request $request)
    {
        $request->validate([
            'username' => 'required|string',
            'password' => 'required|string',
        ]);

        $user = User::where('username', $request->username)->first();

        if (!$user || !Hash::check($request->password, $user->password)) {
            throw ValidationException::withMessages([
                'username' => ['Username atau password salah.'],
            ]);
        }

        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'access_token' => $token,
            'token_type' => 'Bearer',
            'user' => [
                'id_user' => $user->id_user,
                'role' => $user->role,
                'name' => $user->name,
                'username' => $user->username,
                'gender' => $user->gender,
            ]
        ]);
    }

    // Logout User
    public function logout(Request $request)
    {
        $request->user()->tokens()->delete();

        return response()->json([
            'message' => 'Berhasil logout',
        ]);
    }

    // Get Authenticated User Data
    public function me(Request $request)
    {
        return response()->json([
            'id_user' => $request->user()->id_user,
            'role' => $request->user()->role,
            'name' => $request->user()->name,
            'username' => $request->user()->username,
            'gender' => $request->user()->gender,
        ]);
    }
}
