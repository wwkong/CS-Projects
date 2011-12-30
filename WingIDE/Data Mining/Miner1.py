from mechanize import Browser

br = Browser()
br.open('http://directory.humber.ca/')
br.select_form(name='directory-search')
br['search-field'] = 'Lee' # 'search-field' is the input field in the quote form
response = br.submit() # Submit the form just like a web browser
print response.read()