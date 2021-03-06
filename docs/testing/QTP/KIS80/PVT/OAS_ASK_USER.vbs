Sub OAS_ASK_USER()
	Dim blnResult
	Dim CWorkAreaHomeAntivirusSettings 
	Set CWorkAreaHomeAntivirusSettings = New cWorkAreaHomeAntivirus

	' Открытие главного окна
	blnResult = OpenMainWindow()
	If  blnResult = True Then
		LogEvent "PASS", "OpenMainWindow()", "Main window opened"
	Else
		LogEvent "FAIL", "OpenMainWindow()", "Can't open Main window"
	End If
	If  Not blnResult Then Exit Sub

	' Переход в нужный раздел
	blnResult = SelectMainWindowNavigatorButton("ANTIVIRUS", "HOME")
	If blnResult = True Then
		LogEvent "PASS", "SelectMainWindowNavigatorButton(""ANTIVIRUS"", ""HOME"")", "Area ""ANTIVIRUS"", ""HOME"" selected"
	Else
		LogEvent "FAIL", "SelectMainWindowNavigatorButton(""ANTIVIRUS"", ""HOME"")", "Can't select ""ANTIVIRUS"", ""HOME"" area"
	End If
	If  Not blnResult Then Exit Sub

	' Подготовка класса
	CWorkAreaHomeAntivirusSettings.txtModule = "FILEMONITORING"
	CWorkAreaHomeAntivirusSettings.txtMonitoring = IMAGE_CHECK_OFF
	CWorkAreaHomeAntivirusSettings.intDepthLevelHigh = 0
	CWorkAreaHomeAntivirusSettings.intDepthLevelMedium = 1
	CWorkAreaHomeAntivirusSettings.intDepthLevelLow = 0
	CWorkAreaHomeAntivirusSettings.intOnDetectAskDetect = 1
	CWorkAreaHomeAntivirusSettings.intOnDetectDontAsk = 0
	CWorkAreaHomeAntivirusSettings.intOnDetectTryDisinfect = 0
	CWorkAreaHomeAntivirusSettings.intOnDetectTryDelete = 0
	
	' Вызов функции задания настроек
	blnResult = SetWorkAreaHomeAntivirus(CWorkAreaHomeAntivirusSettings)
'	If blnResult = True Then
'		LogEvent "PASS", "SetWorkAreaHomeAntivirus(CWorkAreaHomeAntivirusSettings)", "OAS Settings Applied Successfuly"
'	Else
'		LogEvent "FAIL", "SetWorkAreaHomeAntivirus(CWorkAreaHomeAntivirusSettings)", "Can't Apply OAS Settings"
'	End If

	CreateEICAR("C:\EICAR.COM")

	' Подготовка класса
	CWorkAreaHomeAntivirusSettings.txtModule = "FILEMONITORING"
	CWorkAreaHomeAntivirusSettings.txtMonitoring = IMAGE_CHECK_ON
	Wait 1
	' Вызов функции задания настроек
	blnResult = SetWorkAreaHomeAntivirus(CWorkAreaHomeAntivirusSettings)

	On error resume next
    systemutil.Run("C:\EICAR.COM")
	
	If AlertExist(5) = True Then
		LogEvent "PASS", "AlertExist(5)", "Alert Exist"
		AlertDialogAction "DELETE"
	Else
		LogEvent "FAIL", "AlertExist(5)", "Alert Not Found"
	End If
	
End Sub
