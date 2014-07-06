{%- set modules = salt['pillar.get']('shinken:reactioner_modules', []) -%}

reactionner_configuration_file:
  file.managed:
    - name: /etc/shinken/reactionners/reactionner-master.cfg
    - user: root
    - group: root
    - mode: 666
    - template: jinja
    - source: salt://shinken/config/files/basic.cfg
    - context:
        definition: reactioner
        modules: {{ modules }}
