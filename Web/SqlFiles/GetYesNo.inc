select TYPEV AS Value,VALUE AS Text from CONFIG_TABLE
where PARAMETERNAME = 'Status'
order by VALUE desc