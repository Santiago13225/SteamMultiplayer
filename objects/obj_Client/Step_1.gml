/// @description Listening for Activity as Client

//Receiving Packets
while(steam_net_packet_receive()){
	var _sender = steam_net_packet_get_sender_id()
	steam_net_packet_get_data(inbuf);
	buffer_seek(inbuf, buffer_seek_start, 0);
	var _type = buffer_read(inbuf, buffer_u8);
	
	switch _type{
		case NETWORK_PACKETS.SYNC_PLAYERS:
			var _playerList = buffer_read(inbuf, buffer_string);
			_playerList = json_parse(_playerList)
			sync_players(_playerList)
			break
	}
	
}