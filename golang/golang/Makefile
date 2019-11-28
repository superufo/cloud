NAME=alpine-golang
USER=coollyj

all: push

clean:
	docker rmi ${NAME} &>/dev/null || true

build: clean
	docker build --pull=true --no-cache -t ${USER}/${NAME}:0.01  .

push: build
	docker login -u ${USER}
	docker push ${USER}/${NAME}:0.01