import pytest, testinfra, os

def test_apache_installed_enabled_running():
    host=testinfra.get_host("docker://" + os.environ['CONTAINER_ID'])
    assert host.package("apache2").is_installed
    assert host.service("apache2").is_enabled
    assert host.service("apache2").is_running
    assert host.socket("tcp://0.0.0.0:80").is_listening
