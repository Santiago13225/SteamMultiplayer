/// @description Setup Player

localSteamID = steam_get_user_steam_id()//when object is created, set local steam id to whatever local instance of the game is running. whoever is playing the game, it will get their steam id
isLocal = (localSteamID == steamID)//if the local steam id on this object is equal to the steam id that was assigned to it when it was created, it will allow you to control the character
image_index = lobbyMemberID//different sprite frames used for different players, should match for everyone in the lobby
//lobbyMemberID = 0

moveSpeed = 5
fireCooldown = 50
currentCooldown = 0

init_controls()