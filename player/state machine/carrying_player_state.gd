class_name CarryingPlayerState
extends PlayerStateMachineState

signal drop



func on_physics_process(delta: float):
	if Input.is_action_just_pressed("drop"):
		drop.emit()
		return
	default_movement(delta)


func restore_model_transform()-> bool:
	var query:= PhysicsShapeQueryParameters3D.new()
	query.collision_mask= CollisionLayers.CRATES
	query.transform= player.carry_large_offset.global_transform
	query.shape= player.carried_crate.collision_shape.shape

	var result= player.get_world_3d().direct_space_state.intersect_shape(query)
	
	return not result.is_empty()


func force_smooth_turn()-> bool:
	return true
