docker build -t johnrkendall/multi-client:latest -t johnrkendall/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t johnrkendall/multi-server:latest -t johnrkendall/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t johnrkendall/multi-worker:latest -t johnrkendall/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push johnrkendall/multi-client:latest
docker push johnrkendall/multi-server:latest
docker push johnrkendall/multi-worker:latest

docker push johnrkendall/multi-client:$SHA
docker push johnrkendall/multi-server:$SHA
docker push johnrkendall/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=johnrkendall/multi-server:$SHA
kubectl set image deployments/client-deployment client=johnrkendall/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=johnrkendall/multi-worker:$SHA