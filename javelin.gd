extends KinematicBody2D
class_name Javelin

# 1 if ->, -1 if <-
var character_facing = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("javelins")

export (float) var speed = 100 * character_facing
func _physics_process(delta):
	var javhit = move_and_collide(Vector2(cos(rotation), sin(rotation)) * speed * delta)
	if javhit:
		speed = 0
		if javhit.collider is TileMap:
			var tile_pos = javhit.collider.world_to_map(position)
			tile_pos -= javhit.normal
			var tile_id = javhit.collider.get_cellv(tile_pos)
			var tile_name = javhit.collider.tile_set.tile_get_name(tile_id)
			print(tile_name)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
