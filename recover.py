import os
import subprocess
import time

root_dir = 'D:\\recovered_mixed\\gitlab_backup\\data_backup\\var.opt.gitlab\\git-data\\repositories'

for d in os.listdir(root_dir):
    d_path = root_dir + "\\" + d
    for git_repo in os.listdir(d_path):
        g_path = d_path + "\\" + git_repo
        x_path = d + "\\" + git_repo.replace(".git", "")
        if not ".wiki" in x_path and not "cispa" in x_path and not "Umbra" in x_path:
            cmd = "git clone {} {}".format(g_path, x_path).split(" ")      
            cmd_r = ["rm" , "-rf", "{}\\{}\\.git".format(os.getcwd(), x_path)]
            print(cmd_r)
            subprocess.run(cmd)
            time.sleep(1)
            subprocess.run(cmd_r)