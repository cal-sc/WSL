:::: Windows Subsystem for Linux [WSL] ::::

::#############################################################################
::							#DESCRIPTION#
::
::	SCRIPT STYLE: Interactive
::	Automated installation and setup for Windows Subsystem for Linux (WSL)
::	
::#############################################################################

:::: Developer ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Author:		David Geeraerts
:: Location:	Olympia, Washington USA
:: E-Mail:		dgeeraerts.evergreen@gmail.com
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:::: GitHub :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::	https://github.com/cal-sc/WSL
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:::: License ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Copyleft License(s)
:: GNU GPL v3 (General Public License)
:: https://www.gnu.org/licenses/gpl-3.0.en.html
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:::: Versioning Schema ::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::		VERSIONING INFORMATION												 ::
::		Semantic Versioning used											 ::
::		http://semver.org/													 ::
::		Major.Minor.Revision												 ::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


:::: Command shell ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@Echo Off
@SETLOCAL enableextensions
SET $PROGRAM_NAME=WSL_Setup
SET $Version=1.6.0
SET $BUILD=20240911 0900
Title %$PROGRAM_NAME%
Prompt WSL$G
color 8F
mode con:cols=75 lines=40
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


:::: Configuration - Basic ::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Declare Global variables
:: All User variables are set within here.
:: Defaults
::	uses user profile location for logs
SET "$LOGPATH=%APPDATA%\WSL"
SET "$LOG=WSL_Setup.log
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


:::: Configuration - Advanced :::::::::::::::::::::::::::::::::::::::::::::::::
:: Advanced Settings

:: DEBUG
:: {0 [Off/No] , 1 [On/Yes]}
SET $DEGUB_MODE=0


::#############################################################################
::	!!!!	Everything below here is 'hard-coded' [DO NOT MODIFY]	!!!!
::#############################################################################


:::: Default Program Variables ::::::::::::::::::::::::::::::::::::::::::::::::
:: Program Variables
SET $STATUS_ADMIN=
SET $STATUS_VT=
SET $STATUS_MICROSOFT-WINDOWS-SUBSYSTEM-LINUX=
SET $STATUS_VIRTUALMACHINEPLATFORM=
SET $STATUS_REBOOT=
SET $STATUS_WSL_KERNEL_UPDATE=
SET $STATUS_WSL_DEFAULT_VERSION=

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:::: Directory ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:CD
	:: Launched from directory
	SET "$PROGRAM_PATH=%~dp0"
	::	Setup logging
	IF NOT EXIST "%$LOGPATH%\var" MD "%$LOGPATH%\var"
	cd /D "%$PROGRAM_PATH%"
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


:::: Session Log Header :::::::::::::::::::::::::::::::::::::::::::::::::::::::
:wLog
	:: Start session and write to log
	echo Start: %DATE% %TIME% >> "%$LogPath%\%$LOG%"
	echo Program Name: %$PROGRAM_NAME% >> "%$LogPath%\%$LOG%"
	echo Program Version: %$Version% >> "%$LogPath%\%$LOG%"
	echo Program Build: %$BUILD% >> "%$LogPath%\%$LOG%"
	if %$DEGUB_MODE% EQU 1 echo Program Build: %$BUILD% >> "%$LogPath%\%$LOG%"
	echo Program Path: %$PROGRAM_PATH% >> "%$LogPath%\%$LOG%"
	echo PC: %COMPUTERNAME% >> "%$LogPath%\%$LOG%"
	echo User: %USERNAME% >> "%$LogPath%\%$LOG%"
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


:::: Administrator Privilege Check ::::::::::::::::::::::::::::::::::::::::::::
:subA
	SET $ADMIN_STATUS=0
	openfiles.exe 1> "%$LOGPATH%\var\var_$Admin_Status_M.txt" 2> "%$LOGPATH%\var\var_$Admin_Status_E.txt" && (SET $ADMIN_STATUS=1)
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

Goto start

:::: banner :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:banner
:: CONSOLE MENU ::
cls
	echo  ********************************************************************
	echo		Windows Subsystem for Linux [WSL]
	echo			Version: %$Version%
	IF %$DEGUB_MODE% EQU 1 echo			Build: %$BUILD%
	echo.
	echo		 	%DATE% %TIME%
	echo.
	echo  ********************************************************************
