import os
import PIL
from PIL import Image

###############################################################################
###############################################################################
##### Generating the index page
###############################################################################
###############################################################################

numOfPages=len(os.listdir(os.getcwd()+'//entries'))

chadTechOnline =  '''
	<html>
	<head>
	<style type="text/css">
	@font-face {
    font-family: "My Custom Font";
    src: url(Command-Prompt-12x16.ttf) format("truetype");
	}
	a.customfont { 
    font-family: "My Custom Font", Verdana, Tahoma;
    top: 200px;
    color: #C0C0C0;
    underline: none;
	}
	</style>
	<title>Chadtech Online</title>
	</head>
	<body>
	<body bgcolor=#"000000">
	<img src="onebar.PNG" style= "position:absolute; top: 2px;left: 4px;"/>
	<a href="http://www.chadtech.us">
	<img src="chadtechonline.PNG" style= "position:absolute; top: 6px;left: 4px;"/>
	</a>
	<img src="onebar.PNG" style= "position:absolute; top: 152px;left: 4px;"/>
	<img src="emptybutton.PNG" style= "position:absolute; top: 156px;left: 6px;"/>
	<img src="onebar.PNG" style= "position:absolute; top: 202px; left: 4px;"/>
	<a href="'''+str(numOfPages-2)+'''.html">
	<img src="prevbutton.PNG" style= "position:absolute; top: 156px; left: 646px;"/>
	</a>
	<a href="archive.html">
	<img src="archivebutton.PNG" style= "position:absolute; top: 156px; left: 326px;"/>
	</a>
	<img src="archivesign.PNG" style= "position:absolute; left: 1008px;"/>


	'''
archiveSideBar=''
archiveSideBar+='<div style="position:absolute; left:1008px; top:54px;">\n'

numberOfEntries = len(os.listdir(os.getcwd()+'\\entries'))
for directoryNumber in range(numberOfEntries):
	thisEntryNumber = numberOfEntries-directoryNumber-1
	thisTitle = open(os.getcwd()+'\\entries\\'+str(thisEntryNumber)+'\\title.txt','r')
	thisTitle = thisTitle.read()


	archiveSideBar+='''<a href="'''+str(numberOfEntries-directoryNumber-1)+'''.html" class="customfont" style="position:relative; top:20px;" > '''+'#'+str(numberOfEntries-directoryNumber-1).zfill(2)+' '+str(thisTitle)+'''</a>
	<br>'''

archiveSideBar+='</div>'

chadTechOnline+=archiveSideBar


os.chdir(os.getcwd()+'//entries')

nextXPos, nextYPos = 0,208

beginin = '<img src='+'"/entries/'+str(len(os.listdir(os.getcwd()))-1)
os.chdir(os.getcwd()+'\\'+str(len(os.listdir(os.getcwd()))-1))
imX,imY=0,0

for entryInDir in os.listdir(os.getcwd()):
	if entryInDir.endswith('.PNG'):
		if entryInDir!='title.PNG' and not entryInDir.startswith('zfile'):
			chadTechOnline+=beginin+'/'+entryInDir+'" style= "position:absolute; top:'+str(nextYPos)+'px;left: 4px;"/>'
			im = Image.open(entryInDir)
			imX,imY = im.size
			nextYPos+=imY
			chadTechOnline+='<img src="onebar.PNG" style= "position:absolute; top:'+str(nextYPos)+ 'px;left: 4px;"/>'
			nextYPos+=4

		if entryInDir.startswith('zfile') and entryInDir.endswith('.PNG'):
			fileNumber = ord(entryInDir[5])-48

			linkFile = open(os.getcwd()+'\\zfile'+str(fileNumber)+'.txt','r')
			link = linkFile.read()

			if not link.startswith('http'):

				chadTechOnline+='<a href="'+os.getcwd()+'\\'+link+'"">'
				chadTechOnline+=beginin+'/'+entryInDir+'" style= "position:absolute; top:'+str(nextYPos)+'px;left: 4px;"/>'
				chadTechOnline+='</a>'

			else:

				chadTechOnline+='<a href="'+link+'">'
				chadTechOnline+=beginin+'/'+entryInDir+'" style= "position:absolute; top:'+str(nextYPos)+'px;left: 4px;"/>'
				chadTechOnline+='</a>'

			im = Image.open(entryInDir)
			imX,imY = im.size
			nextYPos+=imY
			chadTechOnline+='<img src="onebar.PNG" style= "position:absolute; top:'+str(nextYPos)+ 'px;left: 4px;"/>'
			nextYPos+=4

os.chdir(os.path.dirname(os.getcwd()))

#for yit in range(nextYPos-4):
#	chadTechOnline+='<img src="vbar.PNG" style= "position:absolute;  top:'+str(yit+2)+ 'px; left: 1006px;"/>'
#for yit in range(nextYPos-4):
#	chadTechOnline+='<img src="vbar.PNG" style= "position:absolute;  top:'+str(yit+2)+ 'px; left: 2px;"/>'

os.chdir(os.path.dirname(os.getcwd()))
chadTechOnline+='''	</body></html>'''

mainpage = open('index.html','w')
mainpage.write(chadTechOnline)
mainpage.close()

#########################################################################################################
#########################################################################################################
##### For every entry (every numbered folder in the entries folder), generate a page called  [number].html
#########################################################################################################
#########################################################################################################

