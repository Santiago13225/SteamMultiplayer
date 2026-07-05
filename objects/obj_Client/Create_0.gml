/// @description Init Client Variables

playerList = []//an array that can be filled in with players as they join in

steamID = steam_get_user_steam_id()//server steam id. when we're spawning in players, we want to make sure that the player object being spawned has a steam id that matches the client or server steam id, so you know who has authority to control this player object.
steamName = steam_get_persona_name()
lobbyMemberID = undefined

character = undefined//if we need to reference the character of the server, whatever character the server is inheriting or controlling. we have this here just in case

inbuf = buffer_create(16, buffer_grow, 1);
//we want to add ourselves to the player list
playerList[0] = {//we are going to add ourselves to the first entry of the array
	steamID : steamID,
	steamName : steamName,
	character : undefined,
	startPos : grab_spawn_point(0),//grab spawn point function grabs the first spawn point because of the first player
	lobbyMemberID : undefined
}