@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

REM Script de Backup para Saves do Recalbox - Windows
REM Autor: Usuário
REM Data: %date%

REM Configurações
set "RECALBOX_PATH=\\RECALBOX\share\saves"
set "LANGUAGE=pt"

REM Detecta se PowerShell está disponível para cores
set "USE_COLORS=0"
powershell -Command "exit 0" >nul 2>&1
if !errorlevel! equ 0 (
    set "USE_COLORS=1"
)

REM Função para exibir mensagens coloridas
call :init_messages

:main
REM Seleciona idioma
call :select_language

REM Verifica se está executando como administrador desnecessariamente
net session >nul 2>&1
if %errorlevel% equ 0 (
    call :print_warning "!warning_admin_msg!"
    call :print_info "!run_normal_msg!"
    echo.
    pause
)

:menu_loop
call :show_menu
set /p "option=!choose_option_msg! [1-5]: "

if "!option!"=="1" (
    echo.
    call :check_dependencies
    echo.
    pause
) else if "!option!"=="2" (
    echo.
    call :check_path
    echo.
    pause
) else if "!option!"=="3" (
    echo.
    call :perform_backup
    echo.
    pause
) else if "!option!"=="4" (
    echo.
    call :perform_restore
    echo.
    pause
) else if "!option!"=="5" (
    call :print_info "!exiting_msg!"
    exit /b 0
) else (
    call :print_error "!invalid_option_msg! 1, 2, 3, 4 !or_msg! 5."
    timeout /t 2 >nul
)
goto menu_loop

:select_language
cls
echo ==================================
echo     LANGUAGE / IDIOMA / IDIOMA    
echo ==================================
echo.
echo 1^) Português ^(Brasil^)
echo 2^) English ^(US^)
echo 3^) Español ^(ES^)
echo.
set /p "lang_option=Choose your language / Escolha seu idioma / Elige tu idioma [1-3]: "

if "!lang_option!"=="1" (
    set "LANGUAGE=pt"
) else if "!lang_option!"=="2" (
    set "LANGUAGE=en"
) else if "!lang_option!"=="3" (
    set "LANGUAGE=es"
) else (
    echo Invalid option / Opção inválida / Opción inválida. Using Portuguese / Usando português.
    set "LANGUAGE=pt"
    timeout /t 2 >nul
)
goto :eof

