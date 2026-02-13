class_name MovingPlatform
extends Path2D

@export var speed := 40
@export var start_forward := true
@export var loop_close_tolerance := 1.0
@export var auto_close_curve := false

@onready var path_follower: PathFollow2D = $PathFollower
var direction := 1.0
var is_loop_path := false

func _ready() -> void:
	direction = 1.0 if start_forward else -1.0
	_close_curve_if_needed()
	is_loop_path = _is_curve_looped()
	path_follower.loop = is_loop_path

func _physics_process(delta: float) -> void:
	if not curve:
		return

	var path_length := curve.get_baked_length()
	if path_length <= 0.0:
		return

	path_follower.progress += speed * delta * direction

	if is_loop_path:
		path_follower.progress = fposmod(path_follower.progress, path_length)
		return

	if path_follower.progress >= path_length:
		path_follower.progress = path_length
		direction = -1.0
	elif path_follower.progress <= 0.0:
		path_follower.progress = 0.0
		direction = 1.0

func _is_curve_looped() -> bool:
	if not curve or curve.get_point_count() < 2:
		return false

	var first_point := curve.get_point_position(0)
	var last_point := curve.get_point_position(curve.get_point_count() - 1)
	return first_point.distance_to(last_point) <= loop_close_tolerance

func _close_curve_if_needed() -> void:
	if not auto_close_curve:
		return
	if not curve or curve.get_point_count() < 2:
		return
	if _is_curve_looped():
		return

	var first_point := curve.get_point_position(0)
	curve.add_point(first_point)
