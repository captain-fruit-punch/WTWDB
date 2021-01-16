extends KinematicBody2D

class_name Player

export (int) var max_move_speed = 120
export (int) var move_accel = 500
export (float) var move_friction = 10
export (int) var weight = 100
export (int) var max_fall_speed = 300
export (int) var jump_up_speed = 12000
export (int) var jump_down_speed = 8000
export (float) var jump_curve = 0.1
export (float) var jump_time = 0.5
export (float) var jump_float_time = 0.05
var trying_to_move = false
var velocity = Vector2()
var accel = Vector2()
var is_jumping = false
var time_in_jump = 0


func get_player_movement(delta):
	trying_to_move = false
	accel = Vector2()
	if Input.is_action_pressed('ui_right'):
		accel.x += move_accel
		trying_to_move = true
	if Input.is_action_pressed('ui_left'):
		accel.x -= move_accel
		trying_to_move = true
	if is_on_floor():
		if trying_to_move and sign(velocity.x) * sign(accel.x) <0:
			print("dragging")
			accel.x *= move_friction
		if not trying_to_move:
			accel.x = velocity.x * -1 * move_friction
		velocity.y = 0
		end_jump()
		if Input.is_action_just_pressed("ui_accept"):
			is_jumping = true
	if is_jumping:
		if time_in_jump >= jump_time:
			print("ending jump")
			end_jump()
		else:
			print(jump_time/2-time_in_jump)
			if time_in_jump < (jump_time-jump_float_time)/2:
				# up
				velocity.y = -pow(jump_time/2 - time_in_jump, jump_curve) * jump_up_speed
			elif time_in_jump < (jump_time-jump_float_time)/2+jump_float_time:
				# float
				print("floating")
				velocity.y = 0
			else:
				# down
				velocity.y = pow(time_in_jump -jump_time/2, jump_curve) * jump_down_speed
			time_in_jump += delta
	else:
		accel.y = weight
	if is_on_wall():
		velocity.x = 0

func end_jump():
	is_jumping = false
	time_in_jump = 0
func _physics_process(delta):
	get_player_movement(delta)
	velocity += accel * delta
	#print(velocity.y)
	move_and_slide(velocity * delta, -transform.y)
