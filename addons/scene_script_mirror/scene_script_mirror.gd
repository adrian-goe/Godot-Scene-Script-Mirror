@tool
extends EditorPlugin

# Change this to "scripts" if you prefer plural.
const SCRIPTS_ROOT := "res://script"


func _enter_tree() -> void:
	scene_saved.connect(_on_scene_saved)


func _exit_tree() -> void:
	if is_connected("scene_saved", _on_scene_saved):
		disconnect("scene_saved", _on_scene_saved)


func _on_scene_saved(scene_path: String) -> void:
	if not scene_path.ends_with(".tscn"):
		return
	_mirror_script_folder_for_scene(scene_path)


func _mirror_script_folder_for_scene(scene_path: String) -> void:
	if not scene_path.begins_with("res://"):
		return

	var rel_dir    := scene_path.trim_prefix("res://").get_base_dir()
	var target_dir := SCRIPTS_ROOT+"/"+rel_dir

	var err := DirAccess.make_dir_recursive_absolute(target_dir)
	if err != OK and err != ERR_ALREADY_EXISTS:
		push_warning("Scene Script Mirror: Failed to create %s (%s)" % [target_dir, error_string(err)])
		return

	var keep_path := target_dir+"/.gitkeep"
	if not FileAccess.file_exists(keep_path):
		var f := FileAccess.open(keep_path, FileAccess.WRITE)
		if f:
			f.store_string("")
			f.close()

	var fs := get_editor_interface().get_resource_filesystem()
	if fs and not fs.is_scanning():
		fs.scan()
