# zabbix-to-saymon-sync
Script for load zabbix data to saymon server.

INSTALL
-----------------------------------
1. Install "jq" package
2. Copy zabbix.sh to saymon scripts directory.
3. Edit zabbix.sh:

>...
>USER=%zabbix_user_for_script%
>PASSWORD=%zabbix_password_for_script%
>...
>DATAFILE=%file_where_script_save_auth_tocken_(need_r/w_for_saymon_user)%
>...
>HOST=%zabbix_host_url_for_connect_to_api%
>...

HOW USE
-----------------------------------

1. Add RDBMS object to Saymon
2. Connect object to Saymon agent with script
3. Select "run script" as check type
4. Set zabbix.sh script
5. Set zabbix host.name as argument 1 and zabbix item.name as arhument 2.
