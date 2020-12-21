import os
import sys
import shutil
import socket

def generateRepo(repo_url):
    fileName = "./roles/common/files/k8s.repo"
    with open(fileName, 'w') as f:
       f.write("[docker-ce-stable]\n")
       f.write("name=test\n")
       f.write("baseurl=%s\n" %repo_url)
       f.write("enabled=1\n")
       f.write("gpgcheck=0\n")

def setupRepoSrc():
    httpDst = '/var/www/html/rpmPackage'
    
    #os.system("yum install -y httpd")
    os.system("systemctl start httpd")
    if os.path.exists('/var/www/html'):
        if os.path.exists(httpDst):
            print ("rpmPackage exist, need not copy")
        else:
            shutil.copytree("../rpmPackage", httpDst)
    else:
        print ('can not copy rpm files')

if __name__ == "__main__":
    setupRepoSrc()
    hostIp = socket.gethostbyname(socket.gethostname())
    repo_url = "http://" + hostIp + "/rpmPackage"
    os.system("curl %s" %repo_url)
    generateRepo(repo_url)
