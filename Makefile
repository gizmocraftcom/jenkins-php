include mk/*.mk

.PHONY: build
build:: ##@Docker build image
	docker build \
			--tag "gizmocraft/jenkins-php:1.0.0" .

.PHONY: push
push:: ##@Docker push image to docker hub
	docker push gizmocraft/jenkins-php:1.0.0


.PHONY: run
run:: ##@Docker start jenkins
	docker run \
			-p 8080:8080 -p 50000:50000 \
			-v jenkins_home:/var/jenkins_home \
			--name jenkins \
			gizmocraft/jenkins-php:1.0.0
