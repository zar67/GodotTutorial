extends CharacterBody2D

@export var speed: int = 35 # Public variable editable in the inspector
@onready var animations = $AnimationPlayer # Reference to the AnimationPlayer node

# Custom functino for fetching the current input
func HandleInput():
	# Get Movement Direction From Input
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# Set CharacterBody2D's Velocity
	velocity = moveDirection * speed

# Custom function to update the animation
func UpdateAnimation():
	if velocity.length() == 0 && animations.is_playing():
		animations.stop()
		return
	
	var direction = "down"
	
	if velocity.x < 0:
		direction = "left"
	elif velocity.x > 0: 
		direction = "right"
	elif velocity.y < 0:
		direction = "up"
		
	# Calling play on the AnimationPlayer node
	animations.play("player_walk_" + direction)

# Built in function like FixedUpdate in Unity
func _physics_process(delta):
	HandleInput()
	UpdateAnimation()
	
	# Function of CharacterBody2D to apply velocity
	move_and_slide()
