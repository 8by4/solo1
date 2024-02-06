extends State

func enter():
	super.enter()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta):
	super.physics_update(delta)
	
	entity.apply_gravity(delta)
	entity.velocity.x = 0
	
	if entity.target is Player:
		return entity.moveState

func exit():
	super.exit()
