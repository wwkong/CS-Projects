from HTMLParser import HTMLParser
from mechanize import Browser

class HeadLineParser(HTMLParser):
    def __init__(self):
        self.in_header = False
        self.in_headline = False
        self.headlines = []
        HTMLParser.__init__(self)

    def handle_starttag(self, tag, attrs):
        if tag == 'div':
            # attrs is a list of tuple pairs, a dictionary is more useful
            dattrs = dict(attrs)
            if 'class' in dattrs and dattrs['class'] == 'header':
                self.in_header = True
        if tag == 'a' and self.in_header:
            self.in_headline = True

    def handle_endtag(self, tag):
        if tag == 'div':
            self.in_header = False
        if tag == 'a':
            self.in_headline = False

    def handle_data(self, data):
        if self.in_headline:
            self.headlines.append(data)

br = Browser()
response = br.open('http://tylerlesmann.com/')
hlp = HeadLineParser()
hlp.feed(response.read())
for headline in hlp.headlines:
    print headline
hlp.close()