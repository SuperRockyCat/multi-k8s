docker build -t hir0protagonist/multi-client:latest -t hir0protagonist/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hir0protagonist/multi-server -t hir0protagonist/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hir0protagonist/multi-worker -t hir0protagonist/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push hir0protagonist/multi-client:latest
docker push hir0protagonist/multi-server:latest
docker push hir0protagonist/multi-worker:latest
docker push hir0protagonist/multi-client:$SHA
docker push hir0protagonist/multi-server:$SHA
docker push hir0protagonist/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hir0protagonist/multi-server:$SHA
kubectl set image deployments/server-deployment server=hir0protagonist/multi-client:$SHA
kubectl set image deployments/server-deployment server=hir0protagonist/multi-worker:$SHA