extends Panel

@onready var sprite = $Sprite2D

func Update(full: bool):
	if full: sprite.frame = 0
	else: sprite.frame = 4
