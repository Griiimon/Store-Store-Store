class_name Crate
extends RigidBody3D

enum Size { LARGE, SMALL }

@export var symbol_scenes: Array[PackedScene]

@export var size: Size
@export var randomize: bool= false

@onready var mesh_instance_base: MeshInstance3D = $"MeshInstance Base"
@onready var collision_shape: CollisionShape3D = $CollisionShape3D

@onready var remote_transform_collision_shape: RemoteTransform3D = $"RemoteTransform CollisionShape"

var type: CrateType



func _ready() -> void:
	if randomize:
		init(CrateType.create_random())


func init(_type: CrateType):
	type= _type
	init_color()
	init_symbol()


func picked_up(player: Player):
	freeze= true
	collision_shape.reparent(player)

	remote_transform_collision_shape.remote_path= remote_transform_collision_shape.get_path_to(collision_shape)


func init_color():
	mesh_instance_base.set_surface_override_material(0, type.get_material())


func init_symbol():
	var symbol_template: Node3D= symbol_scenes[int(type.symbol)].instantiate()

	for i in 4:
		var symbol_instance: Node3D= symbol_template.duplicate()
		symbol_instance.get_child(0).position.z= 0.45
		add_child(symbol_instance)
		symbol_instance.rotate_y(deg_to_rad(i * 90))

	symbol_template.queue_free()
