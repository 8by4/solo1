extends Node2D
var active


func _input(event):
	# torch activation
	if active == true:
		if Input.is_action_just_pressed("interaction"):
			$AnimationPlayer.play("ignite")
			$AnimationPlayer.play("")
			$Lighting.texture_scale = 3
			$Smoke.visible = true
func _on_interaction_area_body_entered(body):
	if body.name == 'Player':
		active = true
