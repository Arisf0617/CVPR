import pymysql
import re
import requests

# 连接数据库函数
from bs4 import BeautifulSoup


def insertCvpr(value):

    try:
        db = pymysql.connect(host="localhost", user="root", password="whyjlbcdy2001", database="article",charset="utf8")
        print("数据库连接成功!")
        cur = db.cursor()
        sql = 'INSERT INTO cvpr(papername,ab,author,hotword,pdf,paperlink) VALUE (%s,%s,%s,%s,%s,%s)'
        cur.execute(sql, value)
        db.commit()
        print("增加数据成功!")
    except pymysql.Error as e:
        print("增加数据失败:  " + str(e))
        db.rollback()

    db.close()

#主函数
print("1")
url = "https://openaccess.thecvf.com/CVPR2020.py?day=2020-06-16"
headers = {"User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.92 Safari/537.36"}
res = requests.get(url,headers=headers)
res.encoding = "utf-8"
# 先爬取每个论文的网址
web = re.findall("""<dt class="ptitle"><br><a href="(.*?)">.*?</a></dt>""", res.text, re.S)
print("2")
for each in web:
    try:
        each = "http://openaccess.thecvf.com/" + each
        print("3")
        print(each)
        res = requests.get(each, headers=headers, timeout=(3, 7))
        paper = BeautifulSoup(res.text)
        res.encoding = "utf-8"
        # 在各各论文网站中爬取详细信息
        title = re.findall("""<div id="papertitle">(.*?)</div>""", res.text, re.S)#标题
        ab = re.findall("""<div id="abstract" >(.*?)</div>""", res.text, re.S)#摘要
        author = paper.find("div", {"id": "authors"}).find("b").find("i").text#作者
        pdf = re.findall("""\[<a href="\.\./\.\./(.*?)">pdf</a>\]""", res.text, re.S)#pdf下载地址
        path = each#论文简述页面
        if (len(title) > 0):
            title = title[0].replace("\n", "")
            ab = ab[0].replace("\n", "")
            pdf = "http://openaccess.thecvf.com/" + pdf[0]
            print(title)
            print(author)
            value = (title, ab, author, "hotword", pdf, path)
            insertCvpr(value)
    except:
        print("异常")
