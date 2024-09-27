import sys
import subprocess
pythonExeLocationAndName=sys.executable
listOfPackagesToInstall='requirements.txt'

pipInstallRequredPackagesString=f'"{pythonExeLocationAndName}" -m pip install -r requirements.txt'

print("Statring instllation of requred packages")
print(pipInstallRequredPackagesString)
subprocess.Popen(pipInstallRequredPackagesString, shell=True)
