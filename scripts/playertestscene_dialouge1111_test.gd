extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var global_dialouge = $CanvasLayer/Dialouge_Panel
onready var global_player_spawner = $Player_Spawner

signal player_hit_ground

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("player_hit_ground", global_dialouge, "_player_is_ready")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
