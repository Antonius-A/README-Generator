import {newReadMe, ReadMe} from "./readme_object_creator.imba"
import {capitalize, titleCase} from "./formating.imba"
# import {Draggable} from './draggable'
# <div[inset:0 d:hflex ja:end]>
# 	<Draggable[hue:blue]> 'Hope'
# 	<Draggable[hue:sky]> 'Love'
# 	<Draggable[hue:indigo]> 'Code'
# 	<Draggable[hue:purple]> 'Joy'

'''
#TODO: ``` ``` around code and ` ` for small code quotes
#TODO: [Link](url)
#TODO: add Bold option: **BOLD**
#TODO: add italic option *italic*
#TODO: strikethrough otion ~~strikethrough~~
#TODO: bold and italic option ***bold and italic***
#TODO: superscript and subscript ??? <sub></sub> <sup></sup>
#TODO: quotes >
#TODO: display image with ![Alt-Text](url)
#TODO: unordered list (-, + or *)
#TODO: ordered list (1.,2.,3.)
#TODO: nested list using indents
#TODO: task lists -[ ] or -[x] if task starts with ( ) must unless \()
#TODO: mentions @johndoe
#TODO: emojis using emoji code
#TODO: paragraphs by newline in between
#TODO: references [^1]
'''

global css @root ff:Arial c:white/87 bg:black/85
global css a c:indigo5 c@hover:indigo6
global css body m:0 d:flex ja:center 

const readMeObj = [
	{name:"project name", hint:'Choose a self-explaining name for your project.', rows:1, value:''}
	{name:'description', hint:'Let people know what your project can do specifically. Provide context and add a link to any reference visitors might be unfamiliar with. A list of Features or a Background subsection can also be added here. If there are alternatives to your project, this is a good place to list differentiating factors.', rows:7, value:''}
	{name:'badges', hint:'On some READMEs, you may see small images that convey metadata, such as whether or not all the tests are passing for the project. You can use Shields to add some to your README. Many services also have instructions for adding a badge.', rows:3, value:''}
	{name:'visuals', hint:"ENTER IMAGE URLS SEPARATED BY COMMAS HERE.Depending on what you are making, it can be a good idea to include screenshots or even a video (you'll frequently see GIFs rather than actual videos). Tools like ttygif can help, but check out Asciinema for a more sophisticated method.", rows:5, value:''}
	{name:'installation', hint:'Within a particular ecosystem, there may be a common way of installing things, such as using Yarn, NuGet, or Homebrew. However, consider the possibility that whoever is reading your README is a novice and would like more guidance. Listing specific steps helps remove ambiguity and gets people to using your project as quickly as possible. If it only runs in a specific context like a particular programming language version or operating system or has dependencies that have to be installed manually, also add a Requirements subsection.', rows:1, value:''}
	{name:'usage', hint:"Use examples liberally, and show the expected output if you can. It's helpful to have inline the smallest example of usage that you can demonstrate, while providing links to more sophisticated examples if they are too long to reasonably include in the README.", rows:10, value:''}
	{name:'support', hint:'Tell people where they can go to for help. It can be any combination of an issue tracker, a chat room, an email address, etc.', rows:2, value:''}
	{name:'roadmap', hint:'If you have ideas for releases in the future, it is a good idea to list them in the README.', rows:3, value:''}
	{name:'contributing', hint:"State if you are open to contributions and what your requirements are for accepting them.\nFor people who want to make changes to your project, it's helpful to have some documentation on how to get started. Perhaps there is a script that they should run or some environment variables that they need to set. Make these steps explicit. These instructions could also be useful to your future self. You can also document commands to lint the code or run tests. These steps help to ensure high code quality and reduce the likelihood that the changes inadvertently break something. Having instructions for running tests is especially helpful if it requires external setup, such as starting a Selenium server for testing in a browser.", rows:5, value:''}
	{name:'authors and acknowledgement', hint:'Show your appreciation to those who have contributed to the project.', rows:3, value:''}
	{name:'license', hint:'For open source projects, say how it is licensed.', rows:3, value:''}
	{name:'project_status', hint:'If you have run out of energy or time for your project, put a note at the top of the README saying that development has slowed down or stopped completely. Someone may choose to fork your project or volunteer to step in as a maintainer or owner, allowing your project to keep going. You can also make an explicit request for maintainers.', rows:5, value:''}
]


