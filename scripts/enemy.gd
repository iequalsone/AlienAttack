extends Area2D

signal died;

@export var speed = 200;

func _physics_process(delta):
	global_position.x += -speed * delta;

func die():
	Global.camera.shake(0.2, 6);
	emit_signal("died");
	queue_free();

func _on_body_entered(body):
	body.take_damage();
	die();