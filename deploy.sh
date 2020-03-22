docker build -t arthurrfanti/multi-client:latest -t arthurrfanti/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t arthurrfanti/mulit-server:latest -t arthurrfanti/mulit-server:$SHA -f ./server/Dockerfile ./server
docker build -t arthurrfanti/multi-worker:latest -t arthurrfanti/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push arthurrfanti/multi-client:latest
docker push arthurrfanti/multi-client:$SHA
docker push arthurrfanti/multi-server:latest
docker push arthurrfanti/multi-server:$SHA
docker push arthurrfanti/multi-worker:latest
docker push arthurrfanti/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=arthurrfanti/multi-server:$SHA
kubectl set image deployments/client-deployment client=arthurrfanti/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=arthurrfanti/multi-worker:$SHA