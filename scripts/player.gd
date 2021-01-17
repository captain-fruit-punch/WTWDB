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
var on_spring = false
export (int)var jump_acceleration = 16000
export (float)var jump_acceleration_time = 0.5
export (int)var jump_liftoff_speed = 7000
signal player_damage
export (float) var javTime = 0
var velocitybuf
var TERMINAL_VELOCITY = 12000

var right_face = true
var selected_item = "javelin"
var JAVELIN_LIMIT = 2
var num_javelins = 0

func _ready():
	num_javelins = 0

func get_player_movement(delta):
	if is_disabled:
		return
	trying_to_move = false
	accel = Vector2()
	if !on_spring:
		if Input.is_action_pressed('ui_right'):
			accel.x += move_accel
			trying_to_move = true
			right_face = true
		if Input.is_action_pressed('ui_left'):
			accel.x -= move_accel
			trying_to_move = true
			right_face = false
		if trying_to_move:
			if abs(velocity.x) >= max_move_speed and  sign(velocity.x) * sign(accel.x) >0:
				accel.x = 0
	accel.y += weight
	if is_on_floor():
		if velocity.y > 400:
			velocitybuf = velocity.y
		velocity.y = 400
		is_jumping = false
		if trying_to_move and sign(velocity.x) * sign(accel.x) <0:
			accel.x *= turnaround_friction
		if not trying_to_move:
			accel.x = velocity.x * -1 * move_friction
		if Input.is_action_pressed("ui_accept"):
			start_jump()
	if is_jumping == true:
		cur_jump_time += delta
		if Input.is_action_pressed("ui_accept"):
			if cur_jump_time <= jump_acceleration_time:
				accel.y -= jump_acceleration 
	if !is_on_floor():
		on_spring = false
	if is_on_wall():
		velocity.x = 0
	if is_on_ceiling():
		cur_jump_time = jump_acceleration_time
		velocity.y = 0
		
	if Input.is_action_just_pressed("actionkey"):
		if selected_item == "javelin":
			javelin_throw()

func javelin_throw():
	if num_javelins < JAVELIN_LIMIT:
		var javthrow = load("res://javelin.tscn")
		var projectile = javthrow.instance()
		get_tree().root.get_child(0).add_child(projectile)
		if right_face:
			projectile.position = Vector2(self.position.x + 16, self.position.y - 5)
			if projectile.has_signal("right_face"):
				projectile.emit_signal("right_face")
		elif !right_face:
			projectile.position = Vector2(self.position.x - 16, self.position.y - 5)
			if projectile.has_signal("left_face"):
				projectile.emit_signal("left_face")
		num_javelins += 1

func start_jump():
	if on_spring:
		velocity.y = -(javTime/30.0 * jump_liftoff_speed + velocitybuf/2.5)
		print("V", velocity.y, "J", javTime/30.0)
		javTime = 0
		on_spring = false
	else:
		velocity.y = -jump_liftoff_speed
	cur_jump_time = 0
	is_jumping = true
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name == "javplatform":
			if collision.collider.has_signal("spring_jump"):
				collision.collider.emit_signal("spring_jump")

func _physics_process(delta):
	get_player_movement(delta)

	velocity += accel * delta
	if velocity.y > TERMINAL_VELOCITY:
		velocity.y = TERMINAL_VELOCITY
	elif velocity.y < -(TERMINAL_VELOCITY):
		velocity.y = -(TERMINAL_VELOCITY)
	move_and_slide(velocity * delta, -transform.y)
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name == "javplatform":
			on_spring = true
			javTime += 1
			get_node("./Sprite").position.y += 1
			if collision.collider.has_signal("javelin_contact"):
				collision.collider.emit_signal("javelin_contact")
	
	if get_node("./Sprite").position.y > 0:
				get_node("./Sprite").position = get_node("./Sprite").position.move_toward(Vector2(0,0),delta*70)


func _on_player_player_damage():
	print("playerdied")
	is_disabled = true
	velocity = Vector2()
	accel = Vector2()
	get_tree().call_group("Player_Spawner", "_player_died")
