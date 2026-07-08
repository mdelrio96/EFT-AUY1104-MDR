# Política 1: no permitir acceso SSH público (0.0.0.0/0).
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
	rc.type == "aws_security_group"
	after := rc.change.after
	ingress := after.ingress[_]
	ingress.from_port <= 22
	ingress.to_port >= 22
	ingress.protocol == "tcp"
	cidr := ingress.cidr_blocks[_]
	cidr == "0.0.0.0/0"
	msg := sprintf("aws_security_group %s: SSH no puede permitir 0.0.0.0/0", [rc.address])
}

deny[msg] {
	rc := input.resource_changes[_]
	rc.mode == "managed"
	is_relevant_change(rc)
	rc.type == "aws_vpc_security_group_ingress_rule"
	after := rc.change.after
	after.from_port <= 22
	after.to_port >= 22
	after.protocol == "tcp"
	after.cidr_ipv4 == "0.0.0.0/0"
	msg := sprintf("aws_vpc_security_group_ingress_rule %s: SSH no puede permitir 0.0.0.0/0", [rc.address])
}

deny[msg] {
	rc := input.resource_changes[_]
	rc.mode == "managed"
	is_relevant_change(rc)
	rc.type == "aws_security_group_rule"
	after := rc.change.after
	after.type == "ingress"
	after.from_port <= 22
	after.to_port >= 22
	after.protocol == "tcp"
	cidr := after.cidr_blocks[_]
	cidr == "0.0.0.0/0"
	msg := sprintf("aws_security_group_rule %s: SSH no puede permitir 0.0.0.0/0", [rc.address])
}
