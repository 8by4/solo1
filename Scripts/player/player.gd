extends CharacterBody2D


# Constants
const SPEED = 90
const JUMP_POWER = 120
const GRAVITY = 250
const MAX_DOWN_VEL = 500
const WALL_JUMP_POWER = 190
const WALLJUMP_TIME = 0.2

# Variables
var justWallJumped = false
var movement_input : float
var releaseJumpVelocity = 60

#States
@onready var stateManager = $StateManager
@onready var moveState = $StateManager/Move
@onready var idleState = $StateManager/Idle
@onready var jumpState = $StateManager/Jump
@onready var wallJumpState = $StateManager/WallJump
@onready var squatState = $StateManager/Squat

@onready var animator = $AnimationPlayer

# Node References
@onready var rayCastLeftNode = $WallJumper/RayCastLeft
@onready var rayCastRightNode = $WallJumper/RayCastRight
@onready var timerNode = $WallJumper/Timer

func _ready():
	#State Manager connection
	stateManager.init(self)

func walljumpTimeout():
	justWallJumped = false



func _physics_process(delta):
	#calling SM physics update
	stateManager.physics_update(delta)
	
	move_and_slide()
	

func handle_input() -> void:
	movement_input = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	if movement_input > 0:
		$Sprite2D.flip_h = false
	if movement_input < 0:
		$Sprite2D.flip_h = true

func apply_movement(delta):
	if is_on_floor():
		velocity.x = movement_input * SPEED
	else:
		velocity.x = lerp(velocity.x, movement_input * SPEED, 5 * delta)

func apply_gravity(delta):
	if !is_on_floor():
		if velocity.y > 0:
			velocity.y += GRAVITY * 1.5 * delta
		else:
			velocity.y += GRAVITY * delta
	else:
		velocity.y = 1
		
	if MAX_DOWN_VEL < velocity.y:
		velocity.y = MAX_DOWN_VEL

