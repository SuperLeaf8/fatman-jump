extends Node2D

@export
var camera: Camera2D
var origin: Vector2
var cam_origin: Vector2
func _ready():
	origin = position
	cam_origin = camera.get_screen_center_position()

func _process(_delta: float) -> void:
	position.x = (camera.get_screen_center_position().x - cam_origin.x) * 0.5 + origin.x