tag readme-form
	

	css self d:inline-block cursor:pointer w: 80% ta:start

	<self>
		
		for section in readme
			<form-component section=section> 

tag form-component
	boldHandler = console.log "b baby"

	css input, textarea d:inline-block cursor:pointer w: 100% ta:start mt:10px mb:20px ff:Arial p:5px
	
	
	<self> 
		<div @hotkey('cmd+b')=boldHandler>
		<div @hotkey('f').passive.log('not called')>
		<label> "{section.name}: "
		unless section.rows === 1
			<textarea placeholder=section.hint cols="40" rows=section.rows bind=section.value> 
		else	
			<input placeholder=section.hint bind=section.value>



tag start-generator
	start? = false
	generateReadme? = false
	readMeString = ''
	generated? = false

	# readMeObj = [
	# 	{name: "title", hint: "best readme generator", rows: 1, value: ""},
	# 	{name: "description", hint: "This is the best readme generator ever created", rows: 5, value: ""}]

	<self>
		if !start?
			<div @click=(start? = !start?)> "Begin"
		else
			if !generateReadme?
				
				<div @click=(generateReadme? = !generateReadme?)> "Generate README.md"
		
				<readme-form readme=readMeObj>

			else
				<div @click=(window.navigator.clipboard.writeText(readMeString))> "Copy README.md to clipboard"
				<div [ta:start w:80%]>
							
					for section in readMeObj
						unless section.value === "" or generated?
							unless section.name === "project name"
								# <p> "##{titleCase.str(section.name)}\n"
								# <p> "{capitalize.str(section.value)}\n"
								readMeString += "## {titleCase.str(section.name)}\n" + "{capitalize.str(section.value)}\n\n"
							else
								# <p> "#{titleCase.str(section.value)}\n"
								readMeString += "# {titleCase.str(section.value)}\n\n"
					<pre [fs:25px]> readMeString
					# console.log readMeString
					generated? = true
		

		# css without a selector applies to the enclosing element
		css div d:inline-block user-select:none cursor:pointer fs:6 bg:gray9
			p:2.5 5 m:6 bd:1px solid transparent rd:4 tween:border-color 250ms
			bc@hover:indigo5
		


tag app
	

	# inline styles with square brackets
	<self[max-width:1280px m:0 auto p:2rem ta:center]>

		# this css applies to nested img elements and not parents
		css img h:35 p:1.5em rd:50% tween:border-color pt:150px
			transition:transform 250ms, filter 250ms
			@hover transform:scale(1.1)
				filter:drop-shadow(0 0 4em red5)

		<a href="https://github.com/Antonius-A" target="_blank">
			<img.wing src="https://avatars.githubusercontent.com/u/91700433?s=400&u=5076657ccb70b19f470c9fe508dacd760e688435&v=4">

		<h1[c:red8 fs:3.2em lh:1.1]> "README.md Generator"

		<start-generator>

		css p c:warm1 ws:pre
		css a td:none
		<p>
			"Check out my github: "
			<a href="https://github.com/Antonius-A" target="_blank"> "Antonius-A"
			"."
		<p>
			"Connect with me on: "
			<a href="https://www.linkedin.com/in/anthony-aboussafy/" target="_blank">
				"LinkedIn"
			"."
		<p>
			"This project was created to solve a very important and tedious programming procedure.\n"
			<b [c:red8]> "Proper Documentation of Repos."
			" I hope it helps you as much as it helped me.\n"
			<u [c:emerald4]> "Keep up the Code Work!"

imba.mount <app>
