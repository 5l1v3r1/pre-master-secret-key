:: Copyright (c) 2019 Ivan Šincek

@echo off
setlocal EnableDelayEdexpansion
	set "log=%USERPROFILE%\Desktop\ssl-keys.log"
	for /f "tokens=3" %%i in ('reg query "HKCU\Environment" /v "SSLKEYLOGFILE"') do (
		set env=%%i
	)
	if defined env (
		for /f "tokens=1 delims=:" %%i in ('setx "SSLKEYLOGFILE" ""') do (
			set success=%%i
		)
		if "!success!" EQU "SUCCESS" (
			echo Env. variable SSLKEYLOGFILE was removed successfully
			echo:
			if exist "%log%" (
				del /f /q "%log%" 1> nul 2> nul
				if not exist "%log%" (
					echo File "%log%" was removed successfully
				) else (
					echo Cannot remove "%log%" file, please remove it manually...
				)
			) else (
				echo File "%log%" does not exists, will skip removing...
			)
		) else (
			echo Cannot remove SSLKEYLOGFILE env. variable
		)
	) else (
		for /f "tokens=1 delims=:" %%i in ('setx "SSLKEYLOGFILE" "%log%"') do (
			set success=%%i
		)
		if "!success!" EQU "SUCCESS" (
			echo Env. variable SSLKEYLOGFILE was created successfully
			echo:
			if not exist "%log%" (
				type nul > "%log%"
				if exist "%log%" (
					echo File "%log%" was created successfully
				) else (
					echo Cannot create "%log%" file, please create it manually...
				)
			) else (
				echo File "%log%" already exists, will skip creating...
			)
		) else (
			echo Cannot create SSLKEYLOGFILE env. variable
		)
	)
endlocal
echo:
pause