:init_messages
REM Português
if "!LANGUAGE!"=="pt" (
    set "title_msg=BACKUP DE SAVES - RECALBOX"
    set "menu_deps_msg=Verificar dependências do sistema"
    set "menu_path_msg=Verificar caminho dos saves"
    set "menu_backup_msg=Realizar backup"
    set "menu_restore_msg=Restaurar saves"
    set "menu_exit_msg=Sair"
    set "choose_option_msg=Escolha uma opção"
    set "press_enter_msg=Pressione qualquer tecla para continuar..."
    set "invalid_option_msg=Opção inválida! Escolha entre"
    set "exiting_msg=Saindo do script..."
    set "error_msg=ERRO"
    set "success_msg=SUCESSO"
    set "warning_msg=AVISO"
    set "info_msg=INFO"
    set "checking_deps_msg=Verificando dependências do sistema..."
    set "all_deps_ok_msg=Todas as dependências estão disponíveis!"
    set "missing_deps_msg=Dependências necessárias não estão disponíveis:"
    set "checking_connectivity_msg=Verificando conectividade com o Recalbox..."
    set "connectivity_failed_msg=Não foi possível conectar ao Recalbox"
    set "check_network_msg=Verifique se:"
    set "recalbox_on_msg=O Recalbox está ligado e conectado à rede"
    set "smb_enabled_msg=O compartilhamento SMB está habilitado no Recalbox"
    set "same_network_msg=Você está na mesma rede que o Recalbox"
    set "connectivity_ok_msg=Conectividade com Recalbox OK"
    set "checking_path_msg=Verificando se o caminho dos saves existe..."
    set "saves_found_msg=Pasta de saves encontrada:"
    set "saves_content_msg=Conteúdo da pasta saves:"
    set "saves_not_found_msg=Pasta 'saves' não encontrada no compartilhamento"
    set "starting_backup_msg=Iniciando processo de backup..."
    set "enter_dest_path_msg=Digite o caminho completo onde deseja salvar o backup:"
    set "dest_empty_msg=Caminho de destino não pode estar vazio"
    set "dest_not_exist_msg=Diretório de destino não existe"
    set "create_dir_msg=Deseja criar o diretório? (s/N):"
    set "dir_created_msg=Diretório criado:"
    set "create_dir_failed_msg=Falha ao criar diretório:"
    set "backup_cancelled_msg=Backup cancelado"
    set "copying_to_msg=Copiando saves para:"
    set "backup_success_msg=Backup realizado com sucesso!"
    set "backup_failed_msg=Falha ao realizar o backup"
    set "backup_info_msg=Informações do backup:"
    set "location_msg=Local:"
    set "size_msg=Tamanho:"
    set "files_msg=Arquivos:"
    set "folders_msg=Pastas:"
    set "date_msg=Data:"
    set "starting_restore_msg=Iniciando processo de restauração..."
    set "enter_backup_path_msg=Digite o caminho completo da pasta de backup:"
    set "backup_path_empty_msg=Caminho do backup não pode estar vazio"
    set "backup_not_exist_msg=Pasta de backup não existe:"
    set "checking_backup_content_msg=Verificando conteúdo do backup..."
    set "backup_seems_empty_msg=A pasta de backup parece estar vazia"
    set "found_folders_msg=Encontradas as seguintes pastas:"
    set "confirm_restore_msg=Deseja continuar com a restauração? (s/N):"
    set "restore_cancelled_msg=Restauração cancelada"
    set "copying_from_msg=Copiando saves de:"
    set "restore_success_msg=Restauração realizada com sucesso!"
    set "restore_failed_msg=Falha ao realizar a restauração"
    set "restore_info_msg=Informações da restauração:"
    set "folders_copied_msg=Pastas copiadas:"
    set "copied_success_msg=copiada com sucesso"
    set "copy_failed_msg=Falha ao copiar"
    set "warning_admin_msg=Não é recomendado executar este script como administrador"
    set "run_normal_msg=Execute como usuário normal quando possível"
    set "or_msg=ou"
    set "robocopy_available_msg=Robocopy disponível"
    set "xcopy_fallback_msg=Usando XCOPY como alternativa"
    set "powershell_available_msg=PowerShell disponível"
    set "powershell_unavailable_msg=PowerShell não disponível"
)

REM English
if "!LANGUAGE!"=="en" (
    set "title_msg=RECALBOX SAVES BACKUP"
    set "menu_deps_msg=Check system dependencies"
    set "menu_path_msg=Check saves path"
    set "menu_backup_msg=Perform backup"
    set "menu_restore_msg=Restore saves"
    set "menu_exit_msg=Exit"
    set "choose_option_msg=Choose an option"
    set "press_enter_msg=Press any key to continue..."
    set "invalid_option_msg=Invalid option! Choose between"
    set "exiting_msg=Exiting script..."
    set "error_msg=ERROR"
    set "success_msg=SUCCESS"
    set "warning_msg=WARNING"
    set "info_msg=INFO"
    set "checking_deps_msg=Checking system dependencies..."
    set "all_deps_ok_msg=All dependencies are available!"
    set "missing_deps_msg=Required dependencies are not available:"
    set "checking_connectivity_msg=Checking connectivity with Recalbox..."
    set "connectivity_failed_msg=Could not connect to Recalbox"
    set "check_network_msg=Please check that:"
    set "recalbox_on_msg=Recalbox is on and connected to the network"
    set "smb_enabled_msg=SMB sharing is enabled on Recalbox"
    set "same_network_msg=You are on the same network as Recalbox"
    set "connectivity_ok_msg=Connectivity with Recalbox OK"
    set "checking_path_msg=Checking if saves path exists..."
    set "saves_found_msg=Saves folder found:"
    set "saves_content_msg=Saves folder contents:"
    set "saves_not_found_msg='saves' folder not found in share"
    set "starting_backup_msg=Starting backup process..."
    set "enter_dest_path_msg=Enter the full path where you want to save the backup:"
    set "dest_empty_msg=Destination path cannot be empty"
    set "dest_not_exist_msg=Destination directory does not exist"
    set "create_dir_msg=Do you want to create the directory? (y/N):"
    set "dir_created_msg=Directory created:"
    set "create_dir_failed_msg=Failed to create directory:"
    set "backup_cancelled_msg=Backup cancelled"
    set "copying_to_msg=Copying saves to:"
    set "backup_success_msg=Backup completed successfully!"
    set "backup_failed_msg=Failed to perform backup"
    set "backup_info_msg=Backup information:"
    set "location_msg=Location:"
    set "size_msg=Size:"
    set "files_msg=Files:"
    set "folders_msg=Folders:"
    set "date_msg=Date:"
    set "starting_restore_msg=Starting restore process..."
    set "enter_backup_path_msg=Enter the full path to the backup folder:"
    set "backup_path_empty_msg=Backup path cannot be empty"
    set "backup_not_exist_msg=Backup folder does not exist:"
    set "checking_backup_content_msg=Checking backup content..."
    set "backup_seems_empty_msg=The backup folder seems to be empty"
    set "found_folders_msg=Found the following folders:"
    set "confirm_restore_msg=Do you want to continue with the restore? (y/N):"
    set "restore_cancelled_msg=Restore cancelled"
    set "copying_from_msg=Copying saves from:"
    set "restore_success_msg=Restore completed successfully!"
    set "restore_failed_msg=Failed to perform restore"
    set "restore_info_msg=Restore information:"
    set "folders_copied_msg=Folders copied:"
    set "copied_success_msg=copied successfully"
    set "copy_failed_msg=Failed to copy"
    set "warning_admin_msg=It's not recommended to run this script as administrator"
    set "run_normal_msg=Run as normal user when possible"
    set "or_msg=or"
    set "robocopy_available_msg=Robocopy available"
    set "xcopy_fallback_msg=Using XCOPY as fallback"
    set "powershell_available_msg=PowerShell available"
    set "powershell_unavailable_msg=PowerShell not available"
)

