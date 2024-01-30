extends Node

#REFERENCES
@export var monitorScene : PackedScene = preload("res://Scenes/monitor_scene.tscn")
@export var officeScene : PackedScene = preload("res://Scenes/office.tscn")

func SwitchToMonitor() -> void:
	get_tree().change_scene_to_packed(monitorScene)

func SwitchToOffice() -> void:
	get_tree().change_scene_to_packed(officeScene)
	#officeScene.AnimateMonitor()
