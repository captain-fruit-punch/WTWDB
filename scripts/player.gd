extends KinematicBody2D

class_name Player

export (int) var max_move_speed = 5000
export (int) var move_accel = 7000
export (float) var move_friction = 15
export (float) var turnaround_friction = 5
export (int) var weight = 18000
export (int) var max_fall_speed = 300
var trying_to_move = false
var velocity = Vector2()
var accel = Vector2()
var is_jumping = false
var cur_jump_time = 0
var is_disabled = false
export (int)var jump_acceleration = 16000
export (float)var jump_acceleration_time = 0.5
export (int)var jump_liftoff_speed = 7000
signal player_damage

func _ready():
	pass

func get_player_movement(delta):
	if is_disabled:
		return
	trying_to_move = false
	accel = Vector2()
	if Input.is_action_pressed('ui_right'):
		accel.x += move_accel
		trying_to_move = true
	if Input.is_action_pressed('ui_left'):
		accel.x -= move_accel
		trying_to_move = true
	if trying_to_move:
		if abs(velocity.x) >= max_move_speed and  sign(velocity.x) * sign(accel.x) >0:
			accel.x = 0
	accel.y += weight
	if is_on_floor():
		is_jumping = false
		if trying_to_move and sign(velocity.x) * sign(accel.x) <0:
			accel.x *= turnaround_friction
		if not trying_to_move:
			accel.x = velocity.x * -1 * move_friction
		velocity.y = 0
		if Input.is_action_pressed("ui_accept"):
			start_jump()
	if is_jumping == true:
		cur_jump_time += delta
		if Input.is_action_pressed("ui_accept"):
			if cur_jump_time <= jump_acceleration_time:
				accel.y -= jump_acceleration 
	if is_on_wall():
		velocity.x = 0
	if is_on_ceiling():
		velocity.y = 0

func start_jump():
	velocity.y -= jump_liftoff_speed
	cur_jump_time = 0
	is_jumping = true

func _physics_process(delta):
	get_player_movement(delta)

	velocity += accel * delta
	move_and_slide(velocity * delta, -transform.y)


func _on_player_player_damage():
	print("playerdied")
	is_disabled = true
	velocity = Vector2()
	accel = Vector2()
	get_tree().call_group("Player_Spawner", "_player_died")
