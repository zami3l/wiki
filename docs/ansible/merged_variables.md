Fusionner des variables
===

### 0. Description
Ansible par défaut surcharge les variables et ne permet pas la construction en mode merge.  
Si je déclare une variable dans `group_vars/all.yml` + `group_vars/mygroup.yml` + `host_vars/myhost.yml`, `group_vars/*` sera surchargé par `host_vars/myhost.yml`.  
Pour obtenir le comportement que je souhaite, je n'ai pas d'autres choix que de déclarer des variables différentes et de merger les variables.  
Pour standardiser, les variables seront préfixées par `_global`, `_group`, `_host` et `_merged`.  

Dans cet exemple, le but est de générer un fichier qui va load mes anchors dans OpenBSD.

### 1. Arborescence

```bash
infra/
├── group_vars/
│   ├── all.yml
│   └── fws.yml
├── host_vars/
│   └── fw1.yml
├── inventory.yml
├── templates/load_anchors.j2
└── playbook.yml
```

### 2. Configurations

**group_vars/all.yml :**
```yaml
anchors_global:
  - ssh
  - blacklist
```

**group_vars/fws.yml :**
```yaml
anchors_group:
  - pfsync
  - vip
```

**host_vars/fw1.yml :**
```yaml
anchors_host:
  - wg
  - rdr_to_front
```

**inventory.yml :**
```yaml
all:
  children:
    fws:
      hosts:
        fw1:
          ansible_connection: local
```

**playbook.yml :**
```yaml
- hosts: all
  connection: local
  gather_facts: no
  tasks:

    - name: Générer le fichier load_anchors.conf
      template:
        src: "templates/load_anchors.j2"
        dest: "/tmp/load_anchors.conf"
        remote_src: yes
```

**templates/load_anchors.j2 :**
```yaml
 {% set anchors_merged = (anchors_global | default([])) + 
                        (anchors_group   | default([])) + 
                        (anchors_host   | default([])) %}

{% for anchor in anchors_merged %}
load anchor "{{ anchor }}" from "/etc/pf.conf.d/anchors/{{ anchor }}.conf"
{% endfor %}
```

### 3. Résultat

```bash
load anchor "ssh" from "/etc/pf.conf.d/anchors/ssh.conf"
load anchor "blacklist" from "/etc/pf.conf.d/anchors/blacklist.conf"
load anchor "pfsync" from "/etc/pf.conf.d/anchors/pfsync.conf"
load anchor "vip" from "/etc/pf.conf.d/anchors/vip.conf"
load anchor "wg" from "/etc/pf.conf.d/anchors/wg.conf"
load anchor "rdr_to_front" from "/etc/pf.conf.d/anchors/rdr_to_front.conf"
```
