function getValueAtKeyPath(aa as object, keyPath as string, fallback = invalid as dynamic, validator = isValid as function) as dynamic
	if (not (isKeyedValueType(aa) or isNonEmptyArray(aa)) or keyPath = "") then return fallback

	nextValue = aa
	keys = keyPath.tokenize(".").toArray()
	for each key in keys
		if isKeyedValueType(nextValue)
			nextValue = nextValue[key]
		else if isNonEmptyArray(nextValue)
			nextValue = nextValue[toNumber(key)]
		else
			return fallback
		end if
	end for

	if not validator(nextValue) then return fallback

	return nextValue
end function

function isKeyedValueType(value as dynamic) as boolean
	return getInterface(value, "ifAssociativeArray") <> invalid
end function

function isInteger(obj as dynamic) as boolean
	return isValid(obj) and GetInterface(obj, "ifInt") <> invalid
end function

function isLongInteger(obj as dynamic) as boolean
	return isValid(obj) and GetInterface(obj, "ifLongInt") <> invalid
end function

function isFloat(obj as dynamic) as boolean
	return isValid(obj) and GetInterface(obj, "ifFloat") <> invalid
end function

function getLastIndex(value as object) as integer
	if isNode(value)
		return value.getChildCount() - 1
	else if isArr(value) or isAA(value)
		return value.count() - 1
	end if
	return -1
end function

function isNumeric(obj as dynamic) as boolean
	if (isInteger(obj)) then return true
	if (isLongInteger(obj)) then return true
	if (isFloat(obj)) then return true
	if (isDouble(obj)) then return true
	return false
end function

function isString(obj as dynamic) as boolean
	objType = Type(obj)
	return (objType = "String" or objType = "roString")
end function

function isArr(obj as dynamic) as boolean
	return (Type(obj) = "roArray")
end function

function isAA(obj as dynamic) as boolean
	if (isValid(obj))
		return (Type(obj) = "roAssociativeArray")
	end if
	return false
end function

function isBoolean(obj as dynamic) as boolean
	objType = Type(obj)
	return (objType = "Boolean" or objType = "roBoolean")
end function

function isFunc(obj as dynamic) as boolean
	objType = Type(obj)
	return (objType = "roFunction" or objType = "Function")
end function

function isNode(value as dynamic) as boolean
	return (Type(value) = "roSGNode")
end function

function isUrlTransfer(value as dynamic) as boolean
	return (Type(value) = "roUrlTransfer")
end function

function getDeviceInfo() as object
	if isInvalid(m.__deviceInfo)
		m.__deviceInfo = createObject("roDeviceInfo")
	end if
	return m.__deviceInfo
end function

function getObjectValue(obj as dynamic, valueName as string) as dynamic
	return ifThenElse((isAA(obj) and isNonEmptyString(valueName) and obj.doesExist(valueName)), obj[valueName])
end function

function isValid(obj as dynamic) as boolean
	return (Type(obj) <> "<uninitialized>" and obj <> invalid)
end function

function isInvalid(value as dynamic) as boolean
	return (not isValid(value))
end function

function isNodeEvent(value as dynamic) as boolean
	return (Type(value) = "roSGNodeEvent")
end function

function isUrlEvent(value as dynamic) as boolean
	return (Type(value) = "roUrlEvent")
end function

function isNonEmptyArray(value as dynamic) as boolean
	return (isArr(value) and not value.isEmpty())
end function

function isNonEmptyAA(value as dynamic) as boolean
	return (isAA(value) and not value.isEmpty())
end function

function isNonEmptyString(value as dynamic) as boolean
	return isString(value) and value <> ""
end function

function isEmptyString(value as dynamic) as boolean
	return isString(value) and value = ""
end function

function isIntegerValueNull(value as integer) as boolean
	return value = 0
end function

function isNotNullOrEmpty(obj as dynamic) as boolean
	if (isValid(obj))
		if (isString(obj) and Len(obj) > 0) return true
		if (isNumeric(obj)) return true
		if (isAA(obj) and obj.Count() > 0) return true
		if (isArr(obj) and obj.Count() > 0) return true
		if (isBoolean(obj)) return true
	end if
	return false
end function

function isInvalidString(value as dynamic) as boolean
	return value = invalid
end function

function isDouble(value as dynamic) as boolean
	valueType = Type(value)
	return (valueType = "Double") or (valueType = "roDouble") or (valueType = "roIntrinsicDouble")
end function

function isJSONStringValid(value as dynamic) as boolean
	return isString(value) and doesExistInStr(value.trim(), "^(?:\[|\{)")
end function

