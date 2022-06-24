function GetDateUtils() as object
	if (m._dateUtilsSingelton = invalid)
		instance = {
			getDateObject: function() as object
				return CreateObject("roDateTime")
			end function,

			getTimeStamp: function() as integer
				date = m.getDateObject()
				date.Mark()
				return date.AsSeconds()
			end function,

			getIsoFormatedTimeStamp: function() as string
				date = m.getDateObject()
				return date.ToISOString()
			end function

			getDateString: function() as string
				date = m.getDateObject()
				year = date.GetYear().toStr()
				month = date.GetMonth().toStr()
				day = date.GetDayOfMonth().toStr()
				return year + "-" + month + "-" + day
			end function,

			getDayPartingTime: function() as string
				date = m.getDateObject()
				hours = date.GetHours()
				AmPm = "AM"
				if (hours >= 12)
					AmPm = "PM"
					hours -= 12
				end if
				return date.GetWeekday() + " " + hours.toStr() + ":" + m.addZeroPrefix(date.GetMinutes()) + " " + AmPm
			end function,

			secondsLeft: function(expirationDate as string) as integer
				if (expirationDate = invalid) then return -1
				ts = CreateObject("roTimeSpan")
				return ts.GetSecondsToISO8601Date(expirationDate)
			end function,

			'parameter format "YYYY-MM-DD"
			getDateFromString: function(value as string) as object
				isoString = ""
				if (m.isISO8601String(value))
					isoString = value
				else if (m.isDateString(value))
					isoString = value + "T00:00:00Z"
				end if
				dateTime = m.getDateObject()
				if (isoString <> "")
					dateTime.FromISO8601String(isoString)
				else
					dateTime.Mark()
				end if
				return dateTime
			end function,

			getTimeFormatEn: function(dateTime as object) as object
				parsedTime = {hours: "00", minutes: "00", suffix: ""}
				inputHours = dateTime.GetHours()
				parsedTime.minutes = m.addZeroPrefix(dateTime.GetMinutes())
				currentHours = inputHours mod 12
				if (inputHours > 11)
					parsedTime.suffix = "PM"
					if (inputHours = 0 or inputHours = 12) then currentHours = 12
					parsedTime.hours = currentHours.toStr() + ":"
				else
					parsedTime.suffix = "AM"
					parsedTime.hours = currentHours.toStr() + ":"
				end if
				return parsedTime
			end function,


			getDate: function(dateTime as object) as object
				parsedDate = {year: "0000", dayOfMonth: "00", month: "00"}
				if (m.isDateTimeObject(dateTime))
					parsedDate.year = dateTime.GetYear().toStr()
					parsedDate.dayOfMonth = dateTime.GetDayOfMonth().toStr()
					month = dateTime.GetMonth()
					parsedDate.month = m.getListOfMonth[month - 1]
				end if
				return parsedDate
			end function,

			getTimeStampFromIsoString: function(value as string) as integer
				date = m.getDateObject()
				date.FromISO8601String(value)
				return date.AsSeconds()
			end function

			isISO8601String: function(value as string) as boolean
				regEx = CreateObject("roRegex", "\d{4}-\d{2}-\d{2}T[\d:.]+Z?", "")
				return regEx.isMatch(value)
			end function,

			isDateString: function(value as string) as boolean
				regEx = CreateObject("roRegex", "\d{4}-\d{2}-\d{2}", "")
				return regEx.isMatch(value)
			end function,

			isDateTimeObject: function(value as dynamic) as boolean
				return (type(value) = "roDateTime")
			end function,

			addZeroPrefix: function(value as integer) as string
				if (value < 10) then return Substitute("0{0}", value.toStr())
				return value.toStr()
			end function,

			getListOfMonth: [
				"january",
				"february",
				"march",
				"april",
				"may",
				"june",
				"july",
				"august",
				"september",
				"october",
				"november",
				"december",
			],

			destroy: function() as void
				DestroyDateUtils()
			end function
		}
		m._dateUtilsSingelton = instance
	end if

	return m._dateUtilsSingelton
end function

function DestroyDateUtils() as void
	if (m._dateUtilsSingelton <> invalid)
		m._dateUtilsSingelton = invalid
	end if
end function
