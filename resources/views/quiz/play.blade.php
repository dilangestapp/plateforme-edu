<h2>Quiz</h2>

<form method="POST" action="/quiz/submit">
    @csrf

    <input type="hidden" name="matiere_id" value="{{ $matiere_id }}">
    <input type="hidden" name="niveau_id" value="{{ $niveau_id }}">

    @foreach($questions as $question)
        <p><strong>{{ $question->contenu }}</strong></p>

        @foreach($question->reponses as $reponse)
            <label>
                <input type="radio"
                       name="reponses[{{ $question->id }}]"
                       value="{{ $reponse->id }}"
                       required>
                {{ $reponse->contenu }}
            </label><br>
        @endforeach

        <hr>
    @endforeach

    <button type="submit">Valider</button>
</form>
