extends HBoxContainer

@onready var heart_gui_class = preload("res://scenes/gui/heart_gui.tscn")

func SetMaxHearts(max: int):
	for i in range(max):
		var heart = heart_gui_class.instantiate()
		add_child(heart)

func UpdateHearts(current: int):
	var hearts = get_children()
	
	for i in range(current):
		hearts[i].Update(true)
		
	for i in range(current, hearts.size()):
		hearts[i].Update(false)
