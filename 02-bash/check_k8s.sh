#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLON='\033[1;33m'
NC='\033[0m'
echo "=== SRE Проверка Kubernetes ==="
echo ""

echo "[1/3] Проверка статуса Minikube..."
if ! minikube status | grep -q "Running";
then
	echo -e "${RED} Minikube не запущен ${NC}"
	echo "Запустите: minikube start --driver=docker"
	exit 1
fi
echo -e "${GREEN} Minikube работает ${NC}"
echo ""

echo "[2/3] Список всех подов:"
kubectl get pods -A
echo ""

echo "[3/3] Поиск проблемных подов..."
PROBLEM_PODS=$(kubectl get pods -A --no-headers | grep -E "CrashLoopBackff|Error|ImagePullBackOff" || true)

if [ -z "$PROBLEM_PODS" ]; then
	echo -e "${GREEN} Все поды в норме ${NC}"
	exit 0
else
	echo -e "${RED} Найдены проблемные поды:${NC}"
	echo "$Problem_PODS"
	exit 1
fi
