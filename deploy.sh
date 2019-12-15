docker build -t changa2127/multi-client:latest -t changa2127/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t changa2127/multi-server:latest -t changa2127/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t changa2127/multi-worker:latest -t changa2127/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push changa2127/multi-client:latest
docker push changa2127/multi-server:latest
docker push changa2127/multi-worker:latest

docker push changa2127/multi-client:$SHA
docker push changa2127/multi-server:$SHA
docker push changa2127/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=changa2127/multi-server:$SHA
kubectl set image deployments/client-deployment client=changa2127/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=changa2127/multi-worker:$SHA