#importing request module
from urllib.request import urlopen
from urllib.error import *

# try block to read URL
try:
    html = urlopen("https://www.google.com/")

# except block to catch
# exception
# and identify error
except HTTPError as e:
    print("HTTP error", e)

except URLError as e:
    print("Opps ! Page not found!", e)

else:
    print('Yeah !  found ')
