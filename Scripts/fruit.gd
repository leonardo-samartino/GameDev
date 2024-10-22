extends Node2D







func _on_area_2d_body_entered(body):
	
	if body.name == "Player":
		Collected()
	
	
	pass 



func Collected():
	
	Global.score += 1
	$AnimatedSprite2D.play("Collected")
	$Area2D/CollisionShape2D.queue_free()
	await get_tree().create_timer(0.8).timeout
	queue_free()
	
	
	pass
