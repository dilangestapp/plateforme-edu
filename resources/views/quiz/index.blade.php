<h2>Choisir un quiz</h2>

<form method="POST" action="/quiz/start">
    @csrf

    <label>Matière :</label>
    <select name="matiere_id" required>
        @foreach($matieres as $matiere)
            <option value="{{ $matiere->id }}">{{ $matiere->nom }}</option>
        @endforeach
    </select>

    <br><br>

    <label>Niveau :</label>
    <select name="niveau_id" required>
        @foreach($niveaux as $niveau)
            <option value="{{ $niveau->id }}">{{ $niveau->nom }}</option>
        @endforeach
    </select>

    <br><br>

    <button type="submit">Commencer</button>
</form>
