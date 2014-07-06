{%- from "shinken/map.jinja" import shinken with context -%}
{%- set authentication  = salt['pillar.get']('shinken:authentication', 'htpasswd') -%}

include:
  - shinken.daemons

shinken_webui:
  module.run:
    - name: shinken.install
    - package: webui

shinken_htpasswd_auth:
  module.run:
    - name: shinken.install
    - package: auth-htpasswd

{% if authentication == 'htpasswd' %}

shinken_htpasswd_package:
  pkg.installed:
    - name: {{ shinken.apache_utils }}

  {% set username = salt['pillar.get']('shinken:username', 'shinken') %}
  {% set password = salt['pillar.get']('shinken:password', 'shinken') %}

shinken_htpasswd:
  module.run:
    - name: webutil.useradd
    - pwfile: /etc/shinken/htpasswd.users
    - user: {{ username }}
    - password: {{ password }}

{% endif -%}
