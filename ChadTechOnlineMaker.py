import os
import PIL
from PIL import Image

###############################################################################
###############################################################################
##### Generating the index page
###############################################################################
###############################################################################

numOfPages=len(os.listdir(os.getcwd()+'//images'))

chadTechOnline =  '''
	<html>
	<head>
	<title>Chadtech Online</title>
	</head>
	<body>
	<body bgcolor=#"000000">
	<p>ChadTech Online</p>
	<img src="onebar.PNG" style= "position:absolute; top: 2px;left: 4px;"/>
	<img src="chadtechonline.PNG" style= "position:absolute; top: 6px;left: 4px;"/>
	<img src="onebar.PNG" style= "position:absolute; top: 152px;left: 4px;"/>
	<img src="emptybutton.PNG" style= "position:absolute; top: 156px;left: 6px;"/>
	<img src="onebar.PNG" style= "position:absolute; top: 202px; left: 4px;"/>
	<a href="'''+str(numOfPages-2)+'''.html">
	<img src="prevbutton.PNG" style= "position:absolute; top: 156px; left: 646px;"/>
	</a>
	<a href="archive.html">
	<img src="archivebutton.PNG" style= "position:absolute; top: 156px; left: 326px;"/>
	</a>
	'''

os.chdir(os.getcwd()+'//images')

nextXPos, nextYPos = 0,208

beginin = '<img src='+'"/images/'+str(len(os.listdir(os.getcwd()))-1)
os.chdir(os.getcwd()+'\\'+str(len(os.listdir(os.getcwd()))-1))
imX,imY=0,0

for imageInDir in os.listdir(os.getcwd()):
	if imageInDir.endswith('.PNG'):
		if imageInDir!='title.PNG' and not imageInDir.startswith('zfile'):
			chadTechOnline+=beginin+'/'+imageInDir+'" style= "position:absolute; top:'+str(nextYPos)+'px;left: 4px;"/>'
			im = Image.open(imageInDir)
			imX,imY = im.size
			nextYPos+=imY
			chadTechOnline+='<img src="onebar.PNG" style= "position:absolute; top:'+str(nextYPos)+ 'px;left: 4px;"/>'
			nextYPos+=4

		if imageInDir.startswith('zfile') and imageInDir.endswith('.PNG'):
			fileNumber = ord(imageInDir[5])-48

			linkFile = open(os.getcwd()+'\\zfile'+str(fileNumber)+'.txt','r')
			link = linkFile.read()

			if not link.startswith('http'):

				chadTechOnline+='<a href="'+os.getcwd()+'\\'+link+'"">'
				chadTechOnline+=beginin+'/'+imageInDir+'" style= "position:absolute; top:'+str(nextYPos)+'px;left: 4px;"/>'
				chadTechOnline+='</a>'

			else:

				chadTechOnline+='<a href="'+link+'">'
				chadTechOnline+=beginin+'/'+imageInDir+'" style= "position:absolute; top:'+str(nextYPos)+'px;left: 4px;"/>'
				chadTechOnline+='</a>'

			im = Image.open(imageInDir)
			imX,imY = im.size
			nextYPos+=imY
			chadTechOnline+='<img src="onebar.PNG" style= "position:absolute; top:'+str(nextYPos)+ 'px;left: 4px;"/>'
			nextYPos+=4

os.chdir(os.path.dirname(os.getcwd()))

for yit in range(nextYPos-4):
	chadTechOnline+='<img src="vbar.PNG" style= "position:absolute;  top:'+str(yit+2)+ 'px; left: 1006px;"/>'
for yit in range(nextYPos-4):
	chadTechOnline+='<img src="vbar.PNG" style= "position:absolute;  top:'+str(yit+2)+ 'px; left: 2px;"/>'

os.chdir(os.path.dirname(os.getcwd()))
chadTechOnline+='''	</body></html>'''

mainpage = open('index.html','w')
mainpage.write(chadTechOnline)
mainpage.close()

#########################################################################################################
#########################################################################################################
##### For every entry (every numbered folder in the images folder), generate a page called  [number].html
#########################################################################################################
#########################################################################################################

numberOfEntries = len(os.listdir(os.getcwd()+'\\images'))

