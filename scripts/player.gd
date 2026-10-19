extends CharacterBody2D
## The player-controlled kobold. Top-down 8-way movement.

@export var speed: float = 120.0


func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()
