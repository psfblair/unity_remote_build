# Unity Remote Build Infrastructure

These are files intended to be added to a Unity project to allow building
Windows Store Apps on a remote Windows server. First a Unity build is run
(targeting Windows Store - this can be changed in Assets/Editor/build.js)
and then the resulting Visual Studio project is built with the x86 Release
configuration (which can be changed in msbuild_headless.bat).

## Prerequisites

You'll need to install ssh, Unity, and Visual Studio on the remote machine. 
You'll also need to open Unity to activate it.

See http://seriouscodeblog.blogspot.ca/2017/03/write-hololens-apps-on-macos-linux-1.html
for more details about remote build server setup.

## Installation

1. Add the files from this project to your Unity project. Note that if you have
customizations to your own .gitignore file you may not want to simply clobber 
the one you already have with the one in this project.

   You can pull down the files in the master branch of this repository and unzip
   them into your project using the command

       curl https://codeload.github.com/psfblair/unity_remote_build/zip/master | tar --strip-components 1 -xvpzf -

2. Create an environment file based on modifying the settings in env.sh.sample
(or env.bat.sample, depending on your OS) to the values appropriate to your 
environment.

# Execution

1. You should create a git repository on the remote server to which you can
push your changes to local code. Once you have creatd the remote repository
with `git init`, you should issue the git command to allow you to push to a 
checked-out (non-bare) repository:

        cd [PROJECT_NAME]
        # Allow pushing to checked-out (non-bare) repository
        git config receive.denyCurrentBranch updateInstead

2. Load the environment variables you set up in env.sh or env.bat.

3. If you are connecting to a remote machine that doesn't have a fixed IP
address, and you can download an *.rdp file for that host to your local
downloads directory, use the `update_remote_ip.sh` script to modify your
`/etc/hosts` file to alias the value of the `REMOTE_HOST` environment 
variable to that IP address. Note that the first time you run this script 
you will need to initialize your `/etc/hosts` file with a line for that
host alias, e.g.

        0.0.0.0 holodevelop

4. Set up the remote of your local Git repository to point to the remote
server's Git repository:

       git remote add holodevelop ssh://[USER]@[HOST]/[PATH-TO-PROJECT-WITH-FORWARD-SLASHES]

   Now you should be able to push to the remote repository with a command such as

       git push holodevelop master

5. If you are using dlls or other plugins that you do not want to commit to
source control, the easiest thing to do is to mount the project directory on 
the remote machine. When you build the dll locally, have a post-build step
copy it to the Assets/Plugins directory in the mounted folder.

   The `update_remote_ip.sh` script already tries to mount the remote `/Users`
   directory to the location specified by the `LOCAL_MOUNT_POINT` environment 
   variable.

   You can find copy scripts suitable for post-build configurations in the
   GitHub repository

       https://github.com/psfblair/unity_fsharp

6. Once the code and any necessary dlls have been pushed you should be able 
to run `remote_build.sh` (or `remote_build.bat`) to run the build on the 
remote server.

## Troubleshooting

If the Unity build hangs, it may be because Unity thinks it hasn't been 
activated. Access the remote server using the remote desktop and make sure
you can open Unity.

If you can't push to the remote repository, it may be that there are changed
files in the remote workspace. You'll need to either commit or revert them;
if you commit, you'll want to pull them into your local workspace and merge
before you push your changes.

If you are writing your project on OS X or Linux, you won't be able to set all 
the necessary Unity player settings and build settings on your local workstation,
since on those platforms the Windows Store application build options are not
available. After pushing your code you'll need to open it once in Unity on
the remote server to set the appropriate settings. Save the project and commit
the changes, then pull them to your local repository.