# Install Metasploit

### 1. Install PostgreSQL

Metasploit uses a database for certain functions.  
For example, we will install [PostgreSQL](https://wiki.archlinux.org/index.php/PostgreSQL).

```bash
$ pacman -S postgresql
```

### 2. Initialize PostgreSQL
```bash
# Connect with postgres user
$ sudo -iu postgres

# Create cluster
postgres $ initdb --locale fr_FR.UTF-8 -D /var/lib/postgres/data
```

### 3. Setup PostgreSQL
```bash
# Start service
$ systemctl start postgresql.service
```

```bash
# Create msf user
$ sudo -iu postgres
postgres $ createuser --interactive
Enter the name of the role to add : msf
The new role is superuser ? (y/n) n
```

```bash
# Create database msf for msf user
postgres $ createdb msf -O msf
```

#### Install and setup Metasploit ####

```bash
# Install
$ pacman -S metasploit
```

```bash
# Start metasploit with msfconsole
$ msfconsole
```

```bash
# Test if Metasploit is connected a database
msf5 > db_status
[*] postgresql selected, no connection

# Connect database
msf5 > db_connect msf@msf
Connected to Postgres data service: /msf

# Re-test check status with database connection
msf5 > db_status 
[*] Connected to msf. Connection type: postgresql. Connection name: fsociety.
```
