extends State

func enter():
	super.enter()
	
	entity.justWallJumped = true
	entity.timerNode.start(entity.WALLJUMP_TIME)
	
	if entity.rayCastLeftNode.is_colliding():
		entity.velocity.x = entity.WALL_JUMP_POWER
	if entity.rayCastRightNode.is_colliding():
		entity.velocity.x = -entity.WALL_JUMP_POWER
		
	entity.velocity.y = -entity.JUMP_POWER * 0.8
	
func physics_update(delta):
	super.physics_update(delta)
	
	entity.apply_movement(delta)
	entity.apply_gravity(delta)
	if entity.justWallJumped == false:
		entity.handle_input()
		
	if entity.is_on_floor() and entity.movement_input != 0:
		return entity.moveState
		
	if entity.is_on_floor() and entity.movement_input == 0:
		return entity.idleState
		
	if entity.rayCastLeftNode.is_colliding() or entity.rayCastRightNode.is_colliding():
		if Input.is_action_just_pressed("jump"):
			return entity.wallJumpState

func exit():
	super.exit()
