@echo off
setlocal enabledelayedexpansion

title Zombie Survival Game
cls

:: initial stats
set health=100
set ammo=5
set turns=0
set maxTurns=10

:Intro
echo ***************************************
echo *    ZOMBIE APOCALYPSE SURVIVAL      *
echo ***************************************
echo You have %health% health and %ammo% ammo.
echo You must survive %maxTurns% turns.
echo.
pause

:MainLoop
cls
set /a turns+=1
echo TURN !turns! of %maxTurns%
echo Health: %health%
echo Ammo:  %ammo%
echo.
echo What will you do?
echo 1) Search for supplies
echo 2) Fight zombies
echo 3) Rest and recover
set /p choice=Choose 1, 2 or 3: 

if "%choice%"=="1" goto Search
if "%choice%"=="2" goto Fight
if "%choice%"=="3" goto Rest
echo Invalid choice. Try again.
pause
goto MainLoop

:Search
cls
echo You search the area...
set /a event=%random% %% 3
if !event! equ 0 (
    echo You found ammo! +3 ammo.
    set /a ammo+=3
) else if !event! equ 1 (
    echo You found a health pack! +20 health.
    set /a health+=20
    if !health! gtr 100 set health=100
) else (
    echo Oh no — a zombie ambush!
    echo You fight it quickly but get scratched.
    set /a health-=15
)
pause
goto CheckEnd

:Fight
cls
if %ammo% leq 0 (
    echo You have no ammo! You cannot fight.
    pause
    goto MainLoop
)
echo You engage the zombies...
set /a ammo-=1
set /a event=%random% %% 2
if !event! equ 0 (
    echo Success — you killed the zombies without much damage.
) else (
    echo You killed them but got hit while escaping.
    set /a health-=20
)
pause
goto CheckEnd

:Rest
cls
echo You take a moment to rest.
echo You regain +10 health.
set /a health+=10
if !health! gtr 100 set health=100
pause
goto CheckEnd

:CheckEnd
if %health% leq 0 (
    echo.
    echo You died. Game over.
    goto End
)
if %turns% geq %maxTurns% (
    echo.
    echo Congratulations — you survived %maxTurns% turns! You win!
    goto End
)
goto MainLoop

:End
echo.
echo Final stats:
echo Health: %health%
echo Ammo:  %ammo%
echo Turns survived: %turns%
echo.
pause
exit
