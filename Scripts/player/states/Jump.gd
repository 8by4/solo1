extends State


# Called when the node enters the scene tree for the first time.
func enter():
	super.enter()
	entity.velocity.y = -entity.JUMP_POWER
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta):
	super.physics_update(delta)
	
	
	entity.handle_input()
	entity.apply_movement(delta)
	entity.apply_gravity(delta)
	
	if entity.velocity.y < -entity.releaseJumpVelocity and Input.is_action_just_released("jump"):
		entity.velocity.y = -entity.releaseJumpVelocity
	
	if entity.is_on_floor() and entity.movement_input != 0:
		return entity.moveState
		
	if entity.is_on_floor() and entity.movement_input == 0:
		return entity.idleState
		
	if entity.rayCastLeftNode.is_colliding() or entity.rayCastRightNode.is_colliding():
		if Input.is_action_just_pressed("jump"):
			return entity.wallJumpState

func exit():
	super.exit()
