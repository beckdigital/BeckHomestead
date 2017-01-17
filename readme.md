# Development & Deployment Strategy

## Local Development

A customized fork of Laravel Homestead will be used for local development. This document contains the necessary information to get setup for local development including additional configuration and daily workflow. To learn more about Laravel Homestead, visit https://laravel.com/docs/5.3/homestead.

### Requirements
- Terminal / iTerm
    - Terminal comes preinstalled with macOS.
    - iTerm gives you more customization. Download at https://www.iterm2.com/.
- Git
    - Version control manager
    - Download at https://git-scm.com/download.
    - Configure with your name and email address.
        - `git config --global user.name "Your name"`
        - `git config --global user.email "Your email address"`
- VirtualBox
    - Runs virtual machines.
    - Download at https://www.virtualbox.org/wiki/Downloads.
- Vagrant
    - Provides an easy way to manage and provision virtual machines.
    - Download at https://www.vagrantup.com/downloads.html.
- Sequel Pro
    - Connect to and manage databases.
    - Download at https://sequelpro.com/download.

### Setup
1. Add the Laravel Homestead vagrant box
    - `vagrant box add laravel/homestead --box-version 0.5.0`
2. Clone BeckHomestead (a customized fork of Laravel Homestead)
    - `cd ~ && git clone https://github.com/beckdigital/BeckHomestead.git`
3. Add beck aliases to .bashrc
    - `nano ~/.bashrc`
    - `source ~/BeckHomestead/aliases.sh`
4. Add domains to hosts file
    - `sudo nano /etc/hosts`
    - `192.168.10.20  l.givewell.missionphilanthropy.org`
5. Restart your terminal session or source .bashrc
    - `source ~/.bashrc`
6. Launch BeckHomestead
    - `beck up`
7. Connect to the database
    - Connection Name: Beck Homestead
    - Host: 127.0.0.1
    - Port: 33060 (MySQL), 54320 (Postgres)
    - U/P: homestead / secret
8. Import data dumps
9. Access your site
    - Visit l.givewell.missionphilanthropy.org.

### Updating Configuration / Provisioning
1. Open configuration file
    - `~/BeckHomestead/.configuration/Homestead.yaml`
2. Edit configuration
    - Add sites

    ```
    sites:
        - map: l.givewell.missionphilanthropy.org
          to: /home/vagrant/projects/missionphilanthropy.org/givewell/www/httpdocs
    ```

    - Add databases

    ```
    databases:
        - l_givewell_missionphilanthropy_org
        - l_cms_givewell_missionphilanthropy_org
    ```

3. Reprovision
    - `beck reload --provision`
4. Adjust after.sh if needed
    - `~/BeckHomestead/.configuration/after.sh`

### Daily Usage
- `beck-ssh`
    - Aliased to `bssh`
    - SSH into the vagrant box and cd to the current project folder.
- `beck halt`
    - Shut down the vagrant box.
- `beck up`
    - Needed after shutdown of the vagrant box or host machine.
- Git commands can be run either inside or outside of the vagrant box

## Version Control Management

Git alongside Git Flow will be used for version control management. Git Flow is a tool that provides easy to use commands for a well-structured branching model.

### Requirements
- Git
    - Version control manager
    - Download at https://git-scm.com/download.
    - Configure with your name and email address.
        - `git config --global user.name "Your name"`
        - `git config --global user.email "Your email address"`
- Git Flow
    - Branching model
    - Install via the instructions found here: https://github.com/nvie/gitflow/wiki/Mac-OS-X

### Introduction / Cycle

The Git Flow branching model uses branches for features, releases, and hotfixes as well as the persistent branches master and develop.

- The **master** branch should always be a reflection of production.
- The **develop** branch should contain code that will soon be on production.
- A **feature** branch will be created from develop and should remain isolated until it is production ready. At which time, it gets merged into develop for further testing and release.
- A **release** branch will be created from develop for the purpose of final testing and release to the master branch. Small changes may be made to this branch prior to release to master.
- A **hotfix** branch will be created from master in order to fix small bugs in the production codebase. Once finished, the hotfix will be merged directly into master and back-merged into develop.
- Read more about this branching model at http://nvie.com/posts/a-successful-git-branching-model/.

### Setup
- Initialize Git Flow: `git flow init`
    - Accept the defaults.
    - This command must be run on each local machine one time per project.
    - The first person to run `git flow init` will need to push the new develop branch if it's not already on the remote repository.
- Ensure your git tags are in the correct order
    - `git config --global tag.sort version:refname`

### Daily Usage
- Features
    - Before starting a new feature, make sure your develop branch is up to date: `git checkout develop && git pull`
    - Start your feature with: `git flow feature start my-cool-new-feature`
        - This will create a branch based off of develop called feature/my-cool-new-feature.
    - If necessary, you can push your feature branch to the remote with: `git flow feature publish`
    - Finish your feature with: `git flow feature finish my-cool-new-feature`
        - This will merge your feature branch into develop and delete your feature branch.
        - Prior to finishing your feature, it's good practice to pull on develop and merge or rebase develop into your feature branch. This will ensure a smooth merge into develop.
- Releases
    - Before starting a new release, make sure your develop branch is up to date: `git checkout develop && git pull`
    - Find the latest tag with `git tag` and decide what your next tag will be.
    - Start your release with: `git flow release start v1.2.0`
        - This will create a branch based off of develop called release/v1.2.0.
    - Push the branch up to remote for testing.
    - Finish your release with: `git flow release finish v1.2.0`
        - This will merge your release branch into both develop and master.
        - It will prompt you for a release message and tag the master branch v1.2.0.
    - Push your new tag to remote with: `git push origin --tags`
- Hotfixes
    - Before starting a new hotfix, make sure your master branch is up to date: `git checkout master && git pull`
    - Find the latest tag with `git tag` and decide what your next tag will be.
    - Start your hotfix with: `git flow hotfix start v1.2.1`
        - This will create a branch based off of master called hotfix/v1.2.1.
    - Push the branch up to remote if necessary.
    - Finish your hotfix with: `git flow hotfix finish v1.2.1`
        - This will merge your hotfix branch into both develop and master.
        - It will prompt you for a hotfix message and tag the master branch v1.2.1.
    - Push your new tag to remote with: `git push origin --tags`

## Deployment

Envoyer will be used to easily deploy builds to the server. You can create projects for testing and production, add servers, and set up optional deployment hooks. Then you can deploy any branch or tag to the server for the given project.

### Requirements
- An active Envoyer account
    - Sign up at https://envoyer.io/.

### Setup
- Add Project
    - Name: i.e. test.givewell.missionphilanthropy.org
    - Type: Other
    - Repository: beckdigital/givewell.missionphilanthropy.org
- Servers > Add Server
    - Name
    - IP Address
    - Port
    - Connect As: user on the remote server
    - Project Path: full path from root
- Add the provided SSH key to the server.
- Deployment Hooks
    - Set up any necessary deployment hooks.

### Daily Usage
- Access Envoyer
- Access your project
- Deploy
    - Default branch
    - Different branch
    - Tag
