/// @description Listening to Steam

//This function call is purely for debugging purposes
//It will log all the messages from the steam callbacks
show_debug_message("Steam ASYNC: " + json_encode(async_load))
//We want to listen to any asynchronous event that occurs through steam, any response back from steam
//This will help us troubleshoot whenever a player is or isn't joining