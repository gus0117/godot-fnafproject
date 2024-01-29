extends Node2D

# Decide the direction to move
var moveToLeft : bool = false
var cameraSpeed : int = 2

@export var btnGroup : ButtonGroup

# Called when the node enters the scene tree for the first time.
func _ready():
	var buttons: Array[BaseButton] = btnGroup.get_buttons()
	buttons[0].button_pressed = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	MoveCameraAuto()

# Move the camera auto.
func MoveCameraAuto() -> void:
	if $Camera.position.x < 473 or $Camera.position.x > 780:
		cameraSpeed = -cameraSpeed
	$Camera.position.x += cameraSpeed
