function grab_spawn_point(_player){//function takes a parameter for the player number
	var _spawnPoint = instance_find(obj_SpawnPoint, _player)//search for a spawn point
	if _spawnPoint == noone return {x:0, y:0}//if no spawn point is found, return x:0, y:0
	return {x: _spawnPoint.x, y: _spawnPoint.y}//if it does find it, return the x and y value of the spawn point
}//this function should return an object that can reference the x and y value