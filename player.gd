extends CharacterBody2D


@export
var gravity: int
@export
var jump_power: int
@export
var acceleration: int

var animation: AnimatedSprite2D
func _ready():
	animation = get_node("AnimatedSprite2D")

var xy_vector
func _physics_process(delta: float) -> void:
	xy_vector = Input.get_axis("move_left", "move_right")
	if xy_vector and is_on_floor():
		animation.play("run")
		if (velocity.x * xy_vector) < 0:
			velocity.x = 0
	elif xy_vector == 0:
		animation.play("idle")
		if is_on_floor():
			velocity.x = 0
	if xy_vector > 0:
			animation.flip_h = false
	elif xy_vector < 0:
		animation.flip_h = true
	
	velocity.x += xy_vector * acceleration * delta
	velocity.x = clamp(velocity.x, -200, 200)
	
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y -= jump_power
	
	if not is_on_floor():
		animation.animation = "jump"
		if velocity.y > 50:
			animation.frame = 2
		elif (-50 < velocity.y and velocity.y < 50):
			animation.frame = 1
		elif velocity.y < -50:
			animation.frame = 0
		animation.frame_progress = 0.0
	
	
	velocity.y += gravity * delta # gravity
	
	move_and_slide()
