# Путь к папке
$folderPath = "C:\ProgramData\1C\licenses"

# Находим все текстовые файлы в указанной папке
$textFiles = Get-ChildItem -Path $folderPath -Filter *.lic

#Переменная для клиентских
$valueCli = 0
#Переменная для серверных
$valueSrv = 0

# Перебираем каждый файл
foreach ($file in $textFiles) {
    # Читаем содержимое файла, обращаем внимание на кодировку
    $fileContent = Get-Content -Path $file.FullName -Encoding "UTF8"
    
    # Проверяем наличие подстроки "Тип лицензии: клиент"
    if ($fileContent -match "Тип лицензии: клиент") {
        # Если подстрока найдена, ищем строку "Количество пользователей:"
        foreach ($line in $fileContent) {
            if ($line -match "Количество пользователей:") {
		$line =  $line.Replace("Количество пользователей: ", "")                
		$valueCli = $valueCli + $line  
            }
        }
    }
# Проверяем наличие подстроки "Тип лицензии: сервер"
if ($fileContent -match "Тип лицензии: сервер") {
        # Если подстрока найдена, ищем строку "Количество пользователей:"
        foreach ($line in $fileContent) {
            if ($line -match "Количество пользователей:") {
		$line =  $line.Replace("Количество пользователей: ", "")                
		$valueSrv = $valueSrv + $line  
            }
        }
    }
}

Write-Output "Количество клиентских лицензий: " $valueCli 
Write-Output "Количество серверных лицензий: " $valueSrv

Read-Host "Нажмите Enter для выхода"
