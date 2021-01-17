extends RigidBody2D
class_name javplatform

signal javelin_contact
signal spring_jump
signal delete
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var contact_time = 0
var facing = 1 #1 right, -1 left
var accel = 1
var JAV_FLY = false
var owner_player = null
onready var spritey = get_node("./pivot")

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("spring_jump", self, "_spring_jump")
	connect("javelin_contact", self, "_on_javplatform_javelin_contact")
	connect("delete", self, "_delete")
	print("Platform")
	if facing == -1:
		self.scale.x = -1
	add_to_group("javplatforms")

func _physics_process(delta):
	if facing == 1:
		if contact_time == 0 and spritey.rotation_degrees < 0:
			spritey.rotation_degrees += 4
			accel = 1
	
		if spritey.rotation_degrees < -65:
			get_node("./CollisionShape2D").set_disabled(true)
			contact_time = 0
			
		if spritey.rotation_degrees >= 0 and get_node("./CollisionShape2D").is_disabled():
			get_node("./CollisionShape2D").set_disabled(false)
			
	elif facing == -1:
		if contact_time == 0 and spritey.rotation_degrees > 0:
			spritey.rotation_degrees -= 4
			accel = 1
	
		if spritey.rotation_degrees > 65:
			get_node("./CollisionShape2D").set_disabled(true)
			contact_time = 0

		if spritey.rotation_degrees <= 0 and get_node("./CollisionShape2D").is_disabled():
			get_node("./CollisionShape2D").set_disabled(false)
			
	if JAV_FLY:
		global_position = global_position.move_toward(owner_player.position,50*delta*accel)
		# MAKE JAVELIN ROTATE TO FACE PLAYER AS IT FLIES
		accel *= 1.07
		
	if global_position.x > owner_player.position.x - 0.01:
		if global_position.x < owner_player.position.x + 0.01:
			if global_position.y > owner_player.position.y - 0.01:
				if global_position.y < owner_player.position.y + 0.01:
					owner_player.emit_signal("javelin_in")
					JAV_FLY = false
					accel = 1
					queue_free()
	
	
func _on_javplatform_javelin_contact():
	contact_time += 1
	spritey.rotation_degrees -= 0.6 * facing * accel
	accel *= 1.014
	
func _spring_jump():
	contact_time = 0
	
func _delete():
	print('ashidoas')
	get_node("./CollisionShape2D").set_disabled(true)
	JAV_FLY = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
