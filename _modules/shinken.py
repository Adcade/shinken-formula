# -*- coding: utf-8 -*-
'''
Support for installing packages with the Shinken CLI tool.
See https://shinken.readthedocs.org/en/latest/14_contributing/create-and-push-packs.html
'''

import os
import json
import logging
import ConfigParser

import salt.fileclient
import salt.utils

log = logging.getLogger(__name__)

parser = ConfigParser.ConfigParser()

user_path = os.path.expanduser('~')
config_path = user_path + '/.shinken.ini'

__outputter__ = {
    'search': 'txt',
    'inventory': 'txt',
    'install': 'txt'
}


def __virtual__():

    shinken_installed = False
    shinken_configured = False

    #  Check that the Shinken executable is available.
    if salt.utils.which('shinken'):
        shinken_installed = True

    #  Check that the Shinken config file is available.
    if os.path.isfile(config_path):
        shinken_configured = True

    if all([shinken_installed, shinken_configured]):
        parser.read(config_path)
        return True
    else:
        return False


def _verify_package(package):
    """
    Verify that the given package has been installed to the Inventory path as specified by the
    Shinken.ini config file.
    """
    package_path = parser.get('paths', 'inventory') + '/' + package + '/package.json'

    # Fail if the package.json file is not found.
    try:
        package_json = open(package_path, mode='r')
    except IOError:
        logging.error('Package: {} was not installed correctly'.format(package))
        return False

    # Fail if the package.json file is not valid JSON.
    try:
        package_details = json.loads(package_json.read())
    except ValueError:
        logging.error('Package: {} is invalid'.format(package))
        return False

    package_string = json.dumps(package_details, indent=2)
    logging.info('Package: {} is successfully installed'.format(package))
    logging.debug('Package Details: {}'.format(package_string))

    package_json.close()

    return True


def search(package):
    """
    Return the search result of the specified package.
    """
    result = __salt__['cmd.run']('shinken search {}'.format(package))
    return result


def inventory():
    """
    Return an inventory list of installed packages with the Shinken CLI tool.
    """
    result = __salt__['cmd.run']('shinken inventory')
    return result


def install(package):
    """
    Install the specified package with the Shinken CLI tool. After the command has been
    run verify that the package is available in the Shinken inventory path.
    """
    __salt__['cmd.run']('shinken install {}'.format(package))
    return _verify_package(package)