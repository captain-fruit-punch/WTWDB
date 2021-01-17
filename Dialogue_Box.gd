extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var prompt_array = []
var return_obj

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _sent_dialouge(title, text, profile, _prompt_array, _return_obj):
	$Panel/VSplitContainer/Title.text = title
	$Panel/VSplitContainer/Text.text = text
	$Panel/Profile_Picture.texture = profile
	prompt_array = _prompt_array
	return_obj = _return_obj

func _show_buttons():
	for i in prompt_array:
		var newbutton = $Panel/Button_Template.duplicate()
		$Panel/VSplitContainer/CenterContainer/Response_Container.add_child(newbutton)
