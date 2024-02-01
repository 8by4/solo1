extends CharacterBody2D


# Constants
const SPEED = 120
const JUMP_POWER = 300
const GRAVITY = 10
const MAX_DOWN_VEL = 500
const WALL_JUMP_POWER = 500
const WALLJUMP_TIME = 0.2

# Movement Variables
var motion = Vector2(0, 0)
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
			motion.y = -JUMP_POWER
		else:
			if rayCastLeftNode.is_colliding() or rayCastRightNode.is_colliding():
				motion.y = -JUMP_POWER * 0.8
				justWallJumped = true
				timerNode.start(WALLJUMP_TIME)
			
			if rayCastLeftNode.is_colliding():
				motion.x = WALL_JUMP_POWER
			if rayCastRightNode.is_colliding():
				motion.x = -WALL_JUMP_POWER
				
	if not justWallJumped:
		if Input.is_action_pressed("left"):
			motion.x -= SPEED
		elif Input.is_action_pressed("right"):
			motion.x += SPEED
			
		motion.x = lerpf(motion.x, 0.0, 0.3)
	
	motion.y += GRAVITY
	
	if MAX_DOWN_VEL < motion.y:
		motion.y = MAX_DOWN_VEL
	move_and_slide()
