/// @description Game restart (part 1)

//we use a variable as a flag to tell the system we are 'restarting' the game
is_game_restarting = true;//set restarting game to true
game_restart();
//when the game ends, we want steam to know that it does not actually need to shut its service down when we are restarting