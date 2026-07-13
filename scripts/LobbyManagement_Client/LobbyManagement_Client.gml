///@self obj_Client
function sync_players(_new_list){//takes in a player list var
	//we want to gather all the current steam ids that we have in our current player list that exists and compile it all into an array
	var _steamIDs = []
	for(var _i = 0; _i < array_length(playerList); i++){
		array_push(_steamIDs, playerList[_i].steamID)
	}
	for(var _i = 0; _i < array_length(_new_list); _i++){//iterate through everything in the new player list that we just received
		var _newSteamID = _new_list[_i].steamID//set new steam id equal to steam id of whatever index we are at
		if(!array_contains(_steamIDs, _newSteamID)){//if the list of steam ids that we received does not include this new steam id. if our current player list does not include this new player.
			var _inst = client_player_spawn_at_pos(_new_list[_i])//we spawn a new player for the player
			_new_list[_i].character = _inst//make the character for an entry in the array be the instance that we just created
			array_push(playerList, _new_list[_i])//push the new player to our existing player list
		}else{//if the player steam id is already in the list, then we have to sync it up with the server
			for(var _k = 0; _k < array_length(playerList); _k++){
				if(playerList[_k].steamID == _newSteamID){
					playerList[_k].startPos = _new_list[_i].startPos
					playerList[_k].lobbyMemberID = _new_list[_i].lobbyMemberID
					if(playerList[_k].character == undefined && playerList[_k].steamID != _newSteamID){
						var _inst = client_player_spawn_at_pos(playerList[_k])
						playerList[_k].character = _inst
					}
				}
			}
		}
	}
}

///@self obj_Client
function client_player_spawn_at_pos(_player_info){//function handles spawning a player
	var _layer = layer_get_id("Instances")//what layer we are spawning the player on
	var _name = _player_info.steamName//name of the player
	var _steamID = _player_info.steamID//steam id
	var _num = _player_info.lobbyMemberID
	var _loc = _player_info.startPos//spawn location
	var _inst = instance_create_layer(_loc.x, _loc.y, _layer, obj_Player, {//spawn instance
		steamName: _name,
		steamID: _steamID,
		lobbyMemberID: _num
	})
	return _inst
}