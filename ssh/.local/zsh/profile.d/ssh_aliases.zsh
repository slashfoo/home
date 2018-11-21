alias ssh-gen-config='\save-a-copy ~/.ssh/config && \assemble-config -v -F -f ~/.ssh/config -V sshconfig'
alias ssh-noctrl='\ssh -o ControlMaster=no -o ControlPath=none'
alias ssh-yolo='\ssh -o ControlMaster=no -o ControlPath=none'
