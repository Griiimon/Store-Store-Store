class_name DefaultPlayerState
extends PlayerStateMachineState

signal pick_up


func on_physics_process(delta: float):
	if Input.is_action_just_pressed("pick_up"):
		if player.crate_shape_cast.is_colliding():
			#player.pick_up_crate(player.crate_shape_cast.get_collider(0))
			pick_up.emit(player.crate_shape_cast.get_collider(0))
			return

	default_movement(delta)
	default_input()
