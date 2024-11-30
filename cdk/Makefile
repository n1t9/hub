diff:
	npm run build; CDK_DEBUG=true npm run cdk -- --profile hub synth; npm run cdk -- --profile hub diff

deploy:
	npm run cdk -- --profile hub deploy

exec:
	aws ecs execute-command --cluster hub --task $(shell aws ecs list-tasks --cluster hub --query 'taskArns[0]' --output text --profile hub) --container Container --command "/bin/sh" --interactive --profile hub

rds-ssh:
	$(eval BASTION_INSTANCE_ID := $(shell aws ec2 describe-instances --filters "Name=tag:Name,Values=hub-bastion" "Name=instance-state-name,Values=running" --query 'Reservations[0].Instances[0].InstanceId' --output text --profile hub))
	aws --profile hub ec2-instance-connect send-ssh-public-key --instance-id $(BASTION_INSTANCE_ID) --instance-os-user ec2-user --availability-zone ap-northeast-1a --ssh-public-key file://~/.ssh/gitlab_rsa.pub --region ap-northeast-1
	ssh -L 5432:hubstack-rdse0e96d00-kml4im7apypl.cpgkg8smcckh.ap-northeast-1.rds.amazonaws.com:5432 -i ~/.ssh/gitlab_rsa ec2-user@$$(aws ec2 describe-instances --filters "Name=tag:Name,Values=hub-bastion" "Name=instance-state-name,Values=running" --query 'Reservations[0].Instances[0].PublicIpAddress' --output text --profile hub)
