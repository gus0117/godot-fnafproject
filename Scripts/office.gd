extends Node2D

const CAM_SPEED: float = 10

var isLeftSide: bool = false
var isRightSide: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	MoveCamera(isLeftSide, isRightSide)


func _on_left_side_mouse_entered():
	isLeftSide = true


func _on_left_side_mouse_exited():
	isLeftSide = false

func _on_right_side_mouse_entered():
	isRightSide = true

func _on_right_side_mouse_exited():
	isRightSide = false


func MoveCamera(isLeft: bool, isRight: bool) -> void:
	if(isLeft and $Camera.position.x > 430):
		$Camera.position.x -= CAM_SPEED
	elif(isRight and $Camera.position.x < 780):
		$Camera.position.x += CAM_SPEED
