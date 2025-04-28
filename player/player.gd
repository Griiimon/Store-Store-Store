class_name Player
extends RigidBody3D

@export var speed: float= 3.0

@onready var model: Node3D = $Model
@onready var nose: MeshInstance3D = %Nose

@onready var camera_parent: Node3D = $"Camera Parent"

@onready var hands_offset: Node3D = %"Hands Offset"
@onready var right_hand: MeshInstance3D = %"Right Hand"
@onready var left_hand: MeshInstance3D = %"Left Hand"

@onready var orig_hand_offset_pos: Vector3= hands_offset.position
@onready var orig_right_hand_pos: Vector3= right_hand.position
@onready var orig_left_hand_pos: Vector3= left_hand.position

@onready var carry_large_offset: Node3D = %"Carry Large Offset"
@onready var carry_small_offset: Node3D = %"Carry Small Offset"

@onready var crate_shape_cast: ShapeCast3D = %"Crate ShapeCast"

var carried_crate: Crate



func _ready() -> void:
	camera_parent.top_level= true


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("tilt_camera"):
		var dx: float= sign(int((nose.global_position.x - global_position.x) * 10))
		var dz: float= sign(int((nose.global_position.z - global_position.z) * 10))
		var tilt_factor: float= 0.5
		camera_parent.rotation.z= dx * tilt_factor
		camera_parent.rotation.x= -dz * tilt_factor
	else:
		camera_parent.rotation= Vector3.ZERO


func get_speed()-> float:
	return speed
