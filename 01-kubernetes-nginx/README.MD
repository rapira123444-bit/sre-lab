Лабораторная работа 1: Nginx в Kubernetes (Minikube)

Цель:
Развернуть веб-сервер Nginx в локальном к ubernetes-кластере и открыть к нему доступ по сети.

Инструменты
Ubuntu 26.04 LTS (серверная версия)
Docker
Minikube v1.37.0
kubectl

Шаги
1. Запустить кластер Minikube:
minikube start --driver=docker
2. Создание Deploment с Nginx:
kubectl create deploument nginx --image=nginx
3. Создание Service типа NodePort:
kubectl expose deployment nginx --type=NodePort --port=80
4. Проверка статуса пода:
kubectl get pods
5. Доступ к приложению через port-forward:
kubectl port-forward --address 0.0.0.0 service/nginx 8080:80

Результат
Страница "Welcom to nginx!" открылась с другого устройства в локальной сети по адресу http://192.168.0.102:8080

Чему научился
- Управление подом в Kubernetes (Deployment, Service)
- Разница между ClusterIP, NodePort и port-forward
- Диагностика сетевого доступа (ufw, bind address)



Лабораторная работа 2: Мониторинг (Prometheus + grafana)

Установка
helm install monitoring oci://ghcr.io/prometheus-community/charts/kube-prometheus-stack \ --namespace monitoring --create=namespace

Доступ к Grafana
kubectl port-forward --address 0.0.0.0 -n monitoring svc/monitoring-grafana 3000:80

Пароль
kubectl get secret --namespace monitoring monitoring-grafana \ -o jsonpath="{data.admin-password}" | base64 --decode ; echo

Результат
Открыл Grafana по адресу http://192.168.0.102:3000
Вижу дашборды:
- Kubernetes / Compute Resources / Cluster
- Node Exporter / Nodes


Лабораторная работ 3: Автоматизация Bash-скрипт check_k8s.hs
- Проверяем статус Minikube
- Находим проблемные поды (CrashLoopBackOff, Error, ImagePullBackOff)
- Возвращает код 1 при наличии проблем

Python-скрипт autoheal.ry
- Подключается к Kubernetes API
- Находит проблемные поды
- Автоматически удаляет их (Kubernetes пересоздает)
- Логирует действия в autoheal.log

Лабораторная работа 4: Terraform (Infrastructure as Code)

Что освоил
- Установка Terraform
- Базовый синтаксис NCL
- Цикл init - plan - apply - destroy
- Провайдер 'local' (создание файла через код)
- Провайдер 'kubernetes' (создание Deployment nginx + Service)

Пример: nginx через Terraform
- Создан 'kubernetes_deployment' с 2 репликами
- Создан 'kubernetes-service' типа NodePort
- Проверено: 'terraform apply' создает инфроструктуру одной командой
- Проверено: изменения 'replicas' в коде маштабируются поды

Почему это важно для SRE
- Воспроизводимость окружений
- Хранение инфроструктуры в Git
- Автоматизация через CI/CD