REM Español
if "!LANGUAGE!"=="es" (
    set "title_msg=RESPALDO DE SAVES - RECALBOX"
    set "menu_deps_msg=Verificar dependencias del sistema"
    set "menu_path_msg=Verificar ruta de saves"
    set "menu_backup_msg=Realizar respaldo"
    set "menu_restore_msg=Restaurar saves"
    set "menu_exit_msg=Salir"
    set "choose_option_msg=Elige una opción"
    set "press_enter_msg=Presiona cualquier tecla para continuar..."
    set "invalid_option_msg=¡Opción inválida! Elige entre"
    set "exiting_msg=Saliendo del script..."
    set "error_msg=ERROR"
    set "success_msg=ÉXITO"
    set "warning_msg=ADVERTENCIA"
    set "info_msg=INFO"
    set "checking_deps_msg=Verificando dependencias del sistema..."
    set "all_deps_ok_msg=¡Todas las dependencias están disponibles!"
    set "missing_deps_msg=Dependencias requeridas no están disponibles:"
    set "checking_connectivity_msg=Verificando conectividad con Recalbox..."
    set "connectivity_failed_msg=No se pudo conectar a Recalbox"
    set "check_network_msg=Verifica que:"
    set "recalbox_on_msg=Recalbox esté encendido y conectado a la red"
    set "smb_enabled_msg=El compartir SMB esté habilitado en Recalbox"
    set "same_network_msg=Estés en la misma red que Recalbox"
    set "connectivity_ok_msg=Conectividad con Recalbox OK"
    set "checking_path_msg=Verificando si la ruta de saves existe..."
    set "saves_found_msg=Carpeta de saves encontrada:"
    set "saves_content_msg=Contenido de la carpeta saves:"
    set "saves_not_found_msg=Carpeta 'saves' no encontrada en el compartir"
    set "starting_backup_msg=Iniciando proceso de respaldo..."
    set "enter_dest_path_msg=Ingresa la ruta completa donde deseas guardar el respaldo:"
    set "dest_empty_msg=La ruta de destino no puede estar vacía"
    set "dest_not_exist_msg=El directorio de destino no existe"
    set "create_dir_msg=¿Deseas crear el directorio? (s/N):"
    set "dir_created_msg=Directorio creado:"
    set "create_dir_failed_msg=Falló al crear directorio:"
    set "backup_cancelled_msg=Respaldo cancelado"
    set "copying_to_msg=Copiando saves a:"
    set "backup_success_msg=¡Respaldo realizado exitosamente!"
    set "backup_failed_msg=Falló al realizar el respaldo"
    set "backup_info_msg=Información del respaldo:"
    set "location_msg=Ubicación:"
    set "size_msg=Tamaño:"
    set "files_msg=Archivos:"
    set "folders_msg=Carpetas:"
    set "date_msg=Fecha:"
    set "starting_restore_msg=Iniciando proceso de restauración..."
    set "enter_backup_path_msg=Ingresa la ruta completa de la carpeta de respaldo:"
    set "backup_path_empty_msg=La ruta del respaldo no puede estar vacía"
    set "backup_not_exist_msg=La carpeta de respaldo no existe:"
    set "checking_backup_content_msg=Verificando contenido del respaldo..."
    set "backup_seems_empty_msg=La carpeta de respaldo parece estar vacía"
    set "found_folders_msg=Se encontraron las siguientes carpetas:"
    set "confirm_restore_msg=¿Deseas continuar con la restauración? (s/N):"
    set "restore_cancelled_msg=Restauración cancelada"
    set "copying_from_msg=Copiando saves desde:"
    set "restore_success_msg=¡Restauración realizada exitosamente!"
    set "restore_failed_msg=Falló al realizar la restauración"
    set "restore_info_msg=Información de la restauración:"
    set "folders_copied_msg=Carpetas copiadas:"
    set "copied_success_msg=copiada exitosamente"
    set "copy_failed_msg=Falló al copiar"
    set "warning_admin_msg=No se recomienda ejecutar este script como administrador"
    set "run_normal_msg=Ejecuta como usuario normal cuando sea posible"
    set "or_msg=o"
    set "robocopy_available_msg=Robocopy disponible"
    set "xcopy_fallback_msg=Usando XCOPY como alternativa"
    set "powershell_available_msg=PowerShell disponible"
    set "powershell_unavailable_msg=PowerShell no disponible"
)
goto :eof

