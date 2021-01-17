extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var direction = Vector2(1, 1)

# Called when the node enters the scene tree for the first time.
func _ready():
	print("moving platform placed")

onready var bound = get_node("/root/playertestscene/movingplat/movingplatform/bound")
var flip = true
var speed = 20
func _physics_process(delta):
	if position.x < bound.position.x + 0.01 and position.x > bound.position.x - 0.01 and position.y < bound.position.y + 0.01 and position.y > bound.position.y - 0.01:
		flip = false
	elif position.x > -(bound.position.x + 0.01) and position.x < -(bound.position.x - 0.01) and position.y > -(bound.position.y + 0.01) and position.y < -(bound.position.y - 0.01):
		flip = true
		
	if flip:
		position = position.move_toward(Vector2(bound.position.x, bound.position.y), delta*speed)
	elif not flip:
		position = position.move_toward(Vector2(-(bound.position.x),-(bound.position.y)),delta*speed)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
