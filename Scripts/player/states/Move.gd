extends State


func enter():
	if entity.stateManager.previous_state == entity.jumpState:
		entity.animator.play("Land")
	else:
		super.enter()

func physics_update(delta):
	super.physics_update(delta)
	
	entity.handle_input()
	entity.apply_movement(delta)
	entity.apply_gravity(delta)
	
	if entity.movement_input == 0:
		return entity.idleState
	
	if Input.is_action_just_pressed("jump"):
		return entity.jumpState
		

func exit():
	super.exit()


func _on_animation_player_animation_finished(anim_name):
	if entity.stateManager.current_state == entity.moveState:
		if anim_name == "Land":
			entity.animator.play("Move")
