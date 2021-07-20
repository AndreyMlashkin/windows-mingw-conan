# escape=`
FROM mcr.microsoft.com/windows/servercore:1909

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'Continue';"]

# Install chocolatey
RUN Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install working tools 
RUN choco install -y cmake --installargs 'ADD_CMAKE_TO_PATH=System'
RUN choco install -y mingw
RUN choco install -y conan

COPY profile C:\Users\ContainerAdministrator\.conan\profiles\default

# TEST, remove
RUN conan install vulkan-loader/1.2.182@ --build missing

ENTRYPOINT [ "powershell.exe"]
