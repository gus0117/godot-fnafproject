extends Control

signal energy_used

# Called when the node enters the scene tree for the first time.
func _ready():
	$PowerLeft.set_value_no_signal(99)
	$Usage.set_value_no_signal(20)

func UseBattery() -> void:
	Global.batteryDecrese += 1
	$Usage.value += $Usage.Step
	print("Entered useBattery")

func _on_battery_timer_timeout():
	var val = $PowerLeft.value
	$PowerLeft.set_value_no_signal(val - Global.batteryDecrese)
