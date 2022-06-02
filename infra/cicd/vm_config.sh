#!/bin/bash




# Initial config like hostname, timezone, etc...
function stage_0() {
    echo "##################"
    echo "starting stage 0"

    HOSTNAME="cicd-jenkins"
    TIMEZONE="Europe/Lisbon"

    echo "setting hostname to: $HOSTNAME"
    hostnamectl set-hostname $HOSTNAME

    echo "setting timezone to: $TIMEZONE"
    timedatectl set-timezone $TIMEZONE

    echo "Update apt index"
    apt-get update -y

    echo "installing java"
    apt-get install openjdk-11-jre -y

    echo "stage 0 ended"
    echo "##################"
}

# Install Jenkins
function stage_1 {
    echo "##################"
    echo "starting stage 1"

    curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | tee \
        /usr/share/keyrings/jenkins-keyring.asc > /dev/null

    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
        https://pkg.jenkins.io/debian-stable binary/ | tee \
        /etc/apt/sources.list.d/jenkins.list > /dev/null

    echo "updating packages index"
    apt-get update -y

    echo "installing jenkins as a service"
    apt-get install jenkins -y

    echo "stage 1 ended"
    echo "##################"
}


function main() {
    stage_0
    stage_1
}

main