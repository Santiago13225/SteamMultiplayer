/// @description Spawn Players
//when the room starts, we want to spawn all the players. the server needs to determine where all the players spawn
var _playerLayer = layer_get_id("Instances")//when we spawn an object, we want it to spawn in the instances layer. here, we get the layer
//we need to iterate over the player list to spawn each player
for(var _player = 0; _player < array_length(playerList); _player++){//for each player in the player list, iterate
	var _pos = grab_spawn_point(_player)//grab spawn point
	var _inst = instance_create_layer(_pos.x, _pos.y, _playerLayer, obj_Player, {//spawn the player
		steamName : playerList[_player].steamName,//pass steam name, which should be in the player list dictionary that we have
		steamID : playerList[_player].steamID,
		lobbyMemberID : _player//lmid is used for cosmetic differentiation for each player
	})//after, we need to update our array of players
	playerList[_player].character = _inst
	playerList[_player].startPos = _pos//spawn point
	if(playerList[_player].steamID == steamID) then character = _inst//if the player id equals our own steam id, set our own character equal to this instance as well
	
}