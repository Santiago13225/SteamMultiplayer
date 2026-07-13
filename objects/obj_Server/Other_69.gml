/// @description Server Listener
//the server receives an async response from steam telling us that a player has joined, as such, we need logic to handle that
switch(async_load[? "event_type"]){//make a switch case based on event type
	case "lobby_chat_update"://if it is a lobby chat update event
		var _fromID = async_load[?"user_id"];//Steam ID. who is this coming from?
		var _fromName = steam_get_user_persona_name_sync(_fromID);//Steam Player Name. function used to get name  
		if(async_load[?"change_flags"] & steam_lobby_member_change_entered){//determine if a new player is entering the lobby
			show_debug_message("Player Joined: " + _fromName)
			var _slot = array_length(playerList)//player slot var to help us know what slot a player is in. are they 1st? 2nd? 3rd? etc.
			array_push(playerList, {//push the new player to the player list
				steamID: _fromID,
				steamName: _fromName,
				character: undefined,
				startPos: grab_spawn_point(_slot),//spawn point from their slot
				lobbyMemberID: _slot//their index in the whole object
			})
			//we need to send the player the state of the game. where everyone else exists, where they are spawned at, what their steam ids are, what their steam names are, etc.
			send_player_sync(_fromID);//send steam id
			send_player_spawn(_fromID, _slot);//once everything is synced up with the player, we tell them to spawn afterwards
		}
}