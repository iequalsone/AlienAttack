extends Control

signal resume;

func _ready():
	get_tree().paused = true;

func _on_restart_button_pressed():
	get_tree().paused = false;
	get_tree().reload_current_scene();

func _on_quit_pressed():
	get_tree().quit();
