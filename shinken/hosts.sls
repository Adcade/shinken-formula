{%- set templates = salt['pillar.get']('shinken_test:templates', ['generic-host']) -%}

{% for template in templates %}
{% for target, data in salt['mine.get'](template.match_key, 'grains.items', template.match_type).items() %}

shinken_{{ target }}_host_entry_{{ loop.index0 }}:
  file.managed:
    - name: /tmp/{{ target }}.cfg
    - user: root
    - group: root
    - mode: 644
    - source: salt://test/host.cfg
    - template: jinja
    - context:
        data: {{ data }}
        target: {{ target }}
        template: {{ template.name }}

  {% endfor %}
{% endfor %}
