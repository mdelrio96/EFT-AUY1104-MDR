package main

test_deny_security_group_ssh_open_to_world {
	count(deny) > 0 with input as {"resource_changes": [{
		"address": "aws_security_group.bad",
		"mode": "managed",
		"type": "aws_security_group",
		"change": {
			"actions": ["create"],
			"after": {"ingress": [{
				"from_port": 22,
				"to_port": 22,
				"protocol": "tcp",
				"cidr_blocks": ["0.0.0.0/0"]
			}]}
		}
	}]}
}

test_allow_security_group_ssh_restricted {
	count(deny) == 0 with input as {"resource_changes": [{
		"address": "aws_security_group.good",
		"mode": "managed",
		"type": "aws_security_group",
		"change": {
			"actions": ["create"],
			"after": {"ingress": [{
				"from_port": 22,
				"to_port": 22,
				"protocol": "tcp",
				"cidr_blocks": ["203.0.113.0/24"]
			}]}
		}
	}]}
}

test_deny_vpc_security_group_ingress_rule_ssh_open {
	count(deny) > 0 with input as {"resource_changes": [{
		"address": "aws_vpc_security_group_ingress_rule.bad",
		"mode": "managed",
		"type": "aws_vpc_security_group_ingress_rule",
		"change": {
			"actions": ["update"],
			"after": {
				"from_port": 22,
				"to_port": 22,
				"protocol": "tcp",
				"cidr_ipv4": "0.0.0.0/0"
			}
		}
	}]}
}

test_deny_non_t2_micro_instance {
	count(deny) > 0 with input as {"resource_changes": [{
		"address": "aws_instance.big",
		"mode": "managed",
		"type": "aws_instance",
		"change": {
			"actions": ["create"],
			"after": {"instance_type": "t3.small"}
		}
	}]}
}

test_allow_t2_micro_instance {
	count(deny) == 0 with input as {"resource_changes": [{
		"address": "aws_instance.ok",
		"mode": "managed",
		"type": "aws_instance",
		"change": {
			"actions": ["create"],
			"after": {"instance_type": "t2.micro"}
		}
	}]}
}
