/// @description Setup lobby_list
//whenever we spawn this object, we want to tell steam to search for lobbies with a specific criteria
//we are first going to call that once and instead of having a refresh lobby button, we are going to tell the object to refresh the lobby list every 5 seconds or so
lobbyList = []

//cosmetic setup
image_xscale = xScale
image_yscale = yScale

lobbyList[0] = instance_create_depth(x, bbox_top + 40, -20, obj_LobbyItem)
//the line below is where we are using the data that we set previously in the host lobby button 
steam_lobby_list_add_string_filter("isGameMakerTest", "true", steam_lobby_list_filter_eq)//we add a filter to the lobbies that we search for. if it equals..., then show is that server
steam_lobby_list_request()//make the request. the query to pull or to make the steam request to ask for lobbies

resetLobbyList = function(){//we are going to iterate through the entire length of the lobby list and make the lobby list array empty again
	for(var _i = 0; _i < array_length(lobbyList); _i++){
		show_debug_message("Deleting: " + string(lobbyList[_i]))
		instance_destroy(lobbyList[_i]);
	}
	lobbyList = []
}
//then we create an async call, so that whenever that request comes back and we get the response, we want to know what to do with it