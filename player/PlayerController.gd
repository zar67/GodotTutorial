extends CharacterBody2D

signal HealthChanged

@export var speed: int = 35 # Public variable editable in the inspector
@onready var animations = $AnimationPlayer # Reference to the AnimationPlayer node
@onready var effect_animations = $EffectAnimations # Reference to the EffectsAnimations
@onready var hurt_timer = $HurtTimer

@export var max_health: int = 3
@onready var current_health: int = max_health

@export var knockback_power = 500

func _ready():
	effect_animations.play("RESET")

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
			
		HealthChanged.emit(current_health)
		Knockback(area.get_parent().velocity)
		
		effect_animations.play("hurt_blink")
		hurt_timer.start()
		await hurt_timer.timeout
		effect_animations.play("RESET")

func Knockback(enemy_velocity: Vector2):
	var knockbackDir = (enemy_velocity - velocity).normalized() * knockback_power
	velocity = knockbackDir
	move_and_slide()
