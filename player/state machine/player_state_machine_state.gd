class_name PlayerStateMachineState
extends StateMachineState

var player: Player

var hand_offset_tween: Tween
var right_hand_tween: Tween
var left_hand_tween: Tween

var prev_move_vec: Vector2
var force_strafe: bool



func _ready() -> void:
	player= get_parent().get_parent()


func default_movement(delta: float):
	force_strafe= Input.is_action_pressed("strafe")

	var move_vec: Vector2= Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	move_vec= move_vec.normalized()
	
	var store_prev_move_vec: bool= false
	
	if move_vec and not force_strafe:
		if prev_move_vec and force_smooth_turn():
			var signed_ang: float= move_vec.angle_to(prev_move_vec)
			var ang: float= abs(signed_ang)
			
			if ang > PI / 2 + 0.1:
				force_strafe= true
			else:
				if ang > PI / 4 + 0.1:
					move_vec= prev_move_vec.rotated(-PI / 4 * sign(signed_ang))
				store_prev_move_vec= true

	move_vec*= player.get_speed()
	
	player.linear_velocity= Vector3(move_vec.x, player.linear_velocity.y, move_vec.y)
	
	var stored_model_trans: Transform3D= player.model.transform
	
	if move_vec and not force_strafe:
		player.model.look_at(player.global_position + player.linear_velocity)	

		if restore_model_transform():
			player.model.transform= stored_model_trans
			store_prev_move_vec= false

	if store_prev_move_vec:
		prev_move_vec= move_vec


func default_input():
	if Input.is_action_just_pressed("hands_up"):
		player.state_machine.hands_up()
	elif Input.is_action_just_pressed("hands_down"):
		player.state_machine.hands_down()
	

func reset_tweens(reset_hand_position: bool= false):
	if hand_offset_tween:
		hand_offset_tween.kill()
		if reset_hand_position:
			player.hands_offset.position= player.orig_hand_offset_pos
	hand_offset_tween= create_tween()
	
	if right_hand_tween:
		right_hand_tween.kill()
		if reset_hand_position:
			player.right_hand.position= player.orig_right_hand_pos
	right_hand_tween= create_tween()
	
	if left_hand_tween:
		left_hand_tween.kill()
		if reset_hand_position:
			player.left_hand.position= player.orig_left_hand_pos
	left_hand_tween= create_tween()


func restore_model_transform()-> bool:
	return false


func force_smooth_turn()-> bool:
	return false


#func on_velocity_calculated():
	#pass
