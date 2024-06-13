<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\RickAndMortyController;

// API endpoints.

Route::get( '/api/character/page/{page}', array( RickAndMortyController::class, 'index' ) )->where( 'id', '[0-9]+' );
Route::get( '/api/character/{id}', array( RickAndMortyController::class, 'show' ) )->where( 'id', '[0-9]+' );

// For VUE.

Route::get(
	'/{vue_capture?}',
	function () {
		return view( 'home' );
	}
)->where( 'vue_capture', '[\/\w\.-]*' );
