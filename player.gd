extends CharacterBody2D


@export
var gravity: int
@export
var jump_power: int
@export
var acceleration: int
@export
var max_speed: int

var animation: AnimatedSprite2D
func _ready():
	animation = get_node("AnimatedSprite2D")

var xy_vector
func _physics_process(delta: float) -> void:
	xy_vector = Input.get_axis("move_left", "move_right") # x and y movement
	if xy_vector and is_on_floor():
		animation.play("run")
		if (velocity.x * xy_vector) < 0:
			velocity.x = 0 # if player switches around, briefly kill all velocity
	elif xy_vector == 0: # kill all velocity if player is idle
		animation.play("idle")
		if is_on_floor():
			velocity.x = 0
	if xy_vector > 0: # flipping animation to match direction
			animation.flip_h = false
	elif xy_vector < 0:
		animation.flip_h = true
	
	velocity.x += xy_vector * acceleration * delta # accelerate player
	velocity.x = clamp(velocity.x, -max_speed, max_speed) # clamp max speed
	
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = -jump_power # make player jump
	
	if not is_on_floor(): # player is in the air
		animation.animation = "jump" # use jump frames
		if velocity.y > 50:
			animation.frame = 2
		elif (-50 < velocity.y and velocity.y < 50):
			animation.frame = 1
		elif velocity.y < -50:
			animation.frame = 0
		animation.frame_progress = 0.0
	
	
	velocity.y += gravity * delta # gravity
	
	move_and_slide()



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Enemy":
		if velocity.y > 20: # if player is falling...
			body.queue_free() # kill enemy and
			velocity.y = -100  # bounce
		else:
			pass # take damage, later technique
