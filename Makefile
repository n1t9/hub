TAG := $(shell date +%F-%H-%M)-$(shell git rev-parse --short HEAD)

push:
	docker build -t hub:$(TAG) .
	docker tag hub:$(TAG) 442426895348.dkr.ecr.ap-northeast-1.amazonaws.com/hub:$(TAG)
	aws ecr get-login-password --region ap-northeast-1 --profile hub | docker login --username AWS --password-stdin 442426895348.dkr.ecr.ap-northeast-1.amazonaws.com
	docker push 442426895348.dkr.ecr.ap-northeast-1.amazonaws.com/hub:$(TAG)
	docker rmi hub:$(TAG)
	docker rmi 442426895348.dkr.ecr.ap-northeast-1.amazonaws.com/hub:$(TAG)
