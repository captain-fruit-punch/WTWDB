extends KinematicBody2D

class_name Player

export (int) var max_move_speed = 120
export (int) var move_accel = 500
export (float) var move_friction = 10
export (int) var weight = 100
export (int) var grounding_force = 10
export (int) var max_fall_speed = 300
var trying_to_move = false
var velocity = Vector2()
var accel = Vector2()

func get_input():
	# Detect up/down/left/right keystate and only move when pressed.
	trying_to_move = false
	accel = Vector2()
	if Input.is_action_pressed('ui_right'):
		accel.x += move_accel
		trying_to_move = true
	if Input.is_action_pressed('ui_left'):
		accel.x -= move_accel
		trying_to_move = true
	if is_on_floor():
		if not trying_to_move:
			accel.x = velocity.x * -1 * move_friction
		velocity.y = 0
		if Input.is_action_just_pressed("ui_accept"):
			print("jump")
	accel.y = weight
	if is_on_wall():
		print(is_on_wall())
		velocity.x = 0

func _physics_process(delta):
	get_input()
	velocity += accel * delta
	move_and_slide(velocity * delta, -transform.y)