for directoryNumber in range(numberOfEntries):

	thisEntryNumber = numberOfEntries-directoryNumber-1
	thisPage = '''
		<html>
		<head>
		<title>Chadtech Online</title>
		</head>
		<body>
		<body bgcolor=#"000000">
		<p>ChadTech Online</p>
		<img src="onebar.PNG" style= "position:absolute; top: 2px;left: 4px;"/>
		<img src="chadtechonline.PNG" style= "position:absolute; top: 6px;left: 4px;"/>
		<img src="onebar.PNG" style= "position:absolute; top: 152px;left: 4px;"/>
		<img src="onebar.PNG" style= "position:absolute; top: 202px; left: 4px;"/>
		'''

	if thisEntryNumber!=(numberOfEntries-1):
		thisPage+=	'''
		<a href="'''+str(thisEntryNumber+1)+ '''.html">
		<img src="nextbutton.PNG" style= "position:absolute; top: 156px;left: 6px;"/>
		</a>
		 '''
	else:
		thisPage+='''
		<img src="emptybutton.PNG" style= "position:absolute; top: 156px;left: 6px;"/>
		'''

	if thisEntryNumber==0:
		thisPage+= '''
		<img src="emptybutton.PNG" style= "position:absolute; top: 156px; left: 646px;"/>
		'''
	else:
		thisPage+=	'''
		<a href="'''+str(thisEntryNumber-1)+'''.html">
		<img src="prevbutton.PNG" style= "position:absolute; top: 156px; left: 646px;"/>
		</a>
		'''

	thisPage+='''
		<a href="archive.html">
		<img src="archivebutton.PNG" style= "position:absolute; top: 156px; left: 326px;"/>
		</a>
		'''

	nextXPos, nextYPos = 0,208

	beginin = '<img src='+'"./images/'+str(str(thisEntryNumber))
	imX,imY=0,0

	for imageInDir in os.listdir(os.getcwd()+'\\images\\'+str(thisEntryNumber)):
		if imageInDir.endswith('.PNG'):
			if imageInDir!='title.PNG' and not imageInDir.startswith('zfile'):
				thisPage+=beginin+'/'+imageInDir+'" style= "position:absolute; top:'+str(nextYPos)+'px;left: 4px;"/>'
				im = Image.open('images\\'+str(thisEntryNumber)+'\\'+imageInDir)
				imX,imY = im.size
				nextYPos+=imY
				thisPage+='<img src="onebar.PNG" style= "position:absolute; top:'+str(nextYPos)+ 'px;left: 4px;"/>'
				nextYPos+=4

			if imageInDir.startswith('zfile') and imageInDir.endswith('.PNG'):
				fileNumber = ord(imageInDir[5])-48

				linkFile = open(os.getcwd()+'\\images\\'+str(thisEntryNumber)+'\\zfile'+str(fileNumber)+'.txt','r')
				link = linkFile.read()

				if not link.startswith('http'):

					thisPage+='<a href="'+'\\images\\'+str(thisEntryNumber)+'\\'+link+'"">'
					thisPage+=beginin+'/'+imageInDir+'" style= "position:absolute; top:'+str(nextYPos)+'px;left: 4px;"/>'
					thisPage+='</a>'

				else:

					thisPage+='<a href="'+link+'">'
					thisPage+=beginin+'/'+imageInDir+'" style= "position:absolute; top:'+str(nextYPos)+'px;left: 4px;"/>'
					thisPage+='</a>'

				im = Image.open('images\\'+str(thisEntryNumber)+'\\'+imageInDir)
				imX,imY = im.size
				nextYPos+=imY
				thisPage+='<img src="onebar.PNG" style= "position:absolute; top:'+str(nextYPos)+ 'px;left: 4px;"/>'

				nextYPos+=4


	for yit in range(nextYPos-4):
		thisPage+='<img src="vbar.PNG" style= "position:absolute;  top:'+str(yit+2)+ 'px; left: 1006px;"/>'
	for yit in range(nextYPos-4):
		thisPage+='<img src="vbar.PNG" style= "position:absolute;  top:'+str(yit+2)+ 'px; left: 2px;"/>'

	thisPage+='''</body></html>'''

	anEntry =open(str(thisEntryNumber)+'.html','w')
	anEntry.write(thisPage)
	anEntry.close()