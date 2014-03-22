import os
import PIL
from PIL import Image


numOfPages=len(os.listdir(os.getcwd()+'//images'))

chadTechOnline =  '''

<html>
	<head>
		<title>ChadTech Online</title>
	</head>
	<body>
	<body bgcolor=#"000000">
	<p>ChadTech Online</p>
	<img src="onebar.PNG" style= "position:absolute; top: 2px;left: 4px;"/>
	<img src="chadtechonline.PNG" style= "position:absolute; top: 6px;left: 4px;"/>
	<img src="twobar.PNG" style= "position:absolute; top: 152px;left: 4px;"/>
	<img src="emptybutton.PNG" style= "position:absolute; top: 160px; left: 1010px;"/>
	<a href="'''+str(numOfPages-1)+'''.html">
	<img src="prevbutton.PNG" style= "position:absolute; top: 206px; left: 1010px;"/>
	</a>
	<a href="archive.html">
	<img src="archivebutton.PNG" style= "position:absolute; top: 252px; left: 1010px;"/>
	</a>

'''

os.chdir(os.getcwd()+'//images')

nextXPos, nextYPos = 0,160

for directoryNumber in range(len(os.listdir(os.getcwd()))):
	beginin = '<img src='+'"./images/'+str(len(os.listdir(os.getcwd()))-1-directoryNumber)
	os.chdir(os.getcwd()+'\\'+str(len(os.listdir(os.getcwd()))-1-directoryNumber))
	imX,imY=0,0

	for imageInDir in os.listdir(os.getcwd()):
		if imageInDir.endswith('.PNG'):
			if imageInDir!='title.PNG':
				chadTechOnline+=beginin+'/'+imageInDir+'" style= "position:absolute; top:'+str(nextYPos)+'px;left: 4px;"/>'
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