:print_error
set "msg=[!error_msg!] %~1"
if "%USE_COLORS%"=="1" (
    powershell -Command "Write-Host '%msg%' -ForegroundColor Red"
) else (
    echo !msg!
)
goto :eof

:print_success
set "msg=[!success_msg!] %~1"
if "%USE_COLORS%"=="1" (
    powershell -Command "Write-Host '%msg%' -ForegroundColor Green"
) else (
    echo !msg!
)
goto :eof

:print_warning
set "msg=[!warning_msg!] %~1"
if "%USE_COLORS%"=="1" (
    powershell -Command "Write-Host '%msg%' -ForegroundColor Yellow"
) else (
    echo !msg!
)
goto :eof

:print_info
set "msg=[!info_msg!] %~1"
if "%USE_COLORS%"=="1" (
    powershell -Command "Write-Host '%msg%' -ForegroundColor Cyan"
) else (
    echo !msg!
)
goto :eof

:show_menu
cls
echo ==================================
echo    !title_msg!    
echo ==================================
echo.
echo 1^) !menu_deps_msg!
echo 2^) !menu_path_msg!
echo 3^) !menu_backup_msg!
echo 4^) !menu_restore_msg!
echo 5^) !menu_exit_msg!
echo.
goto :eof

:check_dependencies
call :print_info "!checking_deps_msg!"
echo.

set "missing_deps="
set "available_deps="

REM Verifica Robocopy (incluído no Windows Vista+)
robocopy /? >nul 2>&1
if %errorlevel% geq 8 (
    set "missing_deps=!missing_deps! Robocopy"
) else (
    set "available_deps=!available_deps! Robocopy"
    call :print_success "!robocopy_available_msg!"
)

REM Verifica PowerShell
powershell -Command "Get-Host" >nul 2>&1
if %errorlevel% neq 0 (
    set "missing_deps=!missing_deps! PowerShell"
    call :print_warning "!powershell_unavailable_msg!"
) else (
    set "available_deps=!available_deps! PowerShell"
    call :print_success "!powershell_available_msg!"
)

if "!missing_deps!"=="" (
    call :print_success "!all_deps_ok_msg!"
) else (
    call :print_error "!missing_deps_msg!"
    echo   -!missing_deps!
    echo.
    call :print_info "Robocopy: Incluído no Windows Vista+"
    call :print_info "PowerShell: Incluído no Windows 7+"
    call :print_info "XCOPY: Disponível como alternativa"
)
goto :eof

:check_connectivity
call :print_info "!checking_connectivity_msg!"

