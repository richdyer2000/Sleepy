setlocal enabledelayedexpansion


:mainloop
echo mainlooprestarted
FOR /L %%C IN (1,1,300) do (
	set /a wakey=0
	call :readfile %%C 
	PING localhost -n 2 >NUL
	echo wakey=!wakey!
	if !wakey!==1 goto :mainloop
	)
	
rundll32.exe powrprof.dll,SetSuspendState 0,1,0
GOTO :EOF

:readfile
for /F "tokens=*" %%i in ('powercfg -requests') do (
	call :readline %%i
	)
GOTO :EOF

:readline
set myline="%1%2%3%4"
if not %myline%=="None." (
	if not %myline%=="DISPLAY:" (
		if not %myline%=="SYSTEM:" (
			if not %myline%=="AWAYMODE:" (
				if not %myline%=="EXECUTION:" (
					if not %myline%=="PERFBOOST:" (
						if not %myline%=="ACTIVELOCKSCREEN:" (
							if not %myline%=="[DRIVER]LegacyKernelCaller" (
								set /a wakey=1
								echo %myline%
							)
						)
					)
				)
			)
		)
	)
)
GOTO :EOF
