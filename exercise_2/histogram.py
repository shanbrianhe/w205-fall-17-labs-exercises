# script to fetch words within specified interval of counts

import sys
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

if len(sys.argv) != 3:
    print "invalid argument"
    exit(1)

k1 = sys.argv[1]
k2 = sys.argv[2]

conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")

cur = conn.cursor()

cur.execute("SELECT word, count from tweetwordcount WHERE count >= %s and count <= %s ORDER BY count desc", (k1, k2))
records = cur.fetchall()
for rec in records:
    print "word: ", rec[0] "\n"
    print "count: ", rec[1], "\n"

conn.commit()
conn.close()
