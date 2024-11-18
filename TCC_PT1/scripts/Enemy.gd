extends CharacterBody3D




const SPEED = 170.0
const CHASE_RANGE = 5000.0

@export var target : CharacterBody3D
@onready var nav_agent = $Nav_agent

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	velocity = Vector3.ZERO
	
	if global_position.distance_to(target.global_position) < CHASE_RANGE:
		nav_agent.set_target_position(target.global_transform.origin)
		var next_nav_point = nav_agent.get_next_path_position()
		velocity = (next_nav_point - global_transform.origin).normalized() * SPEED * delta
		look_at(Vector3(target.global_position.x, global_position.y, target.global_position.z), Vector3.UP)
	
	move_and_slide()
