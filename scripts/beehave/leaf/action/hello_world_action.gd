class_name HelloWorldAction extends ActionLeaf

func tick(actor:Node, blackboard:Blackboard) -> int:
	print("Hello World!")
	return SUCCESS	
