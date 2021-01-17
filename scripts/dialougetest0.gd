extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal dialogue_response(num)

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("dialogue_response", self, "_response")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if (body.name=="Player"):
		get_tree().root.get_child(0).global_dialouge._sent_dialouge("hello", "testing", null, ["texthere", "textthere"], self)

func _response(num):
	get_tree().root.get_child(0).global_dialouge._sent_dialouge("next screen", "ads", null, ["rgr", "texttesfhere"], self)
