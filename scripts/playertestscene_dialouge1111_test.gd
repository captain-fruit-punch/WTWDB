extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var global_dialouge = $CanvasLayer/Dialouge_Panel
onready var global_player_spawner = $Player_Spawner

signal player_stationary

# Called when the node enters the scene tree for the first time.
func _ready():
	global_player_spawner.player.connect("player_stationary", global_dialouge, "_player_is_ready")
	global_dialouge.connect("dialouge_starting", global_player_spawner, "disable_player")
	global_dialouge.connect("dialouge_ending", global_player_spawner, "enable_player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
