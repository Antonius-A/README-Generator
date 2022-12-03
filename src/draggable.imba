export tag Draggable
	css pos:relative d:flex ja:center
		rd:md bg:hue3 c:gray9/70 
		w:24 h:10 m:1 px:4 fs:sm
		cursor:grab

	prop x = 0
	prop y = 0

	<self[x:{x}px y:{y}px] @touch.moved.sync(self)> <slot> "box"