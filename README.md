# README

* This app was developed with rails 6.0.3.4 and postgresql as database.
* The repository where you can watch and download the source code is located in my own github account, this is the url: https://github.com/pordnajela/contacts
* In .env.example file you can see two environment variables in order to setup the database for this rails project

In order to run the app you will need a posgresql server (service) or a docker instance for this purpose
Run: 
* Download the project cloning the repo or from ZIP file
* Maybe you need install ruby 2.7.1 with rvm or rbenv
* bundle install (to download and install dependecies)
* rails db:create
* rails db:migrate
* yarn install (to create the node_modules and compiling some assets like bootstrap)
* rails server
#### Also, the project is deployed with a hobby dyno in heroku, this is the link to the app: https://shielded-crag-87160.herokuapp.com/. BTW, if you want you can use a exist user with email: saps9529@gmail.com and password: pass123ABC

 Basically, when you open for first time there is a navbar where you can go to login and signup page.

 Later when you has created you user, you will be redirected to contacts page, here there are 3 links and the form to upload you csv file. The links redirects you to:
 * Listar todos los contactos: This page list all contacts for your user with all details and the csv name
 * Listar contactos fallidos: This page shows another table with the failed contacts and in each column where the word "INCORRECTO" is present, is the field where the created proccess failed.
 * Listar archivos cargados: This page shows a table with 2 columns, name of the csv file and its respective status
 * Finnaly, you can upload your csv file using the button with label: "Choose file" and submit in order to try to create you csv file