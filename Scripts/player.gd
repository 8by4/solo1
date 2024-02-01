extends CharacterBody2D


# Constants
const SPEED = 50
const JUMP_POWER = 225
const GRAVITY = 11.5
const MAX_DOWN_VEL = 500
const WALL_JUMP_POWER = 200
const WALLJUMP_TIME = 0.2

# Movement Variables
var justWallJumped = false

# Node References
@onready var rayCastLeftNode = $WallJumper/RayCastLeft
@onready var rayCastRightNode = $WallJumper/RayCastRight
@onready var timerNode = $WallJumper/Timer

func _ready():
	pass

func walljumpTimeout():
	justWallJumped = false

func _process(delta):
	
	# (Wall) Jumping
	if Input.is_action_just_pressed("up"):
		if is_on_floor():
			velocity.y = -JUMP_POWER
		else:
			if rayCastLeftNode.is_colliding() or rayCastRightNode.is_colliding():
				velocity.y = -JUMP_POWER * 0.8
				justWallJumped = true
				timerNode.start(WALLJUMP_TIME)
			
			if rayCastLeftNode.is_colliding():
				velocity.x = WALL_JUMP_POWER
			if rayCastRightNode.is_colliding():
				velocity.x = -WALL_JUMP_POWER
				
	if not justWallJumped:
		if Input.is_action_pressed("left"):
			velocity.x -= SPEED
		elif Input.is_action_pressed("right"):
			velocity.x += SPEED
			
		velocity.x = lerpf(velocity.x, 0.0, 0.3)
	
	velocity.y += GRAVITY
	
	if MAX_DOWN_VEL < velocity.y:
		velocity.y = MAX_DOWN_VEL
	move_and_slide()
