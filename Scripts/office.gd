extends Node2D

const CAM_SPEED: float = 10

var isLeftSide: bool = false
var isRightSide: bool = false

var isLeftDoorOn: bool = false
var isLeftLightOn: bool = false
var isRightDoorOn: bool = false
var isRightLightOn: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$SFX/Ambience.play()
	$SFX/FanSFX.play()


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
	if(isLeft and $Camera.position.x > 473):
		$Camera.position.x -= CAM_SPEED
	elif(isRight and $Camera.position.x < 780):
		$Camera.position.x += CAM_SPEED

func AnimateButtons(door: bool, light: bool, sprite: AnimatedSprite2D) -> void:
	if not door and not light:
		sprite.play("stopped")
		return
	if door and not light:
		sprite.play("door")
		return
	if not door and light:
		sprite.play("light")
		return
	if door and light:
		sprite.play("both")
		return

func AnimateDoors(doorOpen: bool, sprite: AnimatedSprite2D) -> void:
	$SFX/DoorSFX.play()
	if(doorOpen):
		sprite.play("close")
		return
	if(not doorOpen):
		sprite.play_backwards("close")
		return

func AnimateLights(left: bool, right: bool) -> void:
	if(not left and not right):
		$Animations/Lights.play("default")
		$SFX/BuzzLightsSFX.stop()
		return
	$SFX/BuzzLightsSFX.play()
	if(left):
		$Animations/Lights.play("leftLights")
		return
	if(right):
		$Animations/Lights.play("rightLights")
		return

func _on_left_door_btn_pressed():
	isLeftDoorOn = not isLeftDoorOn
	AnimateButtons(isLeftDoorOn, isLeftLightOn, $Buttons/LeftButtons/LeftBtnSprite)
	AnimateDoors(isLeftDoorOn, $Doors/LeftDoor)


func _on_left_light_btn_pressed():
	isLeftLightOn = not isLeftLightOn
	if isRightLightOn:
		isRightLightOn = false
		AnimateButtons(isRightDoorOn, isRightLightOn, $Buttons/RightButtons/RightBtnSprite)
	AnimateButtons(isLeftDoorOn, isLeftLightOn, $Buttons/LeftButtons/LeftBtnSprite)
	AnimateLights(isLeftLightOn, isRightLightOn)


func _on_right_door_btn_pressed():
	isRightDoorOn = not isRightDoorOn
	AnimateButtons(isRightDoorOn, isRightLightOn, $Buttons/RightButtons/RightBtnSprite)
	AnimateDoors(isRightDoorOn, $Doors/RigthDoor)


func _on_right_light_btn_pressed():
	isRightLightOn = not isRightLightOn
	if isLeftLightOn:
		isLeftLightOn = false
		AnimateButtons(isLeftDoorOn, isLeftLightOn, $Buttons/LeftButtons/LeftBtnSprite)
	AnimateButtons(isRightDoorOn, isRightLightOn, $Buttons/RightButtons/RightBtnSprite)
	AnimateLights(isLeftLightOn, isRightLightOn)
