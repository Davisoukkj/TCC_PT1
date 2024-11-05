extends CharacterBody3D
class_name Player

enum states{
	walking,
	sneaking,
	inAir,
	standing,
	jumping
}

const SPEED = 4.5
const JUMP_VELOCITY = 3
@export var sensitivity = 2.5
var flashLightIsOut : bool
var LightLevel : float
var wasInAir : bool
@export var mouse_sensitivity := 0.2
@onready var  raycast = $RayCast3D
var looking_pluger : bool = false


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready(): #MOUSE PRESO NA TELA
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event): #PRIMEIRA PESSOA
	if (event is InputEventMouseMotion):
		rotation.y -= event.relative.x / 1000 * sensitivity
		$Camera3D.rotation.x -= event.relative.y / 1000 * sensitivity
		rotation.x = clamp(rotation.x, PI/-0.50, PI/0.50)
		$Camera3D.rotation.x = clamp($Camera3D.rotation.x, -0.50, 0.50)
		if Input.is_action_just_pressed("ui_cancel"):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta): #MOVIMENTAÇÃO
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var speed = SPEED
	
	
	if Input.is_action_just_pressed("FlashLight"):
		if flashLightIsOut:
			$AnimationPlayer.play("FlashLightShow")
		else:
			$AnimationPlayer.play("FlashLightHide")
		flashLightIsOut = !flashLightIsOut
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	
	move_and_slide()
	




