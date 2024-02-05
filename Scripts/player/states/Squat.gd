extends State


func enter():
	super.enter()

func physics_update(delta):
	super.physics_update(delta)
	entity.handle_input()
	entity.apply_movement(delta)
	entity.apply_gravity(delta)
	
	if entity.movement_input != 0:
		return entity.moveState
	
	if Input.is_action_just_pressed("jump"):
		return entity.jumpState
		
	if entity.is_on_floor() and entity.movement_input == 0 and Input.is_action_just_released("down"):
		return entity.idleState
		
	if entity.is_on_floor() and entity.movement_input == 0 and Input.is_action_just_pressed("down"):
		entity.animator.play("squat")
		
func exit():
	super.exit()
