/// @description Listening for Lobby Creation

switch(async_load[?"event_type"]){//it looks for an event type. when an async event is triggered, it will load all the data from that event. it's looking specifically for the event type and then we're going to perform certain actions based on what event occurred.
	case "lobby_created"://for our first case, we are going to look for 'lobby created'
		show_debug_message("Lobby created: " + string(steam_lobby_get_lobby_id()))//when the lobby is created, tell us that the lobby is created. get steam lobby id.
		steam_lobby_join_id(steam_lobby_get_lobby_id())//join the same steam lobby. issue another request to join the lobby.
		
		break
//the above is going to send another request to steam and another response back to us, which is a lobby joined message
	case "lobby_joined":
		if(steam_lobby_is_owner()){//if steam lobby is the owner
			steam_lobby_set_data("isGameMakerTest", "true");//first, set some data. this is how our game knows to show this type of lobby in the client
			steam_lobby_set_data("Creator", steam_get_persona_name());//make the creator of the lobby be us.
			//steam_lobby_set_data("map", "rm_GameRoom");//data is map entry, current map is called rm_GameRoom. whenever we call this and want to pull that information, we can get lobby data
		}
		//once we have set data, we want to go to our gameroom.
		room_goto(rm_GameRoom)	
}