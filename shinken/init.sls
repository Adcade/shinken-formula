{%- from "shinken/map.jinja" import shinken with context -%}

shinken_pre_reqs:
  pkg.installed:
    - pkgs:
      - {{ shinken.pip }}
      - {{ shinken.pycurl }}

shinken_user:
  user.present:
    - name: shinken
    - group: shinken
    - home: /opt/shinken
    - createhome: false
    - shell: /usr/sbin/nologin

shinken_install:
  pip.installed:
    - name: shinken
    - require:
      - pkg: shinken_pre_reqs
      - user: shinken_user

check_shinken:
  module.run:
    - name: service.enabled
    - m_name: shinken

enable_shinken:
  module.wait:
    - name: service.enable
    - m_name: shinken
    - watch:
      - module: check_shinken

shinken_service:
  service.running:
    - name: shinken
    - require:
      - module: check_shinken
