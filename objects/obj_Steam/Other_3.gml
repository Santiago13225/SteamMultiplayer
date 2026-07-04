/// @description Game restart (part 2)

// This presents a game restart implementation example
// When we reach the game end event we are either closing or restarting the game
// we now check our flag variable and we call 'steam_shutdown' only if not restarting
if(is_game_restarting == false){//when we are shutting down the game and actually quitting it...
	steam_shutdown();//do run steam shutdown
}