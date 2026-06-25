
current_dir=$(pwd)

cd "$(dirname "$0")/../../../gjp-open/gjp-open-english-web-react"

rm -rf dist

npm run build

cd $current_dir

#tail -f /var/log/nginx/error.log /var/log
ansible-playbook ./playbook/deploy_gjp_open_english_web_react.yml -i ~/.ansible/inventory/hosts -l ubuntu_server   