extends Node


signal js_message_arrived(msg_dict)

var send_message_callback = null


func _init() -> void:
	if not OS.has_feature("web"):
		return
	
	send_message_callback = JavaScriptBridge.create_callback(send_message)
	JavaScriptBridge.eval("""
		var godotBridge = {
			callback: null,
			setCallback: (cb) => this.callback = cb,
			test: (data) => this.callback(JSON.stringify(data)),
		};
	""", true)
	var godot_bridge = JavaScriptBridge.get_interface("godotBridge")
	godot_bridge.setCallback(send_message_callback)


func send_message(args):
	var msg_dict = JSON.parse_string(args[0])
	js_message_arrived.emit(msg_dict)
