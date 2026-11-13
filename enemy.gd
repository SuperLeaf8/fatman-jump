extends CharacterBody2D

@export
var speed: float
@export
var gravity: int
@export
var max_distance: int

var timer: Timer
var rng = RandomNumberGenerator.new()
var distance: int
var animation: AnimatedSprite2D
func _ready():
	timer = get_node("Timer")
	animation = get_node("AnimatedSprite2D")

var walk_time
var time_elapsed
var walking: bool
# whole idea is to calculate the amount of time the carrot must walk
func _physics_process(delta: float) -> void:
	if walking:
		time_elapsed += delta # keep track of time since started walking
		velocity.x = sign(distance) * speed # keep moving
		if time_elapsed >= walk_time:
			walking = false
			timer.start() # short idle
	else:
		velocity.x = 0
	
	if velocity.x and is_on_floor(): # sprite stuff, just like player
		animation.play()
		if velocity.x > 0:
			animation.flip_h = false
		else:
			animation.flip_h = true
	elif is_on_floor():
		animation.set_frame_and_progress(0, 0.0)
	else:
		animation.set_frame_and_progress(3, 0.0)
	
	velocity.y += gravity * delta # gravity
	move_and_slide()


func _on_timer_timeout() -> void: # idle time is over, start walking
	distance = rng.randi_range(-max_distance, max_distance) # rng the distance to walk
	walk_time = distance/speed
	time_elapsed = 0
	walking = true
