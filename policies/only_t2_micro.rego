# Política 2: solo permitir instancias EC2 tipo t2.micro.
# Evalúa planes Terraform en JSON (terraform show -json ...).

package main

is_relevant_change(rc) {
	rc.change.actions[_] == "create"
}

is_relevant_change(rc) {
	rc.change.actions[_] == "update"
}

deny[msg] {
	rc := input.resource_changes[_]
	rc.mode == "managed"
	is_relevant_change(rc)
	rc.type == "aws_instance"
	it := rc.change.after.instance_type
	it != "t2.micro"
	msg := sprintf("aws_instance %s: tipo %s no permitido; solo t2.micro", [rc.address, it])
}
