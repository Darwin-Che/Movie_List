import os
import mysql.connector
from mysql.connector import errorcode
from mysql.connector.constants import ClientFlag
from pathlib import Path

DBName = 'MovieList'

#TABLES = {}
#TABLES['main'] = (
#    'CREATE TABLE main ('
#    'first_name varchar(14), '
#    'last_name varchar(15) '
#    ')'
#)

sql_host = os.getenv('DATABASE_HOST', default='localhost')
sql_port = int(os.getenv('DATABASE_PORT', default='3306'))
cnx = mysql.connector.connect(host=sql_host, port=sql_port, user='348proj', passwd='dev000000', client_flags=[ClientFlag.LOCAL_FILES])
cursor = cnx.cursor()

# Init Database
cm = 'CREATE DATABASE IF NOT EXISTS {}'.format(DBName)

try:
    cursor.execute(cm, {'DBName': DBName})
    cnx.commit()
    cnx.database = DBName
except mysql.connector.Error as err:
    print("Failed creating database: {}".format(err))
    exit(1)

print("Success creating database: {}".format(DBName))


# Initialize Table
# For now just execute test script
def loaddata():
    # get the absolute path of the data txt/csv files
    p = str(Path('.').absolute())
    # replace 'path' in the script with p
    for a in cursor.execute(Path('..', 'drop_table.sql').read_text().replace("path", p), multi=True):
        pass
    for a in cursor.execute(Path('..', 'create_table.sql').read_text().replace("path", p), multi=True):
        pass
    for a in cursor.execute(Path('..', 'populate_table.sql').read_text().replace("path", p), multi=True):
        pass
    cnx.commit()

loaddata()


#for table_name in TABLES:
#    table_description = TABLES[table_name]
#    try:
#        print("Creating table {}: ".format(table_name), end='')
#        cursor.execute(table_description)
#        cnx.commit()
#    except mysql.connector.Error as err:
#        if err.errno == errorcode.ER_TABLE_EXISTS_ERROR:
#            print("already exists.")
#        else:
#            print(err.msg)
#    else:
#        print("OK")
