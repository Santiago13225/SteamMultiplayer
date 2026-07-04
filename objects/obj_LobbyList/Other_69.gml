/// @description Listen for Server List Response

switch(async_load[? "event_type"]){//switch on async load with "event_type" variable
	case "lobby_list"://"lobby_list" is the response that we are looking for
	//once we get the response, we are going to do some cosmetic logic. create a list from it
		resetLobbyList()//reset the lobby list prior to creating this whole list
		if steam_lobby_list_get_count() == 0 {//steam_lobby_list_get_count() tells us how many lobbies match the query. if we get 0 lobbies back
			lobbyList[0] = instance_create_depth(x, bbox_top + 40, -20, obj_LobbyItem)//adding the array list of lobbies
		}else{//if we do have one or more lobbies that appear
			for(var _i = 0; _i < steam_lobby_list_get_count(); _i++){//iterate through the full count of lobbies
				var _ins = instance_create_depth(x, bbox_top + 40 + 80 * _i, -20, obj_LobbyItem, {//create a button to join the lobby
					lobby_index : _i,//pass variales into the lobby item. give it a lobby index
					lobby_id : steam_lobby_list_get_lobby_id(_i),//give it its own lobby id based on its own index
					lobby_creator : steam_lobby_list_get_data(_i, "Creator")//tell us who the creator of the lobby is
				});
				array_push(lobbyList, _ins);//once we have the instance, we want to push that into the lobby list
			}
		}
	break
}