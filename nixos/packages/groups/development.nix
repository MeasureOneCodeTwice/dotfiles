pkgs:  #a function that takes a paramater named "pkgs" and returns another function called "unstable"
with pkgs; # adds values "pkgs" to the scope;w
unstable:
[
    unstable.awscli2
    tenv
        
    man-pages
    man-pages-posix
    git
    github-cli
    gitlab-runner

    bash-language-server

    postman
    dos2unix
]