function toNumber(value as dynamic) as dynamic
	if isNumeric(value)
		return value
	else if isBoolean(value)
		if value then return 1
		return 0
	end if

	if isString(value)
		if stringIncludes(value, ".")
			return val(value)
		else
			return val(value, 10)
		end if
	end if

	return 0
end function

function findInArray(array as object, match as dynamic) as integer
	if not isArr(array) then return -1
	index = 0
	for each item in array
		if isSameValue(item, match) then return index
		index++
	end for

	return -1
end function

function combine(baseAA as dynamic, a as dynamic, b = invalid as dynamic, c = invalid as dynamic) as dynamic
	if not isAA(baseAA) then return invalid
	if isAA(a)
		for each key in a
			item = a[key]
			if isAA(baseAA[key])
				combine(baseAA[key], item)
			else
				baseAA[key] = item
			end if
		end for
	end if

	if isAA(b)
		combine(baseAA, b)
	end if

	if isAA(c)
		combine(baseAA, c)
	end if

	return baseAA
end function

function createNode(nodeType = "Node" as string, fields = {} as dynamic) as object
	node = createObject("roSGNode", nodeType)
	if isInvalid(node)
		return invalid
	end if
	if isNonEmptyAA(fields) or isNonEmptyArray(fields) then node.update(fields, true)
	return node
end function

function isSameValue(valueOne as dynamic, valueTwo as dynamic) as boolean
	if canBeCompared(valueOne, valueTwo) then return (valueOne = valueTwo)
	if isNode(valueOne) and isNode(valueTwo) then return valueOne.isSameNode(valueTwo)
	if isAA(valueOne) and isAA(valueTwo) and (valueOne.keys().join(",") = valueTwo.keys().join(",")) then return (formatJson(valueOne) = formatJson(valueTwo))
	if isArr(valueOne) and isArr(valueTwo) and (valueOne.count() = valueTwo.count()) then return (formatJson(valueOne) = formatJson(valueTwo))
	return false
end function

function canBeCompared(valueOne as dynamic, valueTwo as dynamic) as boolean
	if isNumeric(valueOne) and isNumeric(valueTwo) then return true
	if isString(valueOne) and isString(valueTwo) then return true
	if isBoolean(valueOne) and isBoolean(valueTwo) then return true
	if isInvalid(valueOne) and isInvalid(valueTwo) then return true
	return false
end function

function stringIncludes(value as string, subString as string) as boolean
	return stringIndexOf(value, subString) > -1
end function

function stringIndexOf(value as string, subString as string) as integer
	return value.Instr(subString)
end function

function convertArrayToStr(obj as dynamic) as string
	result = ""
	if (isArr(obj))
		for each item in obj
			convertedItem = convertToStr(item)
			result = ifThenElse((result <> ""), Substitute("{0},{1}", result, convertedItem), convertedItem)
		end for
	end if
	return result
end function

function convertToInt(obj as dynamic) as integer
	if (isValid(obj))
		if (isInteger(obj)) then return obj
		if (isString(obj)) then return obj.toInt()
		if (isFloat(obj)) then return CInt(obj)
		if (isBoolean(obj) and obj) return 1
	end if
	return 0
end function

'''''''''
' convertAssocArrayToStr: Convert associative array or roSGNode to string
'
' @param {dynamic} obj Income
' @return {string}
'''''''''
function convertAssocArrayToStr(obj as dynamic) as string
	config = {emptyAssocArray: "{}", emptyArr: "[]", default: "''"}
	message = config.emptyAssocArray
	if (isAA(obj) or isNode(obj))
		nodeKeys = obj.Keys()
		if (nodeKeys.Count() > 0)
			lastKey = nodeKeys[nodeKeys.Count() - 1]
			for each nodeKey in nodeKeys
				convertedValue = convertToStr(obj[nodeKey])
				if (not isNotNullOrEmpty(obj[nodeKey]))
					if (isAA(obj[nodeKey])) then convertedValue = config.emptyAssocArray
					if (isArr(obj[nodeKey])) then convertedValue = config.emptyArr
				end if

				if (not isNotNullOrEmpty(convertedValue)) then convertedValue = config.default
				if (Len(message) <= 2) then message = "{"
				message += nodeKey + ":" + convertedValue
				if (nodeKey <> lastKey) then message += ", "
				if (nodeKey = lastKey) then message += "}"
			end for
		end if
	end if
	return message
end function

'''''''''
' convertToStr: Convert a variable to string
'
' @param {Dynamic} obj Input variable
' @return {string}
'''''''''
function convertToStr(obj as dynamic) as string
	if (isValid(obj))
		if (isString(obj)) then return obj
		if (isNumeric(obj)) then return obj.toStr()
		if (isArr(obj)) then return convertArrayToStr(obj)
		if (isAA(obj) or isNode(obj)) then return convertAssocArrayToStr(obj)
		if (isBoolean(obj)) return obj.getBoolean().toStr()
	end if
	return ""
