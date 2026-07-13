//we onlt want these functions to be invoked by the server object, whenever we are referencing variables, so that we don't have to pass the server object to it
//for the first function, we need to send data to the client through steam of all the players
//the commented line below sets the self reference of these functions to be the server object
///@self obj_server
function send_player_sync(_steam_id){//func sent to player list, which could be filled with a bunch of players or just one's self
	var _b = buffer_create(1, buffer_grow, 1);//first, we create the buffer. init as 1 byte and have it grow in size. parameters: start with 1, have it be able to grow, align at 1 - *start at the beginning
	buffer_write(_b, buffer_u8, NETWORK_PACKETS.SYNC_PLAYERS);//write data to buffer. for this buffer, we want to identify it with the first packet. as a client receives the packets, they know this data will be used for syncing data
	buffer_write(_b, buffer_string, shrink_player_list());//write a string to the same buffer and dump the player list in it. function gives a json string that we can parse on the receiving end
	steam_net_packet_send(_steam_id, _b);//steam id to send to, buffer that we need to send to the steam id
	buffer_delete(_b);//to save on memory, we need to delete the buffer that we just created
	//*there's a function called buffer_compress() that could possibly be used to improve the last step overall.
}

///@self obj_server
function send_player_spawn(_steam_id, _slot){
	var _pos = grab_spawn_point(_slot)//grab position that player is spawning in
	var _b = buffer_create(5, buffer_fixed, 1);//1 + 2 + 2, create buffer and set to 5 bytes, fixed amount of data, start at first packet.first byte is identifier for what the packet is for, next 2 bytes are position x, and next 2 bytes after are position y
	buffer_write(_b, buffer_u8, NETWORK_PACKETS.SPAWN_SELF)//write to the buffer we just created, identifier is u8
	buffer_write(_b, buffer_u16, _pos.x)//write x pos to buffer, we use u16 in case the x value in the map could get really large
	buffer_write(_b, buffer_u16, _pos.y)
	steam_net_pack_send(_steam_id, _b)//send packet over to steam id, send buffer that we just created. tell guy who joined where to spawn
	buffer_delete(_b);//after it is sent, we don't need it anymore, so delete
	server_player_spawn_at_pos(_steam_id, _pos)//tell player to spawn. tell ourselves where to spawn
	send_other_player_spawn(_steam_id, _pos);//if there are any other players that exist, we should spawn them too. tell others where to spawn
}

///@self obj_server
function send_other_player_spawn(_steam_id, _pos){
	var _b = buffer_create(13, buffer_fixed, 1);//1 + 2 + 2 + 8. create buffer. a bit larger as other players need to know if this player is being spawned, then who's steam id is it associated with?
	buffer_write(_b, buffer_u8, NETWORK_PACKETS.SPAWN_OTHER)
	buffer_write(_b, buffer_u16, _pos.x)
	buffer_write(_b, buffer_u16, _pos.y)
	buffer_write(_b, buffer_u64, _steam_id)//steam id can be a bit large
	//we want to send info to everyone in the lobby except for the player who joined and except for us
	for(var _i = 1; _i < array_length(playerList); _i++){//iterate through player list. start at 1 as we don't need to send it to ourselves. we should be index 0
		if(playerList[_i].steamID != _steam_id){//if player list with this index value steam id is not equal to steam id of the player that joined. if the player we found does not equal the steam id of the player that joined
			steam_net_packet_send(playerList[_i].steamID, _b)//send info
		}
	}
	buffer_delete(_b)//delete buffer once we are done
}

///@self obj_Server
function shrink_player_list(){
	var _shrunkList = playerList//copy the current player list that exists
	for(var _i = 0; _i < array_length(_shrunkList); _i++){//iterate through the player list
		_shrunkList[_i].character = undefined//make the character variable undefined
	}
	return json_stringify(_shrunkList)//return the string version of the modified shrunken player list
}

///@self obj_Server
function server_player_spawn_at_pos(_steam_id, _pos){//we not only want to spawn the player with info attached to it, we want to modify the player list with whatever character we just created
	var _layer = layer_get_id("Instances")
	for(var _i = 0; _i < array_length(playerList); _i++){//iterate over the player list and create the player based on index
		if(playerList[_i].steamID == _steam_id){//for the index of player, if steam id equals steam id given, we want to spawn the player
			var _inst = instance_create_layer(_pos.x, _pos.y, _layer, obj_Player, {//create a reference to inst we are going to be using. create at x and y pos, layer we identified, spawn player object at that location 
				steamName: playerList[_i].steamName,//info embedded. steam name associated
				steamID: _steam_id,//info to know if it is a locally controlled player or not
				lobbyMemberID: _i//player number in lobby
			})
		playerList[_i].character = _inst//reference the player in player list and give them a reference to this instance. makes it so that character reference is no longer undefined
		}
	}
}

///@self obj_Server
