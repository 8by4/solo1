extends CharacterBody2D
class_name Enemy

const SPEED = 35
const GRAVITY = 250
const MAX_DOWN_VEL = 500

var playerLocation
var target
var movement

#States
@onready var stateManager = $StateManager
@onready var idleState = $StateManager/Idle
@onready var moveState = $StateManager/Move

@onready var animator = $AnimationPlayer

func _ready():
	#State Manager connection
	stateManager.init(self)

func _physics_process(delta):
	stateManager.physics_update(delta)
	
	move_and_slide()
	

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

func apply_movement(delta):
	if target != null:
		playerLocation = target.global_position.x - self.global_position.x
		
		if playerLocation < 0:
			movement = -1
		if playerLocation > 0:
			movement = 1
			
			
		if is_on_floor():
			velocity.x = movement * SPEED
		else:
			velocity.x = lerp(velocity.x, movement * SPEED, 5 * delta)

func _on_player_dectection_body_entered(body):
	if body is Player:
		target = body


func _on_player_dectection_body_exited(body):
	if body is Player:
		target = null
