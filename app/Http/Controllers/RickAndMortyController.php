<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use NickBeen\RickAndMortyPhpApi\Character;
use Response;

class RickAndMortyController extends Controller {

	protected $character;

	public function __construct( Character $character ) {
		$this->character = $character;
	}

	function index($page = 1) {
		$characters = $this->character->page($page)->get();

		foreach ($characters->results as $character) {
			$character->episode_count = count($character->episode);
		}
	
		return response()->json($characters);
	}

	function show( $id ) {
		return response()->json( $this->character->get( $id ) );
	}
}
