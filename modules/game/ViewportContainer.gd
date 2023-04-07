extends ViewportContainer

var lastResolution:Vector2 = OS.get_real_window_size()

#func _process(delta):
#	if OS.get_real_window_size() != lastResolution:
#		rect_scale.x = OS.get_real_window_size().x/480
#		rect_scale.y = OS.get_real_window_size().y/270