REM Tenta pingar o Recalbox usando diferentes métodos
ping -n 1 -w 3000 RECALBOX >nul 2>&1
if %errorlevel% equ 0 (
    call :print_success "!connectivity_ok_msg!"
    goto :eof
)

REM Se ping RECALBOX falhou, tenta recalbox.local
ping -n 1 -w 3000 recalbox.local >nul 2>&1
if %errorlevel% equ 0 (
    call :print_success "!connectivity_ok_msg! (via recalbox.local)"
    goto :eof
)

REM Se ambos falharam, tenta verificar diretamente o compartilhamento
net view \\RECALBOX >nul 2>&1
if %errorlevel% equ 0 (
    call :print_success "!connectivity_ok_msg! (compartilhamento SMB detectado)"
    goto :eof
)

REM Todos os métodos falharam
call :print_error "!connectivity_failed_msg!"
call :print_warning "!check_network_msg!"
echo   - !recalbox_on_msg!
echo   - !smb_enabled_msg!
echo   - !same_network_msg!
call :print_info "Testado: ping RECALBOX, ping recalbox.local, net view \\RECALBOX"
exit /b 1
goto :eof

:check_path
call :print_info "!checking_path_msg!"
call :print_info "Testando caminho: !RECALBOX_PATH!"

REM Verifica conectividade primeiro
call :print_info "Verificando conectividade..."
call :check_connectivity
if %errorlevel% neq 0 (
    call :print_error "Falha na conectividade. Abortando verificação de caminho."
    goto :eof
)

REM Verifica se o caminho do Recalbox existe
call :print_info "Verificando se o caminho existe..."
if not exist "!RECALBOX_PATH!" (
    call :print_error "!saves_not_found_msg!"
    call :print_info "Caminho testado: !RECALBOX_PATH!"
    call :print_warning "Dicas para resolver:"
    echo   - Verifique se o Recalbox está ligado
    echo   - Confirme que o compartilhamento SMB está ativo
    echo   - Teste acessar \\RECALBOX no Explorer
    goto :eof
)

call :print_success "!saves_found_msg! !RECALBOX_PATH!"
echo.
call :print_info "!saves_content_msg!"

REM Lista as pastas dentro do diretório saves (máximo 10)
call :print_info "Listando pastas..."
set "count=0"
for /f "delims=" %%i in ('dir "!RECALBOX_PATH!" /AD /B 2^>nul') do (
    if !count! lss 10 (
        echo   - %%i
        set /a count+=1
    )
)

if !count! equ 0 (
    call :print_warning "Nenhuma pasta encontrada em !RECALBOX_PATH!"
    call :print_info "Isso pode significar que não há saves ou há um problema de acesso"
) else (
    echo.
    call :print_info "Calculando estatísticas..."
    
    REM Conta pastas de forma mais segura
    set "folder_count=0"
    for /f "delims=" %%i in ('dir "!RECALBOX_PATH!" /AD /B 2^>nul') do (
        set /a folder_count+=1
    )
    
    REM Conta arquivos apenas se não for muitos (evita travamento)
    if !folder_count! lss 20 (
        call :print_info "Contando arquivos..."
        set "file_count=0"
        for /f "delims=" %%i in ('dir "!RECALBOX_PATH!" /S /A-D /B 2^>nul') do (
            set /a file_count+=1
        )
        call :print_info "Total: !folder_count! !folders_msg!, !file_count! !files_msg!"
    ) else (
        call :print_info "Total: !folder_count! !folders_msg! (muitas pastas, pulando contagem de arquivos)"
    )
)

call :print_success "Verificação de caminho concluída!"
goto :eof

:copy_folder_manual
set "source_folder=%~1"
set "dest_folder=%~2"

REM Cria a pasta de destino
if not exist "%dest_folder%" (
    mkdir "%dest_folder%" 2>nul
    if !errorlevel! neq 0 (
        exit /b 1
    )
)

REM Copia arquivos da pasta atual
for /f "delims=" %%f in ('dir "%source_folder%" /A-D /B 2^>nul') do (
    copy "%source_folder%\%%f" "%dest_folder%\" >nul 2>&1
    if !errorlevel! neq 0 (
        REM Tenta com PowerShell se copy falhar
        powershell -Command "Copy-Item '%source_folder%\%%f' '%dest_folder%\' -Force" >nul 2>&1
    )
)

