<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\QuizController;

Route::get('/', function () {
    return redirect('/quiz');
});

Route::get('/quiz', [QuizController::class, 'index']);
Route::post('/quiz/start', [QuizController::class, 'start']);
Route::post('/quiz/submit', [QuizController::class, 'submit']);
