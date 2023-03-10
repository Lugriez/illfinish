extends Navigation2D


const SPAWN_ROOMS:Array = [preload("res://Rooms/SpawnRooms/RoomSpawn1.tscn")]
const INTERMEDIATE_ROOMS:Array = [preload("res://Rooms/RegularRooms/Room0.tscn"),preload("res://Rooms/RegularRooms/Room2.tscn"),preload("res://Rooms/SpecialRooms/Corridor0.tscn")]
const SPEC_ROOMS:Array = [preload("res://Rooms/SpecialRooms/RoomSpec1.tscn"),]
const END_ROOMS: Array = [preload("res://Rooms/ExitRooms/RoomExit1.tscn")]

const TILE_SIZE: int = 16
const FLOOR_TILE_INDEX: int = 5
const RIGHT_WALL_TILE_INDEX: int = 8
const LEFT_WALL_TILE_INDEX: int = 9

export(int) var num_levels: int = 2

onready var player: KinematicBody2D = get_parent().get_node("Player")

func _ready():
	
	var arguments = {}
	for argument in OS.get_cmdline_args():
		if argument.find("=") > -1:
			
			var key_value = argument.split("=")
			arguments[key_value[0].lstrip("--")] = key_value[1]
			
			if !arguments:
				print("argumentov stok ",arguments)
			else:
				if key_value[0] == "--r":
					num_levels = int(key_value[1])
					print (key_value[1])
	_spawn_rooms()

func _spawn_rooms()->void:
	var previous_room: Node2D
	var spec_rooms_spawned = false
	print(num_levels)
	for i in num_levels:
		var room: Node2D
		if i == 0:
			room = SPAWN_ROOMS[randi() % SPAWN_ROOMS.size()].instance()
			player.position = room.get_node("PlayerSpawnPos").position
		else:
			if i == num_levels - 1:
				room = END_ROOMS[randi() % END_ROOMS.size()].instance()
			else:
				if (randi()%3 == 0 and not spec_rooms_spawned):
					room = SPEC_ROOMS[randi() % SPEC_ROOMS.size()].instance()
				else:
					room = INTERMEDIATE_ROOMS[randi() % INTERMEDIATE_ROOMS.size()].instance()
				
		
			var previous_room_tilemap: TileMap = previous_room.get_node("TileMap")
			var previous_room_door: StaticBody2D = previous_room.get_node("Doors/Door")
			var exit_tile_pos: Vector2 = previous_room_tilemap.world_to_map(previous_room_door.position) + Vector2.UP * 2
			
			var corridor_height: int = randi() % 3
			for y in corridor_height:
				previous_room_tilemap.set_cellv(exit_tile_pos + Vector2(-2, -y), LEFT_WALL_TILE_INDEX)
				previous_room_tilemap.set_cellv(exit_tile_pos + Vector2(-1, -y), FLOOR_TILE_INDEX)
				previous_room_tilemap.set_cellv(exit_tile_pos + Vector2(-0, -y), FLOOR_TILE_INDEX)
				previous_room_tilemap.set_cellv(exit_tile_pos + Vector2(1, -y), RIGHT_WALL_TILE_INDEX)
				
			var room_tilemap: TileMap = room.get_node("TileMap")
			room.position = previous_room_door.global_position + Vector2.UP * room_tilemap.get_used_rect().size.y * TILE_SIZE + Vector2.UP * (1 + corridor_height) * TILE_SIZE + Vector2.LEFT * room_tilemap.world_to_map(room.get_node("Entrance/Position2D2").position).x * TILE_SIZE
		add_child(room)
		previous_room = room
