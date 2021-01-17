extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal special_button_activated(num)
var button_id

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("button_down", self, "_button_activated")


func _button_activated():
	emit_signal("special_button_activated", button_id)
