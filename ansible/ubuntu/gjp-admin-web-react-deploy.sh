
current_dir=$(pwd)

cd "$(dirname "$0")/../../../gjp-admin-web-react"

rm -rf dist

npm run build

cd $current_dir

#tail -f /var/log/nginx/error.log /var/log
ansible-playbook ./playbook/gjp-admin-web-react-deploy.yml -i ~/.ansible/inventory/hosts -l ubuntu_server   