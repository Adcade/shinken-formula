{%- set hosts = salt['pillar.get']('shinken:hosts', {}) -%}

{%- if hosts -%}
  {%- for host in hosts -%}
shinken_host_defintion_{{ host.name }}:
  file.managed:
    - name: /etc/shinken/hosts/{{ host.name }}.cfg
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - source: salt://shinken/config/files/basic.cfg
    - context:
        config_type: objects
        definition: host
        modules: none
  {%- endfor -%}
{%- endif -%}