end function

'''''''''
' convertToBool: Convert a variable to boolean
'
' @param {Dynamic} obj Input variable
' @return {boolean}
'''''''''
function convertToBool(obj as dynamic) as boolean
	if (isValid(obj))
		if (isBoolean(obj)) then return obj.getBoolean()
		if isString(obj) then return contains(["on", "true", "yes", "enabled"], LCase(obj))
		if (isNumeric(obj) and obj <> 0) then return true
	end if
	return false
end function

'''''''''
' contains: Search value in array
'
' @param {Object} arr
' @param {Dynamic} value Needle
' @return {boolean}
'''''''''
function contains(arr as object, value as dynamic) as boolean
	if (isArr(arr) and arr.Count() > 0)
		for each entry in arr
			if (isString(entry) and isString(value) and Instr(0, value, entry) > 0)
				return true
			else if (entry = value)
				return true
			end if
		end for
	end if
	return false
end function

'''''''''
' getMatchedArrValue: Search value in array
'
' @param {object} arr Incoming array
' @param {dynamic} value Needle
' @return {dynamic} First matched value or Invalid if fails
'''''''''
function getMatchedArrValue(arr as object, value as dynamic)
	if (isArr(arr) and arr.Count() > 0)
		for i = 0 to arr.Count() - 1
			item = arr[i]
			if (isString(item) and isString(value) and(LCase(item) = LCase(value))) then return {index: i, value: item}
			if (item = value) then return {index: i, value: value}
		end for
	end if
	return {index: -1, value: invalid}
end function

'''''''''
' firstNotEmptyValueInArray: Get first found not empty value and own index
'
' @param {Object} arr Input array
' @param {Integer} [startIndex=0] Starts from index
' @return {object}
'''''''''
function firstNotEmptyValueInArray(arr as object, startIndex = 0 as integer) as object
	data = {index: -1, value: invalid}
	if (isArr(arr) and arr.Count() > 0)
		for i = startIndex to arr.Count() - 1
			if (isNotNullOrEmpty(arr[i]))
				data.Append({index: i, value: arr[i]})
				return data
			end if
		end for
	end if
	return data
end function

'''''''''
' doesExistInStr: check does the parameter or the segment exist in the string (path)
'
' @param {string} sentence original path
' @param {string} needle regex String or simple string
' @param {string} options should be apply in search
'
' @return {boolean}
'''''''''
function doesExistInStr(sentence = "" as string, needle = "" as string, options = "" as string) as boolean
	regEx = CreateObject("roRegex", needle, options)
	return regEx.isMatch(sentence)
end function

'''''''''
' ifThenElse: Check condition and return result according to condition
'
' @param {boolean} condition
' @param {dynamic} thenCb What should be return if condition is truthy
' @param {dynamic} [elseCb=invalid] What if condition is falsy
' @return {dynamic} According to condition
'''''''''
function ifThenElse(condition as boolean, thenCb, elseCb = invalid)
	if (condition) then return thenCb
	return elseCb
end function

'''''''''
' isObjKeysValid: Check keys in the object. Same as obj.a<>invalid and obj.a.b<>invalid
'
' @param {dynamic} obj Checking object
' @param {string} keys Keys of the object divided by dot "."
' @return {boolean} Does key(-s) exists
'''''''''
function isObjKeysValid(obj as dynamic, keys as string) as boolean
	if (not (isAA(obj) and isNotNullOrEmpty(keys))) then return false
	separateKeys = keys.Split(".")
	if (separateKeys.Count() = 0) return false
	currentObj = obj
	for each key in separateKeys
		currentObjKey = getMatchedArrValue(currentObj.Keys(), key)
		if (currentObjKey["index"] = -1) then return false
		currentObj = currentObj[currentObjKey["value"]]
		if (currentObj = invalid) return false
	end for
	return true
end function


function getGlobalNode() as object
	if isInvalid(m.global) then m.global = GetGlobalAA().global
	return m.global
end function

function isSideLoadedBuild() as boolean
	return getAppInfo().IsDev()
end function

function getAppInfo() as object
	if isInvalid(m._appInfo) then m._appInfo = createObject("roAppInfo")
	return m._appInfo
end function

function getManifestValue(key as string) as string
	return getAppInfo().getValue(key)
end function

function getEncodedLanguageCode(value as string) as string
	value = LCase(value)
	return (Left(value, 2) + "_" + Right(value, 2))
end function