echo.
GoTo:EOF
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:::: HUD ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:HUD
echo --------------------------------------------------------------------
echo	Part I
echo		Administrative Privelage: %$STATUS_ADMIN%
echo 	Virtualization: %$STATUS_VT%
echo 	Feature Microsoft-Windows-Subsystem-Linux: %$STATUS_MICROSOFT-WINDOWS-SUBSYSTEM-LINUX%
echo		Feature VirtualMachinePlatform: %$STATUS_VIRTUALMACHINEPLATFORM%
echo		Reboot: %$STATUS_REBOOT%
echo --------------------------------------------------------------------
echo.
echo	Part II
echo		WSL Kernel update: %$STATUS_WSL_KERNEL_UPDATE%
echo		WSL Default version: %$STATUS_WSL_DEFAULT_VERSION%
echo --------------------------------------------------------------------
GoTo:EOF
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:::: GNU ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:GNU
echo.
echo     .          .
echo	   /            \
echo	  ((__-^^-,-^^-__))
echo	   `-_---' `---_-'
echo	    ^<__^|o` 'o^|__^>
echo	       \  `  /
echo	        ): :(
echo	        :o_o:
echo	         "-"
echo.
GoTo:EOF
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:::: Start ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:start
	CALL :banner
	CALL :HUD
	echo.
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

echo CHECKING DEPENDENCIES...
echo.

:::: Admin Privelage Check ::::::::::::::::::::::::::::::::::::::::::::::::::::
:admin
	echo Checking if running with Administrative privelage...
	echo (Running with Administrative privelage is required!)
	echo.
	IF %$ADMIN_STATUS% EQU 1 (
		echo Running with Administrative privelage!
		SET $STATUS_ADMIN=Pass
		)
		
	IF %$ADMIN_STATUS% EQU 0 (
		color 4E
		echo NOT running with  Administrative privelage!
		echo Right-click script, "Run as administrator"!
		echo Script will now abort!
		echo.
		SET $STATUS_ADMIN=FAILED
		pause
		GoTo end
		)
	echo.
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


:: Check WSL Installation :::::::::::::::::::::::::::::::::::::::::::::::::::::
wsl --status
SET $STATUS_WSL=%ERRORLEVEL%
IF %$STATUS_WSL% EQU 0 (echo WSL already installed.
	SET $STATUS_VT=Enabled
	SET $STATUS_MICROSOFT-WINDOWS-SUBSYSTEM-LINUX=Done
	SET $STATUS_VIRTUALMACHINEPLATFORM=Done
	SET $STATUS_REBOOT=Done
	wsl --status | find /I "2" 2> nul
	IF %ERRORLEVEL% EQU 0 SET $STATUS_WSL_DEFAULT_VERSION=2
	GoTo uwal)
IF %$STATUS_WSL% EQU 50 echo WSL not installed; will try quick method...
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

::::	WSL Quick method	:::::::::::::::::::::::::::::::::::::::::::::::::::
SET $WSL_INSTALL=1
wsl --install --no-distribution
SET $WSL_INSTALL_ERROR=%ERRORLEVEL%
SET $STATUS_VT=Enabled
SET $STATUS_MICROSOFT-WINDOWS-SUBSYSTEM-LINUX=Done
SET $STATUS_VIRTUALMACHINEPLATFORM=Done
SET $STATUS_REBOOT=Activated
IF %$WSL_INSTALL_ERROR% EQU 0 (shutdown -r -t 15 /c "WSL Setup requires reboot..." /d p:2:4
	GoTo uwal)
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


REM Below code is old.
:::: START OF OLD code:::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:::: Check if complete ::::::::::::::::::::::::::::::::::::::::::::::::::::::::
IF EXIST "%$LOGPATH%\WSL-Setup_Complete.txt" (
	CALL :banner
	call :GNU
	color 0A
	echo.
	echo WSL setup is done!
	echo Successfully installed on this system!
	echo WSL is successfully installed on this system! >> "%$LogPath%\%$LOG%"
	echo.
	GoTo jumpC
	)
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:checkPI
IF EXIST "%$LOGPATH%\var\Part-I-Reboot.txt" (
	SET $STATUS_VT=Check
	SET $STATUS_MICROSOFT-WINDOWS-SUBSYSTEM-LINUX=Done
	SET $STATUS_VIRTUALMACHINEPLATFORM=Done
	SET $STATUS_REBOOT=Done
	GoTo PartII
	)
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


::	Manual method::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	CALL :banner
	CALL :HUD
	echo.
Echo Something didn't go according to plan, trying more manual method....
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


::::Virtualization Check ::::::::::::::::::::::::::::::::::::::::::::::::::::::
:VT
	CALL :banner
	CALL :HUD
SET $VT_CHECK=0

echo.
echo Checking to see if:
echo	[VT] Virtualization Enabled In Firmware (BIOS) is turned on...
echo.

REM The following can not be relied on, as WSL can work with these being false.
wmic CPU GET VirtualizationFirmwareEnabled /VALUE > "%$LOGPATH%\var\$VirtualizationFirmwareEnabled.txt"
wmic CPU GET VMMonitorModeExtensions /VALUE > "%$LOGPATH%\var\$VMMonitorModeExtensions.txt"
wmic CPU GET SecondLevelAddressTranslationExtensions /VALUE > "%$LOGPATH%\var\$SecondLevelAddressTranslationExtensions.txt"

find /I "VirtualizationFirmwareEnabled=TRUE" "%$LOGPATH%\var\$VirtualizationFirmwareEnabled.txt" 1> nul 2> nul && (SET $VT_CHECK=1)
echo %$VT_CHECK% > "%$LOGPATH%\var\$VT_CHECK.txt"
IF %$VT_CHECK% EQU 1 ECHO Virtualization Enabled in the firmware, i.e. BIOS!
SET $STATUS_VT=Check
echo.
IF %$VT_CHECK% EQU 1 GoTo skipVT
	echo Hyper-V virtualization not detected!
	echo Searching for hypervisor...
	systeminfo | FIND /I "Hyper-V Requirements:" > "%$LOGPATH%\var\$HYPER-V_REQUIREMENTS.txt"
	SET $HYPERVISOR=0
	echo $HYPERVISOR: %$HYPERVISOR% > "%$LOGPATH%\var\$HYPERVISOR.txt"
	FIND /I "A hypervisor has been detected." "%$LOGPATH%\var\$HYPER-V_REQUIREMENTS.txt" 1> nul 2> nul && (SET $HYPERVISOR=1)
	IF %$HYPERVISOR% EQU 0 GoTo skipHypervisor
	echo A non-hyper-V hypervisor has been detected!
	echo This might be a virtual machine.
	echo Do you want to proceed anyway?
	Choice /C YN /T 60 /D Y /m "[Y]es or [N]o":
	IF %ERRORLEVEL% EQU 2 GoTo errHyper
	IF %ERRORLEVEL% EQU 1 GoTo skipVT	
	
:errHyper
	color 4E
	echo Virtualization disabled in the firmware ^(BIOS^)!
	echo ...or non-Hyper-V hypervisor detected! 
	echo.
	echo Virtualization is required for Hyper-V and WSL!
	echo Turn on [VT] Virtualization in the BIOS.
	echo Script will now abort!
	echo.
	SET $STATUS_VT=FAILED
	PAUSE
	GoTo end

:skipVT
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

CALL :banner
CALL :HUD
	
:::: DISM :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
Dism /online /Get-FeatureInfo /FeatureName:Microsoft-Windows-Subsystem-Linux > "%$LOGPATH%\var\$FEATURE_MICROSOFT-WINDOWS-SUBSYSTEM-LINUX.txt"
FIND /I "State : Enabled" "%$LOGPATH%\var\$FEATURE_MICROSOFT-WINDOWS-SUBSYSTEM-LINUX.txt" 1> nul 2> nul && (SET $STATUS_MICROSOFT-WINDOWS-SUBSYSTEM-LINUX=Check) && GoTo skipFMWSL
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
SET $STATUS_MICROSOFT-WINDOWS-SUBSYSTEM-LINUX=Done
:skipFMWSL

CALL :banner
CALL :HUD
Dism /online /Get-FeatureInfo /FeatureName:VirtualMachinePlatform > "%$LOGPATH%\var\$VIRTUALMACHINEPLATFORM.txt"
FIND /I "State : Enabled" "%$LOGPATH%\var\$VIRTUALMACHINEPLATFORM.txt" 1> nul 2> nul && (SET $STATUS_VIRTUALMACHINEPLATFORM=Check) && GoTo skipVMP
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
SET $STATUS_VIRTUALMACHINEPLATFORM=Done
:skipVMP
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

CALL :banner
CALL :HUD

IF EXIST "%$LOGPATH%\var\Part-I-Reboot.txt" (SET $STATUS_REBOOT=Check) && GoTo skipReboot
echo WSL Setup reboot: %DATE% %TIME% > "%$LOGPATH%\var\Part-I-Reboot.txt"
SET $STATUS_REBOOT=Rebooting
shutdown /r /t 10 /c "WSL Setup requires reboot..." /d p:2:4
echo rebooting: %date% %time% >> "%$LogPath%\%$LOG%"
echo. >> "%$LogPath%\%$LOG%"
echo.
CALL :banner
CALL :HUD
echo.
PAUSE
:skipReboot
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:::: Part II ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:Conf
CALL :banner
CALL :HUD

wsl --set-default-version 2
SET $STATUS_WSL_DEFAULT_VERSION=2
echo WSL Setup Part-II: %DATE% %TIME% > "%$LOGPATH%\var\Part-II-Complete.txt"
IF EXIST "%$LOGPATH%\var\Part-II-Complete.txt" echo WSL Setup completed: %DATE% %TIME% > "%$LOGPATH%\WSL-Setup_Complete.txt"
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:::: END OF OLD code:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


:: WSL Kernel update:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:uwal
wsl --update
SET $STATUS_WSL_KERNEL_UPDATE=Done
GoTo End


:::: End ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:End
::IF EXIST "%$LOGPATH%\WSL-Setup_Complete.txt" IF %$DEGUB_MODE% EQU 0 RD /S /Q "%$LOGPATH%\var"
CALL :banner
CALL :HUD
CALL :GNU
echo.
echo WSL (Windows Subsystem for Linux) installation is complete! 
::IF EXIST "%$LOGPATH%\WSL-Setup_Complete.txt" (
::	color 0A
::	echo WSL Setup Completed!
::	)
::IF NOT EXIST "%$LOGPATH%\WSL-Setup_Complete.txt" echo WSL Setup is not complete!
:jumpC
echo.
echo End %DATE% %TIME% >> "%$LogPath%\%$LOG%"
timeout /t 30
exit
