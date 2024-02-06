extends Node2D
var active = false
var lit = false

func _input(event):
	# torch activation
	if active == true:
		if lit == true:
			if Input.is_action_just_pressed("interaction"):
				$AnimationPlayer.play("extinguished")
				$AnimationPlayer.stop()
			
				$Lighting.visible = false
				$Smoke.visible = false
			
				lit = false
			
		elif Input.is_action_just_pressed("interaction"):
			$AnimationPlayer.play("ignite")
			$AnimationPlayer.stop()
			$AnimationPlayer.play("torchOn")
			
			$Lighting.visible = true
			$Lighting.texture_scale = 3
			$Smoke.visible = true
			
			lit = true
			

func _on_interaction_area_body_entered(body):
	if body.name == 'Player':
		active = true

func _on_interaction_area_body_exited(body):
	if body.name == 'Player':
		active = false
