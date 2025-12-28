<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Classe extends Model
{
    protected $fillable = ['nom'];

    public function matieres()
    {
        return $this->belongsToMany(Matiere::class);
    }

    public function cours()
    {
        return $this->hasMany(Cours::class);
    }
}
