extends CharacterBody2D

signal took_damage;

var speed = 300;
var rocket_scene = preload("res://scenes/rocket.tscn");
var lazer_scene = preload("res://scenes/lazer.tscn");

@onready var rocket_container = $RocketContainer; #get_node("RocketContainer")
@onready var rocket_shot_sound = $RocketShotSound;

@onready var lazer_container = $LazerContainer;

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot();
		
	if Input.is_action_just_pressed("shoot_lazer"):
		shoot_lazer();

func _physics_process(delta):
	velocity = Vector2(0, 0);
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed;
	if Input.is_action_pressed("move_right"):
		velocity.x = speed;
	if Input.is_action_pressed("move_up"):
		velocity.y = -speed;
	if Input.is_action_pressed("move_down"):
		velocity.y = speed;

	move_and_slide()
	
	var screen_size = get_viewport_rect().size;
	global_position = global_position.clamp(Vector2(0,0), screen_size);

func shoot():
	var rocket_instance = rocket_scene.instantiate();
	rocket_container.add_child(rocket_instance);
	rocket_instance.global_position = global_position;
	rocket_instance.global_position.x += 80;
	rocket_shot_sound.play();
	
func shoot_lazer():
	var lazer_instance = lazer_scene.instantiate();
	lazer_container.add_child(lazer_instance);
	lazer_instance.global_position = global_position;
	lazer_instance.global_position.x += 80;
	
func take_damage():
	Global.camera.shake(0.2, 6);
	emit_signal("took_damage");
	
func die():
	Global.camera.shake(0.2, 8);
	queue_free();
