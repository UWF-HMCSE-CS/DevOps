import groovy.json.JsonSlurper

// Parsing the push notification to get the repo's url
@NonCPS
def urlParse(def json)
{
    new groovy.json.JsonSlurper().parseText(json).repository.ssh_url
}

// Parsing the push notification to get the repo's branch
@NonCPS
def branchParse(def json)
{
    new groovy.json.JsonSlurper().parseText(json).ref
}

node('docker_box')
{

    // Cloning the updated git repo
    stage 'Git Checkout'

    // Updating tester repo
    dir('/home/ec2-user/workspace/DevOps-Pipeline')
    {
        try
        {
            //checkout([$class: 'GitSCM', branches: [[name: '*/feature']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'a45530f8-d465-42dc-b7c6-5eefc38cb814', url: 'https://github.com/ncoop57/DevOps-Pipeline.git']]])

            sh "git pull"
            sh "git checkout feature"
        }
        catch(e)
        {
            currentBuild.result = "FAILURE"
        }
    }

    // Grabbing the repo's url
    def url = urlParse(payload)

    // Parsing the url to grab the repo's name
    def repo = url.tokenize('/')[1].tokenize('.')[0]

    // Grabs the branch that was updated
    def branch = branchParse(payload).tokenize('/')[2].trim()

    if(branch != "master")
    {
    	// Changing directories
        dir("/home/ec2-user/workspace/jenkins_pipeline/")
        {
            try
            {
                // Cloning in the new repo to the current directory
                sh "git clone ${url}"
            }
            catch(e)
            {
                currentBuild.result = "FAILURE"
            }
        }

        // Starting static analysis testing
        stage 'Static Analysis'

        // Changing directories
        dir("/home/ec2-user/workspace/jenkins_pipeline/${repo}")
        {
            sh "git checkout ${branch}"
        }

        // Building Gadget Docker image
        sh "docker build -t pipeline /home/ec2-user/workspace/DevOps-Pipeline/tests/phpcs/Gadget"

        try
        {
            // Running PHP tests
            sh "docker run -v /home/ec2-user/workspace/jenkins_pipeline/${repo}:/pipeline --rm pipeline"
        }
        catch(e)
        {
            currentBuild.result = "UNSTABLE"
        }


        // Building phpcs Index Docker image
        sh "docker build -t pipeline /home/ec2-user/workspace/DevOps-Pipeline/tests/phpcs/Index"

        try
        {
            // Running PHP tests
            sh "docker run -v /home/ec2-user/workspace/jenkins_pipeline/${repo}:/pipeline --rm pipeline"
        }
        catch(e)
        {
            currentBuild.result = "UNSTABLE"
        }


        // Building phpcs Tester Docker image
        sh "docker build -t pipeline /home/ec2-user/workspace/DevOps-Pipeline/tests/phpcs/Tester"

        try
        {
            // Running PHP tests
            sh "docker run -v /home/ec2-user/workspace/jenkins_pipeline/${repo}:/pipeline --rm pipeline"
        }
        catch(e)
        {
            currentBuild.result = "UNSTABLE"
        }

        if(currentBuild.result != "FAILURE")
        {
            echo currentBuild.result
            // Starting Unit Tests
            stage 'Unit Tests'    // Building localphpunit Docker image

            sh "docker build -t pipeline /home/ec2-user/workspace/DevOps-Pipeline/tests/localphpunit"

            try
            {
                // Running PHP tests
                sh "docker run -v /home/ec2-user/workspace/jenkins_pipeline/${repo}:/pipeline --rm pipeline"
            }
            catch(e)
            {
                currentBuild.result = "FAILURE"
            }
        }

        if(currentBuild.result != "FAILURE")
        {
            // Starting Integration Test
            stage 'Integration Test'

            if (currentBuild.result != "FAILURE")
            {

                // Building phpunit integration Docker image
                sh "docker build -t pipeline /home/ec2-user/workspace/DevOps-Pipeline/tests/phpunit"

                try
                {
                    // Running PHP tests
                    sh "docker run -v /home/ec2-user/workspace/jenkins_pipeline/${repo}:/pipeline --rm pipeline"
                }
                catch(e)
                {
                    currentBuild.result = "FAILURE"
                }

            }
            else echo 'Skipping Integration'
        }

        if(currentBuild.result != "FAILURE")
        {
            // Starting Staging
            stage 'Staging'

            if (currentBuild.result != "FAILURE")
            {

                // Starting stage

                try
                {
                    // Running PHP tests
                    //sh "bash /home/ec2-user/workspace/DevOps-Pipeline/tests/stage/createSTAGE.sh"
                    sh "bash /home/ec2-user/workspace/DevOps-Pipeline/tests/push/push.sh ${repo}"
                }
                catch(e)
                {
                    currentBuild.result = "FAILURE"
                }

            }
            else echo 'Skipping Staging'
        }

        // Starting Merge
        stage 'Merging'
        dir("/home/ec2-user/workspace/jenkins_pipeline/${repo}")
        {
            sh "git checkout master"
            sh "git merge ${branch}"
            sh "git push ${url} master"
        }

        // Starting BackUp
        stage 'BackUp'
        dir("/home/ec2-user/workspace/jenkins_pipeline/")
        {
            sh "sudo cp -r ${repo}/ /home/ec2-user/workspace/DevOps-Pipeline/tests/stage/backUps/"
        }

        dir("/home/ec2-user/workspace/DevOps-Pipeline/")
        {
            sh "sudo -u ec2-user git push"
        }

        // Starting Cleanup
        stage 'Repo Cleanup'

        // Removing the repo after the tests are complete
        sh "rm -rf /home/ec2-user/workspace/jenkins_pipeline/${repo}"
        sh "rm -rf /home/ec2-user/workspace/jenkins_pipeline/${repo}\\@tmp"

    }
    else echo "Cannot test master branch"
}
