<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Question extends Model
{
    use HasFactory;

    protected $fillable = [
        'matiere_id',
        'niveau_id',
        'contenu'
    ];

    public function reponses()
    {
        return $this->hasMany(Reponse::class);
    }
}
