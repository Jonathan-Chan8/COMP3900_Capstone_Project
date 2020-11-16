README for The Newsroom application

# SETUP  

1. See INSTALL.md for installion instruction for the operating systems WINDOWS 10 / LINUX (UBUNTU) / MAC OSX

2. `git clone ttps://github.com/unsw-cse-capstone-project/capstone-project-comp3900-w17a-212-monolith.git`

3. Two termials are required for this step. One for running the database and one for running the front end.

## First teminal, Starting docker-compose to run
1. cd into the project folder. 
2. `cd /theNewsroom/API`
3. Execute the following command `sudo docker-compose up` on Linux/Windows 
or just `docker-compose up` on MAC OSX

(to tear it down, do `docker-compose down` in the same directory.)

## start a second terminal
1. cd into the project folder. 
2. `cd /theNewsroom/front-end-client`
3. `npm install`
4. PORT=3000 npm run dev

To see the website now visit localhost:3000 in a browser.
