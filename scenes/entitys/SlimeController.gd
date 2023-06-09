extends CharacterBody2D

@export var speed = 20
@export var limit = 0.5

@onready var animations = $AnimatedSprite2D

var startPosition
var endPosition

func _ready():
	startPosition = position
	endPosition = startPosition + Vector2(0, 3*16)
	
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
	var animationString = "walk_up"
	
	if velocity.y > 0:
		animationString = "walk_down"
		
	animations.play(animationString)

func _physics_process(delta):
	UpdateVelocity()
	move_and_slide()
	UpdateAnimation()
