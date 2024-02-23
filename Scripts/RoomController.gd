class_name FrameController

extends AnimatedSprite2D

func SwitchFrame(anim: String, f: int) -> void:
	set_animation(anim)
	set_frame(f)

func ResetFrame() -> void:
	animation = "state"
	frame = 0
