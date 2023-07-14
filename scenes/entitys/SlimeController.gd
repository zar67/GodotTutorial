extends CharacterBody2D

@export var speed = 20
@export var limit = 0.5
@export var endPoint: Marker2D

@onready var animations = $AnimationPlayer

var startPosition
var endPosition

func _ready():
	startPosition = position
	endPosition = endPoint.global_position
	
func ChangeDirection():
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd
	
func UpdateVelocity():
	var moveDirection = endPosition - position
	
	if moveDirection.length() < limit:
		ChangeDirection()
	
	velocity = moveDirection.normalized() * speed

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
	animations.play("walk_" + direction)

func _physics_process(delta):
	UpdateVelocity()
	move_and_slide()
	UpdateAnimation()
