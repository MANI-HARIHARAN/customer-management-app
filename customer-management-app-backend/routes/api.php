<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\CustomerController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
Route::get('/customer',[CustomerController::class, 'index']);
Route::post('/customer/add',[CustomerController::class, 'store']);
Route::get('/customer_show/{id}',[CustomerController::class, 'show']);
Route::put('/customer_update/{id}',[CustomerController::class, 'update']);
Route::delete('/customer_delete/{id}',[CustomerController::class, 'destroy']);
Route::get('/customer_search',[CustomerController::class, 'search']);