<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Matiere extends Model
{
    protected $fillable = ['nom'];

    public function classes()
    {
        return $this->belongsToMany(Classe::class);
    }

    public function cours()
    {
        return $this->hasMany(Cours::class);
    }
}
