extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var prompt_array = []
var return_obj

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _sent_dialouge(title, text, profile, _prompt_array, _return_obj = null):
	for i in $Panel/VSplitContainer/CenterContainer/Response_Container.get_children():
		i.queue_free()
	$Panel/VSplitContainer/Title.text = title
	$Panel/VSplitContainer/Text.text = text
	if(profile):
		$Panel/Profile_Picture.texture = profile
	prompt_array = _prompt_array
	return_obj = _return_obj
	_show_buttons()

func _start_interaction():
	pass
	
func _player_is_ready():
	pass

func _show_buttons():
	for i in range(0, prompt_array.size()):
		var newbutton = $Panel/Button_Template.duplicate()
		$Panel/VSplitContainer/CenterContainer/Response_Container.add_child(newbutton)
		newbutton.visible = true
		newbutton.name = str(i)
		newbutton.text = prompt_array[i]
		newbutton.connect("special_button_activated", self, "_button_pressed")

func _button_pressed(num):
	if(return_obj):
		return_obj.emit_signal("dialogue_response", num)
