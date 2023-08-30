import os
import testinfra.utils.ansible_runner

def get_testinfra_hosts():
    inventory_file = os.environ['MOLECULE_INVENTORY_FILE']
    ansible_runner = testinfra.utils.ansible_runner.AnsibleRunner(inventory_file)
    hosts = ansible_runner.get_host('all')
    return hosts

def test_check_mongo_running_and_enabled(host):
    mongo = host.service("mongod")
    assert mongo.is_running
    assert mongo.is_enabled

def test_check_config_file(host):
    config_file = host.file('/etc/mongod.conf')
    assert config_file.contains('bindIp: 0.0.0.0')
    assert config_file.is_file

testinfra_hosts = get_testinfra_hosts()
