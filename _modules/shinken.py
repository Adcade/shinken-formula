# -*- coding: utf-8 -*-
import inspect
import json
import os
import yaml
import logging

import salt.fileclient
import salt.utils


__virtualname__ = 'config_gen'


def __virtual__():

    return __virtualname__


def _nagios(section):
    '''
    Return a valid Nagios configuration file from a dictionary.
    '''

    logging.info('Generating Nagios Configuration')

    config_string = 'define ' + section + '{' + '\n'

    for key, value in __salt__['defaults.get'](section).items():
        logging.error(type(value))
    config_string += '}'
    return config_string


def get(section, format_type):
    '''
    Generate a configuration DSL by providing a configuration dictionary and format_type.
    '''
    #TODO: Is DSL the correct name?

    if format_type == 'nagios':
        return _nagios(section)

