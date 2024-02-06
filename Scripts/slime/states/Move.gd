extends State

var hasTarget = false

func enter():
	hasTarget = true
	super.enter()


func physics_update(delta):
	super.physics_update(delta)
	
	entity.apply_gravity(delta)
	
	entity.apply_movement(delta)
	
	if entity.target == null:
		return entity.idleState
		

func exit():
	super.exit()
