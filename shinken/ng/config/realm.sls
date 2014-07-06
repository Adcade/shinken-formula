realm_configuration_file:
  file.managed:
    - name: /etc/shinken/realms/all.cfg
    - user: root
    - group: root
    - mode: 666
    - template: jinja
    - source: salt://shinken/config/files/basic.cfg
    - context:
        definition: realm
        modules: []
