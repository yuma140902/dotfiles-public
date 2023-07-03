@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
CD /D "%~DP0"

IF "%PYTHON%"=="" (
  WHERE python3 >NUL 2>NUL
  IF !ERRORLEVEL! EQU 0 (
    SET PYTHON=python3
  ) ELSE (
    WHERE python >NUL 2>NUL
    IF !ERRORLEVEL! EQU 0 (
      SET PYTHON=python
    ) ELSE (
      ECHO Python not found
      EXIT /b 1
    )
  )
)

%PYTHON% dotfiles.py %*