function getLoadingSpinnerUri(isLive = false as boolean) as string
	DEFAULT_LOADER_URI = "pkg:/bell/images/loadingSpinner{size}.png"
	uri = DEFAULT_LOADER_URI
	if isLive then uri = "pkg:/bell/images/loadingSpinnerLive{size}.png"
	return uri
end function

function centerToParent(target as object, horizontal = false as boolean, vertical = false as boolean) as boolean
	if isNode(target)
		relativeTarget = target.getParent()
		if isNode(relativeTarget)
			return centerToNode(target, relativeTarget, horizontal, vertical)
		end if
	end if

	return false
end function

function centerToNode(target as object, relativeTarget as object, horizontal = false as boolean, vertical = false as boolean) as boolean
	if isNode(target) and isNode(relativeTarget)
		isParent = (relativeTarget.isSameNode(target.getParent()))

		relativeTargetBoundingRect = relativeTarget.boundingRect()
		targetBoundingRect = target.boundingRect()

		if horizontal
			centerX = (relativeTargetBoundingRect.width - targetBoundingRect.width) / 2
			if not isParent then centerX += relativeTarget.translation[0]
		else
			centerX = target.translation[0]
		end if

		if vertical
			centerY = (relativeTargetBoundingRect.height - targetBoundingRect.height) / 2
			if (not isParent) then centerY += relativeTarget.translation[1]
		else
			centerY = target.translation[1]
		end if
		target.translation = [centerX, centerY]

		return true
	end if

	return false
end function

function replaceAll(value as string, replaceWith = "-" as string, caseStyle = "lower" as string) as string
	value = value.encodeUriComponent()
	regexRemovePercentEncoding = createObject("roRegex", "%[0-9a-fA-F]{2}", "i")
	formattedString = regexRemovePercentEncoding.replaceAll(value, replaceWith)
	if (caseStyle = "lower") then formattedString = LCase(formattedString)
	if (caseStyle = "upper") then formattedString = UCase(formattedString)
	return formattedString
end function

sub removeAllChildren(node as object)
	if isNode(node) then node.removeChildrenIndex(node.getChildCount(), 0)
end sub

function getLegacyErrorObject(data as object) as object
	'TODO: map to default error message key
	FALLBACK_ERROR_MESSAGE = "ERROR_MESSAGE_NOT_FOUND"
	parserError = getValueAtKeyPath(data, "parser.error")

	'If we're using a Parser for this request, map the error data to the parser ErrorResponseObject
	if isValid(parserError)
		errorMessage = getValueAtKeyPath(parserError, "message", FALLBACK_ERROR_MESSAGE)
	else
		umErrorMessage = getValueAtKeyPath(data, "messageDetails", FALLBACK_ERROR_MESSAGE)
		errorMessage = getValueAtKeyPath(data, "body.message", umErrorMessage)
	end if
	errorCode = getValueAtKeyPath(data, "code", 0)

	return {
		"errorCode": errorCode.toStr()
		"message": errorMessage
	}
end function

function getMessage(port as object, sleepInterval = 20 as integer) as dynamic
	message = port.getMessage()
	if message = invalid then sleep(sleepInterval)
	return message
end function

function isContentLocked(playAction = string) as boolean
	return (isNonEmptyString(playAction) and (LCase(playAction) = "sign-in" or LCase(playAction) = "subscribe"))
end function

'''''''''
' filterArr: Remove object with from array
'
' @param {object} origArr Original array
' @param {dynamic} filteredItem Removable object
' @return {object}
'''''''''
function filterArr(origArr as object, filteredItem as dynamic) as object
	arr = []
	if (isNonEmptyArray(origArr))
		for each item in origArr
			if (not isSameValue(item, filteredItem)) then arr.push(item)
		end for
	end if

	return arr
end function

'''''''''
' filterArr: Remove object with from array
'
' @param {object} origArr Original array
' @param {dynamic} filteredkey Removable object
' @return {object}
'''''''''
function filterArrWithKey(origArr as object, filterKey as String) as object
	filteredObject = {}
	if (isNonEmptyArray(origArr))
		for each item in origArr
			valueofFilteredKey = item[filterKey]
			if not isString(valueofFilteredKey)
				valueofFilteredKey = valueofFilteredKey.toStr()
			end if
			if not(filteredObject.doesExist(valueofFilteredKey))
				filteredObject[valueofFilteredKey] = []
			end if
			filteredObject[valueofFilteredKey].push(item)
		end for
	end if

	return filteredObject
end function

function createCaseSensitiveAA(key = "" as string, value = invalid as dynamic) as object
	aa = {}
	aa.setModeCaseSensitive()
	if isNonEmptyString(key) then aa[key] = value
	return aa
end function