numberOfEntries = len(os.listdir(os.getcwd()+'\\entries'))

for directoryNumber in range(numberOfEntries):

	thisEntryNumber = numberOfEntries-directoryNumber-1
	thisPage = '''
		<html>
		<head>
		<style type="text/css">
		@font-face {
	    font-family: "My Custom Font";
	    src: url(Command-Prompt-12x16.ttf) format("truetype");
		}
		a.customfont { 
	    font-family: "My Custom Font", Verdana, Tahoma;
	    top: 200px;
	    color: #C0C0C0;
	    underline: none;
		}
		</style>
		<title>Chadtech Online</title>
		</head>
		<body>
		<body bgcolor=#"000000">
		<p>Chadtech Online</p>
		<img src="onebar.PNG" style= "position:absolute; top: 2px;left: 4px;"/>
		<a href="http://www.chadtech.us">
		<img src="chadtechonline.PNG" style= "position:absolute; top: 6px;left: 4px;"/>
		</a>
		<img src="onebar.PNG" style= "position:absolute; top: 152px;left: 4px;"/>
		<img src="onebar.PNG" style= "position:absolute; top: 202px; left: 4px;"/>
		'''

	thisPage+=archiveSideBar

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

	beginin = '<img src='+'"./entries/'+str(str(thisEntryNumber))
	imX,imY=0,0

	for entryInDir in os.listdir(os.getcwd()+'\\entries\\'+str(thisEntryNumber)):
		if entryInDir.endswith('.PNG'):
			if entryInDir!='title.PNG' and not entryInDir.startswith('zfile'):
				thisPage+=beginin+'/'+entryInDir+'" style= "position:absolute; top:'+str(nextYPos)+'px;left: 4px;"/>\n'
				im = Image.open('entries\\'+str(thisEntryNumber)+'\\'+entryInDir)
				imX,imY = im.size
				nextYPos+=imY
				thisPage+='<img src="onebar.PNG" style= "position:absolute; top:'+str(nextYPos)+ 'px;left: 4px;"/>\n'
				nextYPos+=4

			if entryInDir.startswith('zfile') and entryInDir.endswith('.PNG'):
				fileNumber = ord(entryInDir[5])-48

				linkFile = open(os.getcwd()+'\\entries\\'+str(thisEntryNumber)+'\\zfile'+str(fileNumber)+'.txt','r')
				link = linkFile.read()

				if not link.startswith('http'):

					thisPage+='<a href="'+'\\entries\\'+str(thisEntryNumber)+'\\'+link+'"">'
					thisPage+=beginin+'/'+entryInDir+'" style= "position:absolute; top:'+str(nextYPos)+'px;left: 4px;"/>\n'
					thisPage+='</a>'

				else:
					thisPage+='<a href="'+link+'">'
					thisPage+=beginin+'/'+entryInDir+'" style= "position:absolute; top:'+str(nextYPos)+'px;left: 4px;"/>\n'
					thisPage+='</a>'

				im = Image.open('entries\\'+str(thisEntryNumber)+'\\'+entryInDir)
				imX,imY = im.size
				nextYPos+=imY
				thisPage+='<img src="onebar.PNG" style= "position:absolute; top:'+str(nextYPos)+ 'px;left: 4px;"/>\n'

				nextYPos+=4

	nextYPos-=6
	thisPage+='<div style="width:0px; height:'+str(nextYPos)+'px; position:absolute; left:2px; top:2px; border:1px solid #C0C0C0;"></div>\n'
	thisPage+='<div style="width:0px; height:'+str(nextYPos)+'px; position:absolute; left:1006px; top:2px; border:1px solid #C0C0C0;"></div>\n'


	thisPage+='''</body></html>'''

	anEntry =open(str(thisEntryNumber)+'.html','w')
	anEntry.write(thisPage)
	anEntry.close()

archiveHTML = '''	
	<html>
	<head>
	<style type="text/css">
	@font-face {
    font-family: "My Custom Font";
    src: url(Command-Prompt-12x16.ttf) format("truetype");
	}
	a.customfont { 
    font-family: "My Custom Font", Verdana, Tahoma;
    top: 200px;
    color: #C0C0C0;
    underline: none;
	}
	</style>
	<title>Chadtech Online</title>
	</head>
	<body>
	<body bgcolor=#"000000">
	<img src="onebar.PNG" style= "position:absolute; top: 2px;left: 4px;"/>
	<a href="http://www.chadtech.us">
	<img src="chadtechonline.PNG" style= "position:absolute; top: 6px;left: 4px;"/>
	</a>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	'''


for directoryNumber in range(numberOfEntries):
	thisEntryNumber = numberOfEntries-directoryNumber-1
	thisTitle = open(os.getcwd()+'\\entries\\'+str(thisEntryNumber)+'\\title.txt','r')
	thisTitle = thisTitle.read()

	archiveHTML+='''<a href="'''+str(numberOfEntries-directoryNumber-1)+'''.html" class="customfont" > '''+'#'+str(numberOfEntries-directoryNumber-1).zfill(2)+' '+str(thisTitle)+'''</a><br>'''

archivePage =open('archive.html','w')
archivePage.write(archiveHTML)
archivePage.close()
