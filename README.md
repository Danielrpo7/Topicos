# TopicosEnTelematica
Proyecto de la materia Tópicos Telemática Universidad Eafit

by Daniel Restrepo Aristizabal - drestr84@eafit.edu.co

## 1. Create a new Ruby Aplication
  rails new "NameyourApp"
  
## 2. Starting up the WebApp Server
 
  rails server
 
 * Open browser: http://localhost:3000
 
## 3. Main page: "Hello World"
 
   rails generate controller Welcome index
 
   edit:
   app/views/welcome/index.html.erb
   config/routes.rb
   
## 4. Editing routes
  =begin
  resources :images
  devise_for :users
  get 'welcome/index'
  root 'images#index'
 =end
 
## 5. Generate CRUD for Images
   rails generate scaffold Images tittle:String description:text private:bool filesize:String
  

## 6. Running a migration
   rails db:migrate
   ## include postgresql in test and production environment:
   test:
  database: topicface
  adapter: postgresql
  pool: 5
  username: drestr84
  password: wboPG47
  host: localhost
  port: 5432

production:
  database: topicface
  adapter: postgresql
  pool: 5
  username: drestr84
  password: wboPGL47
  host: localhost
  port: 5432

 ## 7. Creating Images
 def create
    @image = Image.new(image_params)

    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, notice: 'Image was successfully created.' }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end
  
  ## 8. Updating Images
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end
  ## 9. deleting Images
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  
    
## Deployment on Heroku

  *heroku login
  
  *heroku create
  
  *git add .
  
  *git commit -am "Deploy on Heroku"
  
  *git push heroku master
  
## Deployment on DCA

# 1. Deploy the Article Web App on Linux Centos 7.x (test)
 
 ## Install ruby and rails
 
 * references:
 
      https://www.digitalocean.com/community/tutorials/how-to-use-postgresql-with-your-ruby-on-rails-application-on-centos-7
 
 
 * Connect remote server: (user1 is a sudo user)
 
      local$ ssh user1@10.131.137.229
      Password: *****
 
      user1@test$
 
 * verify and install rvm, ruby, rails, postgres and nginx
 
 * install rvm (https://rvm.io/rvm/install)
 
      user1@test$ gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
 
      user1@test$ \curl -sSL https://get.rvm.io | bash
 
 * reopen terminal app:
 
      user1@test$ exit
 
      local$ ssh user1@10.131.137.229
      Password: *****
 
 * install ruby 2.4.1
 
      user1@test$ rvm list known
      user1@test$ rvm install 2.4.1
 
 * install rails
 
      user1@test$ gem install rails
 
 ## install postgres:
 
   user1@test$ sudo yum install -y postgresql-server postgresql-contrib postgresql-devel
   Password: *****
 
   user1@test$ sudo postgresql-setup initdb
 
   user1@test$ sudo vi /var/lib/pgsql/data/pg_hba.conf
 
   original:
 
         host    all             all             127.0.0.1/32            ident
         host    all             all             ::1/128                 ident
 
         updated:
 
         host    all             all             127.0.0.1/32            md5
         host    all             all             ::1/128                 md5
 
 * run postgres:
 
         user1@test$ sudo systemctl start postgresql
         user1@test$ sudo systemctl enable postgresql
 
 * Create Database User:
 
         user1@test$ sudo su - postgres
 
         user1@test$ createuser -s pguser
 
         user1@test$ psql
 
         postgres=# \password pguser
         Enter new password: changeme
 
         postgres=# \q
 
         user1@test$ exit
 
 ## Setup RAILS_ENV and PORT (3000 for dev, 4000 for testing or 5000 for production)
 
         user1@test$ export RAILS_ENV=test
         user1@test$ export PORT=3001
 
 ## open PORT on firewalld service:
 
         user1@test$ sudo firewall-cmd --zone=public --add-port=4000/tcp --permanent
         user1@test$ sudo firewall-cmd --reload
 
 ## clone de git repo, install and run:
 
         user1@test$ cd Documents
         user1@test$ git clone https://github.com/st0263eafit/rubyArticulosEM.git
         user1@test$ cd TopicosTelematica
         user1@test$ cd trabajo
         user1@test$ bundle install
         user1@test$ rake db:drop db:create db:migrate
         user1@test$ export RAILS_ENV=test
         user1@test$ export PORT=3001 
         user1@test$ rails server
 
 
   Prefix    Verb   URI Pattern                                Controller#Action
 +                               GET "/images" index                welcome#index
                                 POST "/images" create              images#create
                                 DELETE "/images/:id" destroy       images#destroy
                                 GET "/images/:id" show             images#show
                                 GET "/images/new" new              images#new
                                 GET "/images/:id/edit" edit        images#edit
                                 PATCH "/images/:id" update         images#update
                                 PUT "/images/:id" update           images#update
 +                    root       GET  welcome/index                   welcome#index
