<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Matiere;
use App\Models\Niveau;
use App\Models\Question;
use App\Models\Score;

class QuizController extends Controller
{
    // Page choix matière + niveau
    public function index()
    {
        $matieres = Matiere::all();
        $niveaux  = Niveau::all();

        return view('quiz.index', compact('matieres', 'niveaux'));
    }

    // Démarrer le quiz
    public function start(Request $request)
    {
        $questions = Question::where('matiere_id', $request->matiere_id)
            ->where('niveau_id', $request->niveau_id)
            ->with('reponses')
            ->get();

        return view('quiz.play', [
            'questions' => $questions,
            'matiere_id' => $request->matiere_id,
            'niveau_id' => $request->niveau_id,
        ]);
    }

    // Soumission du quiz
    public function submit(Request $request)
    {
        $score = 0;

        foreach ($request->reponses as $question_id => $reponse_id) {
            $question = Question::find($question_id);
            $reponse  = $question->reponses->where('id', $reponse_id)->first();

            if ($reponse && $reponse->est_correcte) {
                $score++;
            }
        }

        Score::create([
            'nom_eleve' => 'Élève test',
            'matiere_id' => $request->matiere_id,
            'niveau_id' => $request->niveau_id,
            'score' => $score,
        ]);

        return view('quiz.result', compact('score'));
    }
}