REM Copia subpastas recursivamente
for /f "delims=" %%d in ('dir "%source_folder%" /AD /B 2^>nul') do (
    call :copy_folder_manual "%source_folder%\%%d" "%dest_folder%\%%d"
)

exit /b 0

:perform_backup
call :print_info "!starting_backup_msg!"
echo.

REM Verifica conectividade
call :check_connectivity
if %errorlevel% neq 0 (
    call :print_error "Não é possível continuar com o backup"
    goto :eof
)

REM Solicita o diretório de destino
echo.
set /p "backup_dest=!enter_dest_path_msg! "

if "!backup_dest!"=="" (
    call :print_error "!dest_empty_msg!"
    goto :eof
)

REM Verifica se o diretório de destino existe
if not exist "!backup_dest!" (
    call :print_warning "!dest_not_exist_msg!"
    set /p "create_dir=!create_dir_msg! "
    if /i "!create_dir!"=="s" (
        mkdir "!backup_dest!" 2>nul
        if %errorlevel% equ 0 (
            call :print_success "!dir_created_msg! !backup_dest!"
        ) else (
            call :print_error "!create_dir_failed_msg! !backup_dest!"
            goto :eof
        )
    ) else if /i "!create_dir!"=="y" (
        mkdir "!backup_dest!" 2>nul
        if %errorlevel% equ 0 (
            call :print_success "!dir_created_msg! !backup_dest!"
        ) else (
            call :print_error "!create_dir_failed_msg! !backup_dest!"
            goto :eof
        )
    ) else (
        call :print_error "!backup_cancelled_msg!"
        goto :eof
    )
)

REM Cria nome do backup com timestamp
for /f "tokens=1-3 delims=/- " %%a in ('date /t') do set "backup_date=%%c%%b%%a"
for /f "tokens=1-2 delims=: " %%a in ('time /t') do set "backup_time=%%a%%b"
set "backup_time=!backup_time: =!"
set "backup_name=recalbox_saves_backup_!backup_date!_!backup_time!"
set "backup_full_path=!backup_dest!\!backup_name!"

call :print_info "!copying_to_msg! !backup_full_path!"
echo.

REM Cria o diretório de backup
mkdir "!backup_full_path!" 2>nul

REM Realiza a cópia usando diferentes métodos
call :print_info "Iniciando cópia dos saves..."

REM Método 1: Robocopy (mais robusto)
robocopy /? >nul 2>&1
if !errorlevel! lss 8 (
    call :print_info "Usando Robocopy..."
    robocopy "!RECALBOX_PATH!" "!backup_full_path!" /E /COPY:DAT /R:1 /W:1 /NP /MT:4
    set "copy_result=!errorlevel!"
) else (
    REM Método 2: XCOPY como fallback
    call :print_warning "!xcopy_fallback_msg!"
    xcopy "!RECALBOX_PATH!\*" "!backup_full_path!\" /E /I /H /Y /C
    set "copy_result=!errorlevel!"
)

REM Se ambos falharam, tenta cópia manual
if !copy_result! geq 4 (
    call :print_warning "Tentando cópia manual..."
    call :copy_folder_manual "!RECALBOX_PATH!" "!backup_full_path!"
    set "copy_result=!errorlevel!"
)

if !copy_result! lss 4 (
    call :print_success "!backup_success_msg!"
    echo.
    
    REM Mostra informações do backup
    call :print_info "!backup_info_msg!"
    echo   - !location_msg! !backup_full_path!
    
    REM Calcula estatísticas
    set "folder_count=0"
    set "file_count=0"
    for /f %%i in ('dir "!backup_full_path!" /AD /S /B 2^>nul ^| find /c /v ""') do set "folder_count=%%i"
    for /f %%i in ('dir "!backup_full_path!" /A-D /S /B 2^>nul ^| find /c /v ""') do set "file_count=%%i"
    
    echo   - !folders_msg! !folder_count!
    echo   - !files_msg! !file_count!
    echo   - !date_msg! %date% %time%
) else (
    call :print_error "!backup_failed_msg!"
    REM Remove diretório parcial se existir
    if exist "!backup_full_path!" rmdir /S /Q "!backup_full_path!" 2>nul
)
goto :eof

:perform_restore
call :print_info "!starting_restore_msg!"
echo.

REM Verifica conectividade
call :check_connectivity
if %errorlevel% neq 0 (
    call :print_error "Não é possível continuar com a restauração"
    goto :eof
)

