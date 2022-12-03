def toCapitalize(str)
	return str.charAt(0).toUpperCase() + str.slice(1)

def toTitleCase(str)
	let strList = str.split(' ')
	for word, index in strList
		strList[index] = toCapitalize(word)
	return strList.join(' ')


export const titleCase =
	str: do(str) toTitleCase(str)

export const capitalize =
	str: do(str) toCapitalize(str)