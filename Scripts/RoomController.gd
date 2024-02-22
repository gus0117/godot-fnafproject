class_name FrameController

extends AnimatedSprite2D

func SwitchFrame(anim: String, f: int) -> void:
	animation = anim
	frame = f

func ResetFrame() -> void:
	animation = "state"
	frame = 0
