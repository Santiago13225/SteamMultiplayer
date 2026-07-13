enum NETWORK_PACKETS {//allows us to create a dictionary of entries that we can use for reference later on in the game
	SYNC_PLAYERS = 99,//numbers used are arbitrary. the first packet is a u8, so the number can be anywhere between 0 and 255 or 254
	SPAWN_SELF = 98,
	SPAWN_OTHER = 97,
}