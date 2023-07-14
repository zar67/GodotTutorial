extends CanvasLayer

@onready var hearts_container = $HeartsContainer
@onready var player = $"../Player"

# Called when the node enters the scene tree for the first time.
func _ready():
	hearts_container.SetMaxHearts(player.max_health)
	hearts_container.UpdateHearts(player.current_health)
	player.HealthChanged.connect(hearts_container.UpdateHearts)
	
