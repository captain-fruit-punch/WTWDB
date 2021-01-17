extends KinematicBody2D
class_name Javelin

signal right_face
signal left_face

# 1 if ->, -1 if <-
var character_facing = 1
var owner_player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("javelins")
	connect("right_face", self, "_right_face")
	connect("left_face", self, "_left_face")

func _right_face():
	character_facing = 1
	
func _left_face():
	character_facing = -1
	self.scale.x = -1

export (float) var speedz = 300 * character_facing
func _physics_process(delta):
	var javhit = move_and_collide(Vector2(cos(rotation), sin(rotation)) * speedz * delta)
	if javhit:
		speedz = 0
		if javhit.collider is TileMap:
			var tile_pos = javhit.collider.world_to_map(position)
			tile_pos -= javhit.normal
			var tile_id = javhit.collider.get_cellv(tile_pos)
			var tile_name = javhit.collider.tile_set.tile_get_name(tile_id)
			
			var javform = load("res://javplatform.tscn")
			var platform = javform.instance()
			platform.name = "javplatform"
			platform.get_node("javplatform").owner_player = owner_player
			owner_player.keep_javelin = platform.get_node("javplatform")
			get_tree().root.get_child(0).add_child(platform)
			platform.position = self.position
			platform.scale.x = character_facing
			queue_free()



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
