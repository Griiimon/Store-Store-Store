class_name ChangeHandHeightPlayerState
extends PlayerStateMachineState

@export var direction: int= 1
@export var speed: float= 0.5



func on_physics_process(delta: float):
	var target_y: float 

	if direction < 0:
		target_y= player.orig_hands_offset.global_position.y
		if target_y < get_current_y():
			player.hands_offset.position.y-= speed * delta
			if get_current_y() <= target_y:
				player.hands_offset.global_position.y= target_y
				finished.emit()
				return
	else:
		target_y= player.hands_offset_high.global_position.y
		if target_y > get_current_y():
			player.hands_offset.position.y+= speed * delta
			if get_current_y() >= target_y:
				player.hands_offset.global_position.y= target_y
				finished.emit()
				return
	
	default_movement(delta)
	default_input()


func get_current_y()-> float:
	return player.hands_offset.global_position.y
	