REM Solicita o diretório do backup
echo.
set /p "backup_path=!enter_backup_path_msg! "

if "!backup_path!"=="" (
    call :print_error "!backup_path_empty_msg!"
    goto :eof
)

REM Verifica se o diretório de backup existe
if not exist "!backup_path!" (
    call :print_error "!backup_not_exist_msg! !backup_path!"
    goto :eof
)

REM Verifica o conteúdo do backup
call :print_info "!checking_backup_content_msg!"
echo.

REM Lista as pastas dentro do backup
set "folder_count=0"
for /f %%i in ('dir "!backup_path!" /AD /B 2^>nul ^| find /c /v ""') do set "folder_count=%%i"

if !folder_count! equ 0 (
    call :print_error "!backup_seems_empty_msg!"
    goto :eof
)

call :print_info "!found_folders_msg!"
for /f %%i in ('dir "!backup_path!" /AD /B 2^>nul') do (
    set "folder_name=%%i"
    echo   - !folder_name!
)
echo.

REM Confirma a restauração
set /p "confirm_restore=!confirm_restore_msg! "
if /i not "!confirm_restore!"=="s" if /i not "!confirm_restore!"=="y" (
    call :print_error "!restore_cancelled_msg!"
    goto :eof
)

call :print_info "!copying_from_msg! !backup_path!"
echo.

set "copied_folders=0"
set "failed_folders=0"

REM Copia cada pasta individualmente
for /f "delims=" %%i in ('dir "!backup_path!" /AD /B 2^>nul') do (
    set "folder_name=%%i"
    call :print_info "!copying_to_msg! !folder_name!..."
    
    REM Cria a pasta de destino primeiro
    if not exist "!RECALBOX_PATH!\!folder_name!" (
        mkdir "!RECALBOX_PATH!\!folder_name!" 2>nul
    )
    
    REM Usa diferentes métodos dependendo da disponibilidade
    set "copy_success=0"
    
    REM Método 1: Robocopy (mais robusto para estruturas complexas)
    robocopy /? >nul 2>&1
    if !errorlevel! lss 8 (
        call :print_info "  Usando Robocopy para !folder_name!..."
        REM Parâmetros otimizados para compatibilidade
        robocopy "!backup_path!\!folder_name!" "!RECALBOX_PATH!\!folder_name!" /E /COPYALL /R:1 /W:1 /NP /NDL /NC /NS /NJH /NJS >nul 2>&1
        set "robocopy_exit=!errorlevel!"
        REM Robocopy considera 0-3 como sucesso
        if !robocopy_exit! lss 4 (
            set "copy_success=1"
        )
    )
    
    REM Método 2: XCOPY se Robocopy falhou
    if "!copy_success!"=="0" (
        call :print_info "  Usando XCOPY para !folder_name!..."
        REM Cria pasta de destino primeiro
        if not exist "!RECALBOX_PATH!\!folder_name!" (
            mkdir "!RECALBOX_PATH!\!folder_name!" 2>nul
        )
        REM XCOPY com parâmetros otimizados
        xcopy "!backup_path!\!folder_name!" "!RECALBOX_PATH!\!folder_name!" /E /I /H /Y /C /Q >nul 2>&1
        if !errorlevel! equ 0 (
            set "copy_success=1"
        )
    )
    
    REM Método 3: Cópia manual arquivo por arquivo se ambos falharam
    if "!copy_success!"=="0" (
        call :print_info "  Usando cópia manual para !folder_name!..."
        call :copy_folder_manual "!backup_path!\!folder_name!" "!RECALBOX_PATH!\!folder_name!"
        if !errorlevel! equ 0 (
            set "copy_success=1"
        )
    )
    
    REM Verifica resultado final
    if "!copy_success!"=="1" (
        call :print_success "  ✓ !folder_name! !copied_success_msg!"
        set /a copied_folders+=1
    ) else (
        call :print_error "  ✗ !copy_failed_msg! !folder_name!"
        set /a failed_folders+=1
    )
)

echo.
if !copied_folders! gtr 0 (
    call :print_success "!restore_success_msg!"
    echo.
    call :print_info "!restore_info_msg!"
    echo   - !location_msg! !RECALBOX_PATH!
    echo   - !folders_copied_msg! !copied_folders!
    echo   - !date_msg! %date% %time%
) else (
    call :print_error "!restore_failed_msg!"
)
goto :eof