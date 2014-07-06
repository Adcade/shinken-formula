{%- set arbiter_modules = salt['pillar.get']('shinken:arbiter_modules', []) -%}
{%- set broker_modules = salt['pillar.get']('shinken:broker_modules', []) -%}
{%- set scheduler_modules = salt['pillar.get']('shinken:scheduler_modules', []) -%}
{%- set poller_modules = salt['pillar.get']('shinken:poller_modules', []) -%}
{%- set reactionner_modules = salt['pillar.get']('shinken:reactionner_modules', []) -%}

arbiter_configuration_file:
  file.managed:
    - name: /etc/shinken/arbiters/arbiter-master.cfg
    - user: root
    - group: root
    - mode: 666
    - template: jinja
    - source: salt://shinken/config/files/basic.cfg
    - context:
        config_type: daemon
        definition: arbiter
        modules: {{ arbiter_modules }}


broker_configuration_file:
  file.managed:
    - name: /etc/shinken/brokers/broker-master.cfg
    - user: root
    - group: root
    - mode: 666
    - template: jinja
    - source: salt://shinken/config/files/basic.cfg
    - context:
        config_type: daemon
        definition: broker
        modules: {{ broker_modules }}


scheduler_configuration_file:
  file.managed:
    - name: /etc/shinken/schedulers/scheduler-master.cfg
    - user: root
    - group: root
    - mode: 666
    - template: jinja
    - source: salt://shinken/config/files/basic.cfg
    - context:
        config_type: daemon
        definition: scheduler
        modules: {{ scheduler_modules }}

poller_configuration_file:
  file.managed:
    - name: /etc/shinken/pollers/poller-master.cfg
    - user: root
    - group: root
    - mode: 666
    - template: jinja
    - source: salt://shinken/config/files/basic.cfg
    - context:
        config_type: daemon
        definition: poller
        modules: {{ poller_modules }}


reactionner_configuration_file:
  file.managed:
    - name: /etc/shinken/reactionners/reactionner-master.cfg
    - user: root
    - group: root
    - mode: 666
    - template: jinja
    - source: salt://shinken/config/files/basic.cfg
    - context:
        config_type: daemon
        definition: reactionner
        modules: {{ reactionner_modules }}
