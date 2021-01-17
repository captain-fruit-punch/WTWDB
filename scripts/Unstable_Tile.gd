extends RigidBody2D

func _on_Timer_timeout():
	print("hi")


func _on_Unstable_Tile_body_entered(body):
	print("hi")
	if body:
		$Timer.start()
