extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player
var player_scene = preload("res://player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var findingPlayer = get_tree().current_scene.get_node_or_null("Player")
	if(findingPlayer):
		player = findingPlayer
	else:
		_spawn_player()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _player_died():
	$death_timer.start()

func _spawn_player():
	var tempName
	if player :
		tempName = player.name
		player.name = "DeadPlayer"
	
	player = player_scene.instance()
	get_tree().current_scene.add_child(player)
	player.transform = transform
	if tempName :
		player.name = tempName
	print(player.name)


func _on_death_timer_timeout():
	print("death complete")
	player.queue_free()
	_spawn_player()
