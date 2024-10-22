extends Area2D





func _on_body_entered(body):
	
	if body.name == "Player":
		Global.life -= 1
		Global.score = 0
		await get_tree().create_timer(0.5).timeout
		get_tree().reload_current_scene()
	
	pass
