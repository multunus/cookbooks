# Deployment Process


Bring up the new ubuntu 12.04 instance using cloud console  # Incase
we are using AWS make sure that the ports 22,26487 and 80 are open in the security group

* setup the correct value for the host in the corresponding capistrano stage
* git submodule init 
* git submodule update -- for checking out third party chef scripts
* create the  file 'config/server_setup_parameters.yml' -- This file contains all the passwords for mysql etc. There is a sample file checked in 'config/server_setup_parameters.ym.example'
* cap staging deploy:new  -- Run this task only during first deploy. 
* cap staging deploy:migrations 


# Common Problems 

# The git checkout errors out while running cap deploy with the following error message
    
    Permission denied (publickey).
    
    fatal: The remote end hung up unexpectedly


The capistrano script depends on the ssh agent forwarding to work on the machine from where you are running the deploy command.
This article descirbes how to enable port forwarding. http://blog.new-bamboo.co.uk/2009/11/02/solving-a-problem-of-non-working-key-forwarding-with-capistrano
 

