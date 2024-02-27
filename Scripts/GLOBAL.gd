extends Node

#GLOBAL VARS
var currentHour : int = 0 # 0 means 12
var currentNight : int = 1
var batteryDecrese : float = 1

#REFERENCES
@export var monitorScene : PackedScene = preload("res://Scenes/monitor_scene.tscn")
@export var officeScene : PackedScene = preload("res://Scenes/office.tscn")

func SwitchToMonitor() -> void:
	get_tree().change_scene_to_packed(monitorScene)

func SwitchToOffice() -> void:
	get_tree().change_scene_to_packed(officeScene)
	#officeScene.AnimateMonitor()

func IncreseHour() -> void:
	currentHour += 1
	if currentHour == 6:
		SignalManager.nightEndSignal.emit()

func GetHourString() -> String:
	if currentHour == 0:
		return "12:00AM"
	return str(currentHour)+":00AM"
