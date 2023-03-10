extends Node
class_name TurnHistory

var action_list : Array
var target : Node

class Action:
	var function : FuncRef
	var params = []

func _init(func_list, param_list_list, _target):
	for i in func_list.size():
		var a = Action.new()
		a.function = func_list[i]
		a.params = param_list_list[i]
		action_list.append(a)
	target = _target

func go_back():
	for a in action_list:
		a.function.call_funcv(a.params)

func add_action(function : FuncRef, params : Array):
	var a = Action.new()
	a.function = function
	a.params = params
	action_list.append(a)
