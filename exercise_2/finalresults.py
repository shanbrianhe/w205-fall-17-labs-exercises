#script to fetch streaming results

import sys

import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

if len(sys.argv) > 2 | len(sys.argv) < 1:
    print "invalid argument"
    exit(1)

conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")

cur = conn.cursor()

if len(sys.argv) == 2:
    word = sys.argv[1]
    cur.execute("SELECT count from tweetwordcount WHERE word = %s", (word, ))
    result = cur.fetchone()
    print "Total number of occurrences of \"", word, "\":", result[0]

if len(sys.argv) == 1:
    cur.execute("SELECT word, count from tweetwordcount)
    records = cur.fetchall()
    print records

conn.commit()
conn.close()
