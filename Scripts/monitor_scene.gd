extends Node2D

# Decide the direction to move
var moveToLeft : bool = false
var cameraSpeed : int = 1

@export var btnGroup : ButtonGroup

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	MoveCameraAuto()

# Move the camera auto.
func MoveCameraAuto() -> void:
	if $Camera.position.x < 473 or $Camera.position.x > 780:
		cameraSpeed = -cameraSpeed
	$Camera.position.x += cameraSpeed
