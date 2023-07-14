extends CharacterBody2D

@export var speed: int = 35 # Public variable editable in the inspector
@onready var animations = $AnimationPlayer # Reference to the AnimationPlayer node

@export var max_health: int = 3
@onready var current_health: int = max_health

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
func _physics_process(_delta):
	HandleInput()
	
	# Function of CharacterBody2D to apply velocity
	move_and_slide()
	
	UpdateAnimation()

func _on_hit_box_area_entered(area):
	if area.name == "HitBox":
		current_health -= 1
		if (current_health < 0):
			current_health = max_health
		print_debug(current_health)
