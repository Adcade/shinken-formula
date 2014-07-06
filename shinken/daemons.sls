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

shinken_ini_config:
  file.managed:
    - name: /root/.shinken.ini
    - user: root
    - group: root
    - mode: 644
    - source: salt://shinken/files/shinken.ini

check_shinken:
  module.run:
    - name: service.enabled
    - m_name: shinken
    - require:
      - pip: shinken_install

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
