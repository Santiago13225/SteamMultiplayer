/// @description Listening for Activity as Client

//Receiving Packets
while(steam_net_packet_receive()){//while...
	//first, we need to know who is sending the information
	var _sender = steam_net_packet_get_sender_id()//tell us who is sending the information
	steam_net_packet_get_data(inbuf);//send the information into a buffer that we have
	buffer_seek(inbuf, buffer_seek_start, 0);//when we begin reading through a buffer or seeking through it, make sure that we are starting from the beginning of the buffer
	//we need to have a reference to the first packet. the first packet of a buffer helps us determine what to do with the rest of the data inside the buffer
	var _type = buffer_read(inbuf, buffer_u8);//determine the type of packet based on what the first byte that is received is
	
	switch _type{//switch on what type of data was received
		case NETWORK_PACKETS.SYNC_PLAYERS:
			var _playerList = buffer_read(inbuf, buffer_string);//we are expecting a buffer string to be read
			_playerList = json_parse(_playerList)//parse the string as a readable json object
			sync_players(_playerList)//sync our players based off the newly acquired player list from the server
			break
		case NETWORK_PACKETS.SPAWN_OTHER://this packet is mostly used when we are in the lobby and someone else joins
			var _layer = layer_get_id("Instances");
			var _x = buffer_read(inbuf, buffer_u16)
			var _y = buffer_read(inbuf, buffer_u16)
			var _steamID = buffer_read(inbuf, buffer_u64)
			var _num = array_length(playerList)
			var _inst = instance_create_layer(_x, _y, _layer, obj_Player, {
				steamName : steam_get_user_persona_name(_steamID),
				steamID : _steamID,
				lobbyMemberID : _num
				})
			array_push(playerList, {
				steamID : _steamID,
				steamName: steam_get_user_persona_name(_steamID),
				character: _inst,
				lobbyMemberID: _num
			})
			break
		case NETWORK_PACKETS.SPAWN_SELF:
			for(var _i = 0; _i < array_length(playerList); _i++){
				if playerList[_i].steamID == steamID then lobbyMemberID = playerList[_i].lobbyMemberID//make sure the person we are spawning is getting the right lobby member id to determine their "skin"
			}
			var _layer = layer_get_id("Instances");//chose layer to spawn on
			var _x = buffer_read(inbuf, buffer_u16)
			var _y = buffer_read(inbuf, buffer_u16)
			var _inst = instance_create_layer(_x, _y, _layer, obj_Player, {//create the character
				steamName : steamName,
				steamID : steamID,
				lobbyMemberID : lobbyMemberID
				})
			playerList[0].character = _list//set reference of inst to own personal character value in player list
			character = _inst//also to what our client sees as our character
			break
		default:
			show_debug_message("Unknown Packet Received")
			break
	}
}