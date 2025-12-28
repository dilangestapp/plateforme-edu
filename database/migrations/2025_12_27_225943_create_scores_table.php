<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
  public function up()
{
    Schema::create('scores', function (Blueprint $table) {
        $table->id();
        $table->string('nom_eleve');
        $table->foreignId('matiere_id')->constrained()->onDelete('cascade');
        $table->foreignId('niveau_id')->constrained()->onDelete('cascade');
        $table->integer('score');
        $table->timestamps();
    });
}

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('scores');
    }
};
