eksctl create cluster --name tomm-cluster --region us-east-1 --nodegroup-name my-nodes --node-type t3.small --nodes 1 --nodes-min 1 --nodes-max 2 
PGPASSWORD="$DB_PASSWORD" psql --host 127.0.0.1 -U tomuser -d coworkingdb -p 5433 < <FILE_NAME.sql>

