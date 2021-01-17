extends Node2D

func _process(delta):
	$Label.text = str($Breaking_Timer.time_left)

func _on_Break_Detection_body_entered(body):
	if(body.is_in_group("activate_breaking_platforms")) and $Breaking_Timer.time_left <= 0 and $Regen_Timer.time_left <= 0:
		print("started breaking")
		$Unstable_Tile_Collider/AnimatedSprite.animation = "unsteady"
		$Breaking_Timer.start()

func _on_Regen_Timer_timeout():
	$Unstable_Tile_Collider.visible = true
	$Unstable_Tile_Collider/CollisionShape2D.disabled = false
	$Unstable_Tile_Collider/AnimatedSprite.animation = "steady"

func _on_Breaking_Timer_timeout():
	$Unstable_Tile_Collider.visible = false
	$Unstable_Tile_Collider/CollisionShape2D.disabled = true
	$Regen_Timer.start()


func _on_Break_Detection_body_exited(body):
	pass
