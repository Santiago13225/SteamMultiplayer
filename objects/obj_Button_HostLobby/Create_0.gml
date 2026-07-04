//Inherit the parent event
event_inherited();
selectAction = function(){
	global.server = instance_create_depth(0,0,0,obj_Server)//create the server object and add a global reference to it
	steam_lobby_create(steam_lobby_type_public, 4);//request steam create a lobby for us. create a public lobby for 4 players
}
//when we click the steam lobby create button, steam is sending out a query to create a lobby, and it will wait for a response
//we'll get a response where steam tells us 'hey, this is your lobby id that was created'.
//then we can go ahead and join that lobby.
//we don't want that logic to always be going on in the game, like waiting for a lobby to be created.
//the logic should only exist while we are in the menu.
//so, we are going to put an async call that listens.