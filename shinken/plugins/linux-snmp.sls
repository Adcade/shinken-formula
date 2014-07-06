{%- from "shinken/map.jinja" import shinken with context -%}
{%- from "shinken/utils.sls" import shinken_cli with context -%}

include:
  - shinken.base

{{ shinken_cli('linux-snmp') }}

shinken_nagios_plugins:
  pkg.installed:
    - name: {{ shinken.nagios_plugins }}

shinken_nagios_plugins_permissions:
  file.directory:
    - name: /usr/lib/nagios/plugins
    - user: root
    - group: shinken
    - mode: 5550
    - recurse:
      - user
      - group
    - require:
      - pkg: shinken_nagios_plugins
