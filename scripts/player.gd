extends CharacterBody3D
## The player-controlled kobold. Moves on the ground plane (X/Z) like a
## top-down 2D character, but is drawn with 3D voxel models.

@export var speed: float = 4.0

@onready var _front_model: Node3D = $Visual/Front
@onready var _side_model: Node3D = $Visual/Side
@onready var _anim: AnimationPlayer = $AnimationPlayer


func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = Vector3(direction.x, 0.0, direction.y) * speed
	move_and_slide()
	_update_visuals(direction)


func _update_visuals(direction: Vector2) -> void:
	if direction == Vector2.ZERO:
		_show_front(true)
		_anim.play("idle", 0.15)
		return

	# Use the side view whenever there is horizontal movement, and the
	# front view when walking straight up or down.
	var moving_sideways := absf(direction.x) > 0.01
	_show_front(not moving_sideways)
	if moving_sideways:
		# The side model faces right; turn it around to face left.
		_side_model.rotation.y = 0.0 if direction.x > 0.0 else PI
	_anim.play("walk")


func _show_front(front: bool) -> void:
	_front_model.visible = front
	_side_model.visible = not front